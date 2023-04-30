import 'dart:io';
import 'dart:typed_data';

import 'package:Array_App/bloc/item/item_bloc.dart';
import 'package:Array_App/bloc/item/item_state.dart';
import 'package:Array_App/bloc/item/mix_and_match_cubit.dart';
import 'package:Array_App/core/route/app_navigator.dart';
import 'package:Array_App/core/route/app_route.dart';
import 'package:Array_App/domain/entity/entity.dart';
import 'package:Array_App/l10n/l10n.dart';
import 'package:Array_App/presentation/screen/mix_and_match/draggable_resizable_item.dart';
import 'package:Array_App/presentation/widget/button/button.dart';
import 'package:Array_App/presentation/widget/constant/box.dart';
import 'package:Array_App/presentation/widget/custom_app_bar.dart';
import 'package:Array_App/presentation/widget/indicator/custom_circular_progress_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:widgets_to_image/widgets_to_image.dart';

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
      file.writeAsBytesSync(bytes ?? <int>[]);
      BlocProvider.of<ItemBloc>(context)
          .add(RemoveBackground(filepath: file.path));
      BlocProvider.of<ItemBloc>(context).add(UpdateLookToAdd(lookToAdd));
      await AppNavigator.push<void>(AppRoute.lookProfile);
    }
  }
}
