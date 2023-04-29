import 'package:Array_App/bloc/item/item_bloc.dart';
import 'package:Array_App/bloc/item/item_state.dart';
import 'package:Array_App/config/style_config.dart';
import 'package:Array_App/core/route/app_navigator.dart';
import 'package:Array_App/core/route/app_route.dart';
import 'package:Array_App/domain/entity/entity.dart';
import 'package:Array_App/l10n/l10n.dart';
import 'package:Array_App/presentation/screen/look_book/look_book_component.dart';
import 'package:Array_App/presentation/widget/indicator/custom_circular_progress_indicator.dart';
import 'package:Array_App/presentation/widget/widget.dart';
import 'package:Array_App/rest/util/util_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../main_development.dart';

class LookProfileScreen extends StatefulWidget {
  const LookProfileScreen({super.key});

  @override
  State createState() => _LookProfileScreenState();
}

class _LookProfileScreenState extends State<LookProfileScreen> {
  late TextEditingController nameController = TextEditingController();
  late TextEditingController tagController = TextEditingController();
  late TextEditingController otherController = TextEditingController();
  List<TextEditingController> controllers = [];
  bool isReadOnly = false;
  late final Look lookToAdd;
  late final ItemBloc itemBloc;

  @override
  void initState() {
    super.initState();
    itemBloc = BlocProvider.of<ItemBloc>(context);
    lookToAdd = itemBloc.state.lookToAdd ?? Look.empty();
    controllers = [nameController, tagController, otherController];
    _initializeTextControllers(lookToAdd);
    final isLookNew = lookToAdd.id != null;
    if (isLookNew) {
      isReadOnly = true;
    }
  }

  @override
  void dispose() {
    for (final controller in controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final labelTextStyle = Theme.of(context).textTheme.labelLarge?.copyWith(
              color: Theme.of(context).colorScheme.onTertiaryContainer,
            ) ??
        const TextStyle();
    final inputFieldFillColor = Theme.of(context).colorScheme.tertiaryContainer;
    final borderColor = Theme.of(context).colorScheme.tertiary;
    final l10n = context.l10n;
    final textStyleSecondRow = Theme.of(context)
        .textTheme
        .labelSmall
        ?.apply(color: Theme.of(context).colorScheme.secondaryContainer);
    const borderRadius = BorderRadius.all(
      Radius.circular(Styles.borderRadiusS),
    );
    final surface = Theme.of(context).colorScheme.surface;
    final shadowColor = Theme.of(context).colorScheme.shadow;
    final surfaceTint = Theme.of(context).colorScheme.surfaceTint;

    return Scaffold(
      appBar: CustomAppBar(
        title: _getTitle(context),
        subtitle: _getSubtitle(context),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Styles.defaultPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  const Spacer(),
                  Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      color: Theme.of(context).colorScheme.tertiary,
                      icon: const Icon(Icons.edit),
                      onPressed: _handleEditButton,
                    ),
                  ),
                ],
              ),
              Box.h16,
              NameInputField(
                field: l10n.lookProfilePlaceholderLookName,
                controller: nameController,
                fillColor: inputFieldFillColor,
                borderColor: borderColor,
                isEditingMode: isReadOnly,
              ),
              // Box.h16,
              _imageSection(lookToAdd),
              Box.h16,
              const ItemsInThisLookSection(),
              // const TagSection(),
              Box.h16,
              _bottomButton(context, itemBloc, l10n, isReadOnly),
            ],
          ),
        ),
      ),
    );
  }

  Widget _bottomButton(
    BuildContext context,
    ItemBloc itemBloc,
    AppLocalizations l10n,
    bool isReadOnly,
  ) {
    return !isReadOnly
        ? CustomFilledButton(
            onPressed: () {
              logger.i('itemBloc.state.lookToAdd: ${itemBloc.state.lookToAdd}');
              _handleBottomButton(
                itemBloc.state.lookToAdd,
                nameController,
                otherController,
                context,
                l10n,
              );
            },
            content: l10n.lookProfileScreenButtonSave,
          )
        : Container();
  }

  void _initializeTextControllers(Look? lookToAdd) {
    if (lookToAdd != null) {
      nameController.text = getStringOrDefault(lookToAdd.name);
    }
  }

  Widget _imageSection(Look? lookToAdd) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.44,
      width: MediaQuery.of(context).size.width,
      child: _getImageSection(lookToAdd),
    );
  }

  Widget _getImageSection(Look? lookToAdd) {
    return BlocBuilder<ItemBloc, ItemState>(
      builder: (context, state) {
        final hasImage = state.lookToAdd?.lookImageData != null;
        if (state is ItemLoading) {
          return const Center(
            child: CustomCircularProgressIndicator(),
          );
        }
        if (state is ItemLoaded) {
          return Stack(
            children: [
              if (hasImage)
                Align(
                  child: Image(
                    image: MemoryImage(state.lookToAdd!.lookImageData!),
                    fit: BoxFit.cover,
                  ),
                ),
              Align(
                alignment: Alignment.centerRight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(Styles.paddingS),
                      child: _favoriteButton(),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(Styles.paddingS),
                      child: _deleteButton(),
                    )
                  ],
                ),
              ),
            ],
          );
        }
        return Container();
      },
    );
  }

  FavoriteButton _favoriteButton() {
    return FavoriteButton(
      item: context.read<ItemBloc>().state.itemToAdd ?? Item.empty(),
      onFavoriteToggle: (updatedItem) {
        BlocProvider.of<ItemBloc>(context).add(
          UpdateItemToAdd(updatedItem),
        );
      },
    );
  }

  Widget _deleteButton() {
    return InkWell(
      onTap: _handleDelete,
      child: Icon(Icons.delete, color: Theme.of(context).colorScheme.tertiary),
    );
  }

  void _handleDelete() {
    BlocProvider.of<ItemBloc>(context).add(
      DeleteItem(context.read<ItemBloc>().state.itemToAdd!),
    );
    AppNavigator.push<void>(AppRoute.root);
  }

  // TODO(jtl): create dynamic text for readonly
  String _getTitle(BuildContext context) {
    return context.l10n.lookProfileScreenTitleNew;
  }

  // TODO(jtl): create dynamic text for readonly
  String _getSubtitle(BuildContext context) {
    return context.l10n.lookProfileScreenSubtitleNew;
  }

  Future<void> _handleBottomButton(
    Look? lookToAdd,
    TextEditingController nameController,
    TextEditingController otherController,
    BuildContext context,
    AppLocalizations l10,
  ) async {
    final look = Look(
      id: lookToAdd?.id,
      name: nameController.text,
      lookImageData: lookToAdd?.lookImageData,
      description: otherController.text,
      items: lookToAdd?.items ?? [],
      userId: lookToAdd?.userId ?? 1,
    );
    _save(context, look, l10);
  }

  void _save(BuildContext context, Look look, AppLocalizations l10) {
    logger.i('Saving look: $look');
    if (look.id == null) {
      context.read<ItemBloc>().add(
            SaveLook(look),
          );
    } else {
      context.read<ItemBloc>().add(
            UpdateLook(look),
          );
      //TODO(jtl): add snackbar back
      // ScaffoldMessenger.of(context).showSnackBar(
      //   SnackBar(
      //     content: Text(l10.LookProfileScreenNotificationSave),
      //   ),
      // );
    }
    AppNavigator.push<void>(AppRoute.root);
  }

  void _handleEditButton() {
    setState(() {
      isReadOnly = false;
    });
  }
}

class ItemsInThisLookSection extends StatelessWidget {
  const ItemsInThisLookSection({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final itemBloc = context.read<ItemBloc>();
    final itemToAdd = itemBloc.state.lookToAdd;
    final lookItems = itemBloc.state.lookToAdd?.items ?? [];
    return BlocBuilder<ItemBloc, ItemState>(
      builder: (context, state) {
        if (state is ItemLoaded) {
          return Wrap(
            alignment: WrapAlignment.center,
            children: lookItems
                .map(
                  (item) => LookBookComponent(
                    item: item,
                  ),
                )
                .toList(),
          );
        }
        return Container();
      },
    );
  }
}
