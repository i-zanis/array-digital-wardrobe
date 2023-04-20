import 'package:Array_App/bloc/item/item_bloc.dart';
import 'package:Array_App/config/style_config.dart';
import 'package:Array_App/core/route/app_navigator.dart';
import 'package:Array_App/core/route/app_route.dart';
import 'package:Array_App/domain/entity/item/item.dart';
import 'package:Array_App/l10n/l10n.dart';
import 'package:Array_App/presentation/screen/look_book/look_book_component.dart';
import 'package:Array_App/presentation/screen/look_book/tag_section.dart';
import 'package:Array_App/rest/util/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/item/item_state.dart';
import '../../../domain/entity/item/category.dart';
import '../../../domain/entity/item/look.dart';
import '../../../domain/entity/item/tag.dart';
import '../../../main_development.dart';
import '../../../rest/util/util_functions.dart';
import '../../widget/indicator/custom_circular_progress_indicator.dart';
import '../../widget/widget.dart';

class LookProfileScreen extends StatefulWidget {
  const LookProfileScreen({super.key});

  @override
  State createState() => _LookProfileScreenState();
}

class _LookProfileScreenState extends State<LookProfileScreen> {
  late TextEditingController nameController;
  late TextEditingController brandController;
  late TextEditingController sizeController;
  late TextEditingController colorController;
  late TextEditingController priceController;
  late TextEditingController tagController;
  late TextEditingController otherController;
  bool isReadOnly = false;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    brandController = TextEditingController();
    sizeController = TextEditingController();
    colorController = TextEditingController();
    priceController = TextEditingController();
    tagController = TextEditingController();
    otherController = TextEditingController();
    final isItemNew =
        BlocProvider.of<ItemBloc>(context).state.lookToAdd?.id != null;
    if (isItemNew) {
      isReadOnly = true;
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    tagController.dispose();
    otherController.dispose();
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
          child: BlocBuilder<ItemBloc, ItemState>(
            builder: (context, state) {
              final lookToAdd = state.lookToAdd;
              _initializeTextControllers(lookToAdd);
              return Column(
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
                  const TagSection(),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _bottomButton(Item? lookToAdd, BuildContext context,
      AppLocalizations l10n, bool isReadOnly) {
    return !isReadOnly
        ? CustomFilledButton(
            onPressed: () {
              handleSave(
                lookToAdd,
                nameController,
                brandController,
                sizeController,
                colorController,
                priceController,
                tagController,
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
                )
              else
                // TODO(jtl): require b events not executed in order
                const CustomCircularProgressIndicator(),
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

  Future<void> handleSave(
    Item? itemToAdd,
    TextEditingController nameController,
    TextEditingController brandController,
    TextEditingController sizeController,
    TextEditingController colorController,
    TextEditingController priceController,
    TextEditingController tagController,
    TextEditingController otherController,
    BuildContext context,
    AppLocalizations l10,
  ) async {
    logger.i('*** id: ${itemToAdd?.id} Fav: ${itemToAdd?.isFavorite}');
    final item = Item(
      id: itemToAdd?.id,
      createdAt: itemToAdd?.createdAt,
      name: nameController.text,
      brand: brandController.text,
      category: itemToAdd?.category ?? Category.OTHER,
      isFavorite: itemToAdd?.isFavorite ?? false,
      price: double.tryParse(priceController.text) ?? 0.0,
      // TODO(jtl): remove user hardcode id
      userId: itemToAdd?.userId ?? 1,
      imageData: itemToAdd?.imageData,
      imageLocalPath: itemToAdd?.imageLocalPath,
      notes: otherController.text,
      size: sizeController.text,
      tags: tagController.text
          .split(Constants.space)
          .map((e) => Tag(name: e))
          .toList(),
    );

    _save(context, item, l10);
  }

  void _save(BuildContext context, Item item, AppLocalizations l10) {
    context.read<ItemBloc>().add(
          SaveItem(item),
        );
    //TODO(jtl): add snackbar back
    // ScaffoldMessenger.of(context).showSnackBar(
    //   SnackBar(
    //     content: Text(l10.LookProfileScreenNotificationSave),
    //   ),
    // );
    AppNavigator.push(AppRoute.root);
  }

  Widget _inputField(
    String field,
    TextEditingController controller,
    TextStyle labelTextStyle,
    Color fillColor,
    Color borderColor,
    bool isEditingMode,
  ) {
    return Padding(
      padding: const EdgeInsets.all(Styles.paddingS),
      child: TextField(
        controller: controller,
        readOnly: isEditingMode,
        decoration: InputDecoration(
          // filled: true,
          // fillColor: fillColor,
          // enabled: false,
          labelText: field,
          labelStyle: labelTextStyle,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: borderColor),
          ),
          // focusedBorder: UnderlineInputBorder(
          //   borderSide: BorderSide(color: Colors.cyan),
          // ),
          // prefixIcon: Icon(
          //   Icons.label,
          //   color: Theme.of(context).colorScheme.tertiary,
          // ),
          // suffixIcon: Icon(
          //   Icons.edit,
          //   color: Theme.of(context).primaryColor,
          // ),
        ),
      ),
    );
  }

  Widget _textAreaInputField(
      String field,
      TextEditingController controller,
      TextStyle labelTextStyle,
      Color fillColor,
      Color borderColor,
      bool isEditMode) {
    // final labelTextStyle = Theme.of(context).textTheme.labelLarge;
    return Padding(
      padding: const EdgeInsets.all(Styles.paddingS),
      child: TextField(
        controller: controller,
        readOnly: isEditMode,
        decoration: InputDecoration(
          // filled: true,
          // fillColor: fillColor,
          labelText: field,
          labelStyle: labelTextStyle,
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: borderColor),
          ),
          // focusedBorder: UnderlineInputBorder(
          //   borderSide: BorderSide(color: Colors.cyan),
          // ),
          // prefixIcon: Icon(
          //   Icons.label,
          //   color: Theme.of(context).colorScheme.tertiary,
          // ),
          // suffixIcon: Icon(
          //   Icons.edit,
          //   color: Theme.of(context).primaryColor,
          // ),
        ),
        maxLines: 4,
        keyboardType: TextInputType.multiline,
      ),
    );

    //                   SizedBox(
    // width: 240, // <-- TextField width
    // height: 120, // <-- TextField height
    // child: TextField(
    // maxLines: null,
    // expands: true,
    // keyboardType: TextInputType.multiline,
    // // decoration: InputDecoration(
    // //     filled: true, hintText: 'Enter a message'),
    // ),
    // ),
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
    return BlocBuilder<ItemBloc, ItemState>(builder: (context, state) {
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
    });
  }
}
