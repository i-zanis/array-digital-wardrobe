import 'package:Array_App/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/item/item_bloc.dart';
import '../../../bloc/item/item_state.dart';
import '../../../config/style_config.dart';
import '../../../core/route/app_navigator.dart';
import '../../../core/route/app_route.dart';
import '../../../domain/entity/item/category.dart';
import '../../../domain/entity/item/item.dart';
import '../../../domain/entity/item/tag.dart';
import '../../../main_development.dart';
import '../../../rest/util/constants.dart';
import '../../../rest/util/util_functions.dart';
import '../../widget/widget.dart';

class ItemProfileScreen extends StatefulWidget {
  const ItemProfileScreen({super.key});

  @override
  State createState() => _ItemProfileScreenState();
}

class _ItemProfileScreenState extends State<ItemProfileScreen> {
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
        BlocProvider.of<ItemBloc>(context).state.itemToAdd?.id != null;
    if (isItemNew) {
      isReadOnly = true;
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    brandController.dispose();
    sizeController.dispose();
    colorController.dispose();
    priceController.dispose();
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
              final itemToAdd = state.itemToAdd;
              _initializeTextControllers(itemToAdd);
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: CustomChip(
                          content: _getCategory(context, itemToAdd?.category),
                        ),
                      ),
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
                    field: l10n.itemProfileScreenNamePlaceHolder,
                    controller: nameController,
                    fillColor: inputFieldFillColor,
                    borderColor: borderColor,
                    isEditingMode: isReadOnly,
                  ),
                  Box.h16,
                  _imageSection(itemToAdd),
                  Box.h16,
                  Material(
                    borderRadius: borderRadius,
                    shadowColor: shadowColor,
                    surfaceTintColor: surfaceTint,
                    color: surface,
                    type: MaterialType.card,
                    elevation: 1,
                    child: Padding(
                      padding: const EdgeInsets.all(Styles.defaultPadding),
                      child: Column(
                        children: [
                          _inputField(
                              l10n.itemProfileScreenLabelBrand,
                              brandController,
                              labelTextStyle,
                              inputFieldFillColor,
                              borderColor,
                              isReadOnly),
                          _inputField(
                              l10n.itemProfileScreenLabelSize,
                              sizeController,
                              labelTextStyle,
                              inputFieldFillColor,
                              borderColor,
                              isReadOnly),
                          _inputField(
                              l10n.itemProfileScreenLabelColor,
                              colorController,
                              labelTextStyle,
                              inputFieldFillColor,
                              borderColor,
                              isReadOnly),
                          _inputField(
                              l10n.itemProfileScreenLabelPrice,
                              priceController,
                              labelTextStyle,
                              inputFieldFillColor,
                              borderColor,
                              isReadOnly),
                          _inputField(
                              l10n.itemProfileScreenLabelTag,
                              tagController,
                              labelTextStyle,
                              inputFieldFillColor,
                              borderColor,
                              isReadOnly),
                          _textAreaInputField(
                              l10n.itemProfileScreenLabelOther,
                              otherController,
                              labelTextStyle,
                              inputFieldFillColor,
                              borderColor,
                              isReadOnly),
                          Box.h16,
                          _bottomButton(itemToAdd, context, l10n, isReadOnly),
                        ],
                      ),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _bottomButton(Item? itemToAdd, BuildContext context,
      AppLocalizations l10n, bool isReadOnly) {
    return !isReadOnly
        ? CustomFilledButton(
            onPressed: () {
              handleSave(
                itemToAdd,
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
            content: l10n.itemProfileScreenItemCreationButton,
          )
        : Container();
  }

  void _initializeTextControllers(Item? itemToAdd) {
    if (itemToAdd != null) {
      nameController.text = getStringOrDefault(itemToAdd.name);
      brandController.text = getStringOrDefault(itemToAdd.brand);
      sizeController.text = getStringOrDefault(itemToAdd.size);
      colorController.text = itemToAdd.colors?.join(' ') ?? '';
      priceController.text = getStringOrDefault(itemToAdd.price);
      if (priceController.text == '0.0') {
        priceController.text = '';
      }
      tagController.text =
          itemToAdd.tags?.map((tag) => tag.name).join(' ') ?? '';
      otherController.text = getStringOrDefault(itemToAdd.notes);
    }
  }

  Widget _imageSection(Item? itemToAdd) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.44,
      width: MediaQuery.of(context).size.width,
      child: _getImageSection(itemToAdd),
    );
  }

  Row _getImageSection(Item? itemToAdd) {
    final hasImage = itemToAdd != null && itemToAdd.imageData != null;
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(),
        if (hasImage)
          Image(
            image: MemoryImage(itemToAdd.imageData!),
            // fit: BoxFit.cover,
          ),
        Box.h8,
        Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            const Spacer(),
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
        Box.h16
      ],
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

  String _getTitle(BuildContext context) {
    return context.l10n.itemProfileScreenTitleNew;
  }

  String _getSubtitle(BuildContext context) {
    return context.l10n.itemProfileScreenSubtitle;
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
      colors: _validateColors(colorController),
      brand: brandController.text,
      category: itemToAdd?.category ?? Category.OTHER,
      looks: itemToAdd?.looks ?? [],
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
    //     content: Text(l10.itemProfileScreenNotificationSave),
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

  List<String> _validateColors(TextEditingController colorController) {
    final colors = colorController.text.split(Constants.space);
    if (colors.isEmpty || colors[0] == '') return [];
    return colors;
  }

  String _getCategory(BuildContext context, Enum? category) {
    return getCategoryName(context, category);
  }

  void _handleEditButton() {
    setState(() {
      isReadOnly = false;
    });
  }
}
