import 'package:Array_App/bloc/bloc.dart';
import 'package:Array_App/bloc/item/item_bloc.dart';
import 'package:Array_App/bloc/item/item_state.dart';
import 'package:Array_App/config/style_config.dart';
import 'package:Array_App/core/route/app_navigator.dart';
import 'package:Array_App/core/route/app_route.dart';
import 'package:Array_App/domain/entity/item/category.dart';
import 'package:Array_App/domain/entity/item/item.dart';
import 'package:Array_App/domain/entity/item/tag.dart';
import 'package:Array_App/l10n/l10n.dart';
import 'package:Array_App/presentation/widget/indicator/custom_circular_progress_indicator.dart';
import 'package:Array_App/presentation/widget/widget.dart';
import 'package:Array_App/rest/util/constants.dart';
import 'package:Array_App/rest/util/util_functions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ItemProfileScreen extends StatefulWidget {
  const ItemProfileScreen({super.key});

  @override
  State createState() => _ItemProfileScreenState();
}

class _ItemProfileScreenState extends State<ItemProfileScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController brandController = TextEditingController();
  TextEditingController sizeController = TextEditingController();
  TextEditingController colorController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController tagController = TextEditingController();
  TextEditingController otherController = TextEditingController();
  bool isReadOnly = false;
  late final Item itemToAdd;
  late final ItemBloc itemBloc;
  List<TextEditingController> controllers = [];

  @override
  void initState() {
    super.initState();
    itemBloc = BlocProvider.of<ItemBloc>(context);
    itemToAdd = itemBloc.state.itemToAdd ?? Item.empty();
    controllers = [
      nameController,
      brandController,
      sizeController,
      colorController,
      priceController,
      tagController,
      otherController
    ];
    _initializeTextControllers(itemToAdd);
    final isItemNew = itemToAdd.id != null;
    if (isItemNew) {
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
              fontWeight: FontWeight.bold,
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

    final fields = <String, TextEditingController>{
      l10n.itemProfileScreenLabelBrand: brandController,
      l10n.itemProfileScreenLabelSize: sizeController,
      l10n.itemProfileScreenLabelColor: colorController,
      l10n.itemProfileScreenLabelPrice: priceController,
      l10n.itemProfileScreenLabelTag: tagController,
      l10n.itemProfileScreenLabelOther: otherController,
    };

    final customInputFields = List<Widget>.from(
      fields.entries.map((entry) {
        if (entry.key == l10n.itemProfileScreenLabelOther) {
          return CustomInputField(
            entry.key,
            entry.value,
            labelTextStyle,
            inputFieldFillColor,
            borderColor,
            isReadOnly,
            maxLines: 4,
          );
        } else {
          return CustomInputField(
            entry.key,
            entry.value,
            labelTextStyle,
            inputFieldFillColor,
            borderColor,
            isReadOnly,
          );
        }
      }),
    );

    return Scaffold(
      appBar: CustomAppBar(
        title: _title(context),
        subtitle: _subtitle(context),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(Styles.defaultPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: CustomChip(
                      content: _getCategory(context, itemToAdd.category),
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
                      ...customInputFields,
                      Box.h16,
                      _bottomButton(context, itemBloc, l10n, isReadOnly),
                    ],
                  ),
                ),
              ),
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
              _handleSave(
                itemBloc.state.itemToAdd,
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
      child: _getImageSection(),
    );
  }

  Widget _getImageSection() {
    return BlocBuilder<ItemBloc, ItemState>(
      builder: (context, state) {
        final hasImage = state.itemToAdd?.imageData != null;
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
                    image: MemoryImage(state.itemToAdd!.imageData!),
                    // fit: BoxFit.cover,
                  ),
                ),
              Align(
                alignment: Alignment.centerRight,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(Styles.paddingS),
                      child: FavoriteButton(
                        item: context.read<ItemBloc>().state.itemToAdd ??
                            Item.empty(),
                        onFavoriteToggle: (updatedItem) {
                          BlocProvider.of<ItemBloc>(context).add(
                            UpdateItemToAdd(updatedItem),
                          );
                        },
                      ),
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

  String _title(BuildContext context) {
    return context.l10n.itemProfileScreenTitleNew;
  }

  String _subtitle(BuildContext context) {
    return context.l10n.itemProfileScreenSubtitle;
  }

  Future<void> _handleSave(
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
    final item = Item(
      id: itemToAdd?.id,
      createdAt: itemToAdd?.createdAt,
      name: nameController.text,
      colors: _validateColors(colorController),
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

    _saveItem(context, item, l10);
  }

  void _saveItem(BuildContext context, Item item, AppLocalizations l10) {
    if (item.id == null) {
      context.read<ItemBloc>().add(
            SaveItem(item),
          );
    } else {
      context.read<ItemBloc>().add(
            UpdateItem(item),
          );
    }
    showSnackBar(context, l10.itemProfileScreenNotificationSave);
    AppNavigator.push<void>(AppRoute.root);
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
