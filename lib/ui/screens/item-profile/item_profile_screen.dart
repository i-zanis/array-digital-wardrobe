import 'package:Array_App/l10n/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../bloc/item_bloc.dart';
import '../../../bloc/item_state.dart';
import '../../../domain/entity/item.dart';
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
    var item = Item();

    return Scaffold(
      body: BlocListener<ItemBloc, ItemState>(
        listener: (context, state) {
          if (state.status == ItemStateStatus.loadSuccess) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('To Do Added!'),
              ),
            );
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
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
                _inputField(l10.itemProfileScreenLabelBrand, _brandController),
                _inputField(l10.itemProfileScreenLabelSize, _sizeController),
                _inputField(l10.itemProfileScreenLabelColor, _colorController),
                _inputField(l10.itemProfileScreenLabelPrice, _priceController),
                _inputField(l10.itemProfileScreenLabelTag, _tagController),
                _inputField(l10.itemProfileScreenLabelOther, _otherController),
                ElevatedButton(
                  onPressed: () {
                    // TODO(jtl) when you save the item through the request
                    // on return you save it to get the proper id

                    // var todo = Todo(
                    //   id: controllerId.value.text,
                    //   task: controllerTask.value.text,
                    //   description: controllerDescription.value.text,
                    //   );
                    //   context.read<TodosBloc>().add(
                    //         AddTodo(todo: todo),
                    //       );
                    //   Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).primaryColor,
                  ),
                  child: const Text('Add To Do'),
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomNavBar(),
    );
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
          ),
        ),
      ],
    );
  }
}
