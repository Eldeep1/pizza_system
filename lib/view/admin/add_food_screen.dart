import 'package:flutter/material.dart';
import 'package:pizza_demo/constants.dart';
import 'package:pizza_demo/view/admin/admin_home_screen.dart';
import 'package:pizza_demo/view/admin/items_screen.dart';

class AddFoodScreen extends StatefulWidget {
  const AddFoodScreen({super.key});

  @override
  State<AddFoodScreen> createState() => _AddFoodScreenState();
}

class _AddFoodScreenState extends State<AddFoodScreen> {
  TextEditingController foodController = TextEditingController();
  TextEditingController foodDescription = TextEditingController();
  TextEditingController foodLink = TextEditingController();
  TextEditingController foodPrice = TextEditingController();
  bool isChecked = false;
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: formKey,
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: (validation) {
                      if (foodController.text == null ||
                          foodController.text.isEmpty) {
                        return 'can not be empty';
                      }
                      return null;
                    },
                    controller: foodController,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text('food name'),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: (validation) {
                      if (foodDescription.text == null ||
                          foodDescription.text.isEmpty) {
                        return 'can not be empty';
                      }
                      return null;
                    },
                    controller: foodDescription,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text('food description'),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: (validation) {
                      if (foodLink.text == null || foodLink.text.isEmpty) {
                        return 'can not be empty';
                      }
                      return null;
                    },
                    controller: foodLink,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text('link to food image'),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: (validation) {
                      if (foodPrice.text == null || foodPrice.text.isEmpty) {
                        return 'can not be empty';
                      }
                      return null;
                    },
                    controller: foodPrice,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text('food price'),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      const Text('it is a hot offer'),
                      Checkbox(
                        value: isChecked,
                        onChanged: (value) {
                          setState(() {
                            isChecked = value!;
                          });
                        },
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    width: double.maxFinite,
                    color: Colors.blue,
                    child: TextButton(
                      onPressed: () {
                        if (formKey.currentState!.validate()) {
                          insertIntoItems(
                              foodController.text,
                              foodDescription.text,
                              foodLink.text,
                              foodPrice.text,
                              isChecked
                          );
                          Navigator.pushAndRemoveUntil(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const AdminLayout(),
                              ),
                              (route) => false);
                          setState(
                            () {
                              getItemsFromDataBase();
                            },
                          );
                        }
                      },
                      child: const Text(
                        'Add Food',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
