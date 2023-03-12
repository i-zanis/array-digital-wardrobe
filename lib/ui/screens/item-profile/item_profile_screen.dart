import 'package:Array_App/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/item/item_bloc.dart';
import '../../../bloc/item/item_state.dart';
import '../../../domain/entity/item/item.dart';
import '../../../domain/entity/item/tag.dart';
import '../../../main_development.dart';
import '../../../rest/util/constants.dart';
import '../../../rest/util/util_functions.dart';
import '../../../routes.dart';
import '../../widget/bottom_nav_bar.dart';

class ItemProfileScreen extends StatelessWidget {
  ItemProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10 = context.l10n;
    TextEditingController _nameController = TextEditingController();
    TextEditingController _brandController = TextEditingController();
    TextEditingController _sizeController = TextEditingController();
    TextEditingController _colorController = TextEditingController();
    TextEditingController _priceController = TextEditingController();
    TextEditingController _tagController = TextEditingController();
    TextEditingController _otherController = TextEditingController();
    bool isEditing = false;
    final item = Item(
      userId: 1,
    );
    return Scaffold(
      body: Container(
        child: BlocBuilder<ItemBloc, ItemState>(builder: (context, state) {
          logger.d("state: $state");
          if (state is ItemLoaded) {
            final itemToAdd = state.itemToAdd;
            logger.d("itemToAdd: $itemToAdd");
            if (itemToAdd != null) {
              return Image(image: MemoryImage(itemToAdd.imageData!));
            }
          }
          return SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Column(
                children: [
                  // assets image

                  const SizedBox(height: 20),
                  const SizedBox(height: 20),
                  const SizedBox(height: 20),
                  _inputField(
                      l10.itemProfileScreenNamePlaceHolder, _nameController),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 200,
                        height: 200,
                        color: Colors.grey,
                      ),
                      const SizedBox(width: 8),
                      Container(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            // Spacer(),
                            Icon(Icons.heart_broken),
                            Icon(Icons.delete_forever_outlined)
                          ],
                        ),
                      )
                    ],
                  ),
                  _inputField(
                      l10.itemProfileScreenLabelBrand, _brandController),
                  _inputField(l10.itemProfileScreenLabelSize, _sizeController),
                  _inputField(
                      l10.itemProfileScreenLabelColor, _colorController),
                  _inputField(
                      l10.itemProfileScreenLabelPrice, _priceController),
                  _inputField(l10.itemProfileScreenLabelTag, _tagController),
                  _inputField(
                      l10.itemProfileScreenLabelOther, _otherController),
                  ElevatedButton(
                    onPressed: () {
                      handleSave(
                          _nameController,
                          _brandController,
                          _sizeController,
                          _colorController,
                          _priceController,
                          _tagController,
                          _otherController,
                          context,
                          l10);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).primaryColor,
                    ),
                    child: const Text('Add To Do'),
                  ),
                ],
              ),
            ),
          );
        }),
      ),
      bottomNavigationBar: const BottomNavBar(),
    );
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
      AppLocalizations l10) async {
    var image = await imageToUint8list('assets/images/test-image.jpg');
    logger.d(image);
    final item = Item(
      name: nameController.text,
      brand: brandController.text,
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
      // imageData: Uint8List(0),
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
    AppNavigator.push(AppRoute.home);
  }

  Column _inputField(
    String field,
    TextEditingController controller,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$field: ',
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          height: 50,
          margin: const EdgeInsets.only(bottom: 10),
          width: double.infinity,
          child: TextFormField(
            controller: controller,
            decoration: InputDecoration(
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.cyan),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.cyan),
              ),
            ),
          ),
        ),
      ],
    );
  }

  List<String> _validateColors(TextEditingController colorController) {
    final colors = colorController.text.split(Constants.space);
    if (colors.isEmpty || colors[0] == '') return [];
    return colors;
  }
}
