import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pizza_demo/constants.dart';

class FoodEditScreen extends StatefulWidget {
  const FoodEditScreen({
    super.key,
  });

  @override
  State<FoodEditScreen> createState() => _FoodEditScreenState();
}

class _FoodEditScreenState extends State<FoodEditScreen> {
  TextEditingController foodController =
      TextEditingController(text: itemToChange[0]['name']);
  TextEditingController foodDescription =
      TextEditingController(text: itemToChange[0]['description']);
  TextEditingController foodLink =
      TextEditingController(text: itemToChange[0]['image']);
  TextEditingController foodPrice =
      TextEditingController(text: itemToChange[0]['price']);
  int isChecked = itemToChange[0]['isHot'];
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    print(isChecked);
    print('--------------');
    return Scaffold(
      appBar: AppBar(),
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
                        value: isChecked == 0 ? false : true,
                        onChanged: (value) {
                          print(value);
                          print(isChecked);
                          setState(
                            () {
                              isChecked = value! ? 1 : 0;
                              print('wwww');
                            },
                          );
                        },
                      ),
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
                          changeItemsDetails(
                              itemToChange[0]['id'],
                              foodController.text,
                              foodDescription.text,
                              foodLink.text,
                              foodPrice.text,
                              isChecked);
                          setState(
                            () {
                              print(isChecked);
                              print(itemToChange[0]['isHot']);
                              getItemsFromDataBase();
                              Fluttertoast.showToast(
                                  msg: ' updated successfully',
                                  backgroundColor: Colors.green);
                            },
                          );
                        }
                      },
                      child: const Text(
                        'update',
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
