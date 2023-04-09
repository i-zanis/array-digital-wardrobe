import 'package:Array_App/l10n/l10n.dart';
import 'package:Array_App/presentation/widget/custom_app_bar.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/item/item_bloc.dart';
import '../../../bloc/item/item_state.dart';
import '../../../config/style_config.dart';
import '../../../core/route/app_navigator.dart';
import '../../../core/route/app_route.dart';
import '../../../domain/entity/item/category.dart' as cat;
import '../../../domain/entity/item/item.dart';
import '../../../domain/entity/item/tag.dart';
import '../../../rest/util/constants.dart';
import '../../../rest/util/util_functions.dart';
import '../../widget/button/custom_filled_button.dart';
import '../../widget/button/favorite_button.dart';
import '../../widget/constant/box.dart';
import '../../widget/custom_chip.dart';

class ItemProfileScreen extends StatefulWidget {
  const ItemProfileScreen({super.key});

  @override
  State createState() => _ItemProfileScreenState();
}

class _ItemProfileScreenState extends State<ItemProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final labelTextStyle = Theme.of(context).textTheme.labelLarge?.copyWith(
              color: Theme.of(context).colorScheme.onTertiaryContainer,
            ) ??
        const TextStyle();
    final inputFieldFillColor = Theme.of(context).colorScheme.tertiaryContainer;
    final borderColor = Theme.of(context).colorScheme.tertiary;
    final l10n = context.l10n;
    final nameController = TextEditingController();
    final brandController = TextEditingController();
    final sizeController = TextEditingController();
    final colorController = TextEditingController();
    final priceController = TextEditingController();
    final tagController = TextEditingController();
    final otherController = TextEditingController();
    final isEditing = false;
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
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: CustomChip(
                      content: _getCategory(context, itemToAdd?.category),
                    ),
                  ),
                  Box.h16,
                  _inputField(
                    l10n.itemProfileScreenNamePlaceHolder,
                    nameController,
                    labelTextStyle,
                    inputFieldFillColor,
                    borderColor,
                  ),
                  // Box.h16,
                  _imageSection(itemToAdd),
                  Box.h16,
                  Material(
                    borderRadius: borderRadius,
                    shadowColor: shadowColor,
                    surfaceTintColor: surfaceTint,
                    color: surface,
                    type: MaterialType.card,
                    elevation: 2,
                    child: Padding(
                      padding: const EdgeInsets.all(Styles.defaultPadding),
                      child: Column(
                        children: [
                          _inputField(
                              l10n.itemProfileScreenLabelBrand,
                              brandController,
                              labelTextStyle,
                              inputFieldFillColor,
                              borderColor),
                          _inputField(
                            l10n.itemProfileScreenLabelSize,
                            sizeController,
                            labelTextStyle,
                            inputFieldFillColor,
                            borderColor,
                          ),
                          _inputField(
                              l10n.itemProfileScreenLabelColor,
                              colorController,
                              labelTextStyle,
                              inputFieldFillColor,
                              borderColor),
                          _inputField(
                              l10n.itemProfileScreenLabelPrice,
                              priceController,
                              labelTextStyle,
                              inputFieldFillColor,
                              borderColor),
                          _inputField(
                              l10n.itemProfileScreenLabelTag,
                              tagController,
                              labelTextStyle,
                              inputFieldFillColor,
                              borderColor),
                          _textAreaInputField(
                              l10n.itemProfileScreenLabelOther,
                              otherController,
                              labelTextStyle,
                              inputFieldFillColor,
                              borderColor),
                          Box.h16,
                          CustomFilledButton(
                            onPressed: () {
                              handleSave(
                                nameController,
                                brandController,
                                sizeController,
                                colorController,
                                priceController,
                                tagController,
                                otherController,
                                context,
                                l10n,
                                state.itemToAdd?.imageData,
                              );
                            },
                            content: l10n.itemProfileScreenItemCreationButton,
                          ),
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

  Widget _imageSection(Item? itemToAdd) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.44,
      width: MediaQuery.of(context).size.width,
      child: _getImageSection(itemToAdd),
    );
  }

  Row _getImageSection(Item? itemToAdd) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Spacer(),
        if (itemToAdd != null && itemToAdd.imageData != null)
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
      child: Icon(Icons.delete, color: Theme.of(context).colorScheme.secondary),
    );
  }

  void _handleDelete() {
    BlocProvider.of<ItemBloc>(context).add(UpdateItemToAdd(Item.empty()));
    AppNavigator.push<void>(AppRoute.root);
  }

  String _getTitle(BuildContext context) {
    return context.l10n.itemProfileScreenTitleNew;
  }

  String _getSubtitle(BuildContext context) {
    return context.l10n.itemProfileScreenSubtitle;
  }

  Future<void> handleSave(
    TextEditingController nameController,
    TextEditingController brandController,
    TextEditingController sizeController,
    TextEditingController colorController,
    TextEditingController priceController,
    TextEditingController tagController,
    TextEditingController otherController,
    BuildContext context,
    AppLocalizations l10,
    Uint8List? image,
  ) async {
    final item = Item(
      name: nameController.text,
      brand: brandController.text,
      category: cat.Category.TOP,
      size: sizeController.text,
      colors: _validateColors(colorController),
      price: double.tryParse(priceController.text) ?? 0.0,
      tags: tagController.text
          .split(Constants.space)
          .map((e) => Tag(name: e))
          .toList(),
      notes: otherController.text,
      userId: 1,
      imageLocalPath: '',
      imageData: image,
      isFavorite: false,
      looks: [],
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

  Widget _inputField(String field, TextEditingController controller,
      TextStyle labelTextStyle, Color fillColor, Color borderColor) {
    return Padding(
      padding: const EdgeInsets.all(Styles.paddingS),
      child: TextField(
        controller: controller,
        readOnly: true,
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

  Widget _textAreaInputField(String field, TextEditingController controller,
      TextStyle labelTextStyle, Color fillColor, Color borderColor) {
    // final labelTextStyle = Theme.of(context).textTheme.labelLarge;
    return Padding(
      padding: const EdgeInsets.all(Styles.paddingS),
      child: TextField(
        controller: controller,
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
}
