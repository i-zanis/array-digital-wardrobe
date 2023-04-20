import 'dart:io';
import 'dart:typed_data';

import 'package:Array_App/core/route/app_navigator.dart';
import 'package:Array_App/l10n/l10n.dart';
import 'package:Array_App/presentation/widget/button/button.dart';
import 'package:Array_App/presentation/widget/custom_app_bar.dart';
import 'package:Array_App/presentation/widget/indicator/custom_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

import '../../../bloc/item/item_bloc.dart';
import '../../../bloc/item/item_state.dart';
import '../../../bloc/item/mix_and_match_cubit.dart';
import '../../../core/route/app_route.dart';
import '../../../domain/entity/item/item.dart';
import '../../../domain/entity/item/look.dart';
import '../../../main_development.dart';
import '../../widget/constant/box.dart';

class LookStudioScreen extends StatefulWidget {
  const LookStudioScreen({super.key});

  @override
  State createState() => _LookStudioScreenState();
}

class _LookStudioScreenState extends State<LookStudioScreen> {
  final GlobalKey _globalKey = GlobalKey();
  WidgetsToImageController controller = WidgetsToImageController();

  Widget buildImage(Uint8List bytes) => Image.memory(bytes);
  Uint8List? bytes;
  late final MixAndMatchCubit cubit = context.read<MixAndMatchCubit>();

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final items = cubit.state.items;
    return Scaffold(
      appBar: CustomAppBar(
        title: l10n.lookProfileScreenStudioTitle,
        subtitle: l10n.lookProfileScreenStudioSubtitle,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: BlocBuilder<ItemBloc, ItemState>(
        builder: (context, state) {
          if (state is ItemLoading) {
            return const Center(child: CustomCircularProgressIndicator());
          }
          return Column(
            children: [
              WidgetsToImage(
                key: _globalKey,
                controller: controller,
                child: SizedBox(
                  height: MediaQuery.of(context).size.height * 0.75,
                  width: double.infinity,
                  child: Stack(
                    children: items.map((item) {
                      return DraggableResizableItem(item: item);
                    }).toList(),
                  ),
                ),
              ),
              // Spacer(),
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: CustomFilledButton(
                    onPressed: _handleSave,
                    content: l10n.lookProfileScreenButtonSave,
                  ),
                ),
              ),
              Box.h16,
            ],
          );
        },
      ),
    );
  }

  Future<void> _handleSave() async {
    final imageBytes = await controller.capture();
    final items = cubit.state.items;
    final lookToAdd = Look(
      items: items,
    );
    setState(() {
      bytes = imageBytes;
    });
    if (mounted) {
      final tempDir = await getTemporaryDirectory();
      final file = await File('${tempDir.path}/image.png').create();
      file.writeAsBytesSync(bytes as List<int>);
      logger.i('looktoAdd: ${lookToAdd.items}');
      BlocProvider.of<ItemBloc>(context)
          .add(RemoveBackground(filepath: file.path));
      BlocProvider.of<ItemBloc>(context).add(UpdateLookToAdd(lookToAdd));
      await AppNavigator.push<void>(AppRoute.lookProfile);
    }
  }
}

class DraggableResizableItem extends StatefulWidget {
  const DraggableResizableItem({super.key, required this.item});

  final Item item;

  @override
  State createState() => _DraggableResizableItemState();
}

class _DraggableResizableItemState extends State<DraggableResizableItem> {
  static const double _minSize = 150.0;
  static const double _maxSize = 300.0;

  double _width = 200;
  double _height = 300;
  bool _scaling = false;
  Offset _itemPosition = const Offset(0, 0);

  void _updateSize(double scale) {
    setState(() {
      final newScale = 1.0 + (scale - 1.0) / _maxSize;
      _width *= newScale;
      _height *= newScale;
      _width = _width.clamp(_minSize, _maxSize);
      _height = _height.clamp(_minSize, _maxSize);
    });
  }

  @override
  Widget build(BuildContext context) {
    final hasImage = widget.item.imageData != null;
    return Positioned(
      top: _itemPosition.dy,
      left: _itemPosition.dx,
      child: _gestureDetector(hasImage),
    );
  }

  GestureDetector _gestureDetector(bool hasImage) {
    return GestureDetector(
      onScaleStart: (details) => _scaling = true,
      onScaleUpdate: _handleScaleUpdate,
      onScaleEnd: (details) => _scaling = false,
      child: _itemImage(hasImage),
    );
  }

  void _handleScaleUpdate(ScaleUpdateDetails details) {
    setState(() {
      _itemPosition += details.focalPointDelta;
      if (_scaling && details.scale != 1.0) {
        _updateSize(details.scale);
      }
    });
  }

  Widget _itemImage(bool hasImage) {
    return SizedBox(
      width: _width,
      height: _height,
      child: hasImage
          ? Image.memory(
              widget.item.imageData!,
              fit: BoxFit.contain,
            )
          : Container(color: Colors.grey),
    );
  }
}
