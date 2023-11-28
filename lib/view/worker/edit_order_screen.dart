import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pizza_demo/constants.dart';

class EditOrderScreen extends StatefulWidget {
  const EditOrderScreen({super.key});

  @override
  State<EditOrderScreen> createState() => _EditOrderScreenState();
}

class _EditOrderScreenState extends State<EditOrderScreen> {
  TextEditingController userName =
      TextEditingController(text: orderToChange['userName']);
  TextEditingController userPhone =
      TextEditingController(text: orderToChange['phone']);
  TextEditingController itemName =
      TextEditingController(text: orderToChange['itemName']);
  TextEditingController orderDate =
      TextEditingController(text: orderToChange['date']);
  TextEditingController orderPrice =
      TextEditingController(text: orderToChange['price']);
  TextEditingController orderQuantity =
      TextEditingController(text: orderToChange['quantity'].toString());
  TextEditingController orderStatue =
      TextEditingController(text: orderToChange['statue']);

  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
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
                    enabled: false,
                    validator: (validation) {
                      if (userName.text == null || userName.text.isEmpty) {
                        return 'can not be empty';
                      }
                      return null;
                    },
                    controller: userName,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text('user name'),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    enabled: false,
                    validator: (validation) {
                      if (userPhone.text == null || userPhone.text.isEmpty) {
                        return 'can not be empty';
                      }
                      return null;
                    },
                    controller: userPhone,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text('user phone'),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    enabled: false,
                    validator: (validation) {
                      if (itemName.text == null || itemName.text.isEmpty) {
                        return 'can not be empty';
                      }
                      return null;
                    },
                    controller: itemName,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text('item name'),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    enabled: false,
                    validator: (validation) {
                      if (orderDate.text == null || orderDate.text.isEmpty) {
                        return 'can not be empty';
                      }
                      return null;
                    },
                    controller: orderDate,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text('order date'),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    enabled: false,
                    validator: (validation) {
                      if (orderPrice.text == null || orderPrice.text.isEmpty) {
                        return 'can not be empty';
                      }
                      return null;
                    },
                    controller: orderPrice,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text('order price'),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    enabled: false,
                    validator: (validation) {
                      if (orderQuantity.text == null ||
                          orderQuantity.text.isEmpty) {
                        return 'can not be empty';
                      }
                      return null;
                    },
                    controller: orderQuantity,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text('order quantity'),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  DropdownMenu(
                    dropdownMenuEntries: const [
                      DropdownMenuEntry(value: 'preparing', label: 'preparing'),
                      DropdownMenuEntry(
                          value: 'on the way', label: 'on the way'),
                      DropdownMenuEntry(
                          value: 'delievered', label: 'delievered'),
                    ],
                    controller: orderStatue,
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
                          changeOrderDetails(
                              orderToChange['id'], orderStatue.text);
                          setState(
                            () {
                              getAllOrders();
                              Fluttertoast.showToast(
                                  msg: ' statue updated successfully',
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
