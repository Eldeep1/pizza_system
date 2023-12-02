import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pizza_demo/constants.dart';
import 'package:pizza_demo/view/admin/see_users.dart';

class AddUsersScreen extends StatefulWidget {
  const AddUsersScreen({super.key});

  @override
  State<AddUsersScreen> createState() => _AddUsersScreenState();
}

class _AddUsersScreenState extends State<AddUsersScreen> {
  TextEditingController userName = TextEditingController();
  TextEditingController userPhone = TextEditingController();
  TextEditingController userEmail = TextEditingController();
  TextEditingController userPassword = TextEditingController();
  bool isWorker = false;
  bool isCustomer = true;
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
                    validator: (validation) {
                      if (userEmail.text == null || userEmail.text.isEmpty) {
                        return 'can not be empty';
                      }
                      return null;
                    },
                    controller: userEmail,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text('user email'),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: (validation) {
                      if (userPassword.text == null ||
                          userPassword.text.isEmpty) {
                        return 'can not be empty';
                      }
                      return null;
                    },
                    controller: userPassword,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(),
                      label: Text('user password'),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      const Text('Worker'),
                      Checkbox(
                        value: isWorker,
                        onChanged: (value) {
                          setState(
                            () {
                              isWorker = value!;
                              isCustomer = !isCustomer;
                            },
                          );
                        },
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    children: [
                      const Text('customer'),
                      Checkbox(
                        value: isCustomer,
                        onChanged: (value) {
                          setState(
                            () {
                              isWorker = !isWorker;
                              isCustomer = value!;
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
                          if (isCustomer) {
                            registerCustomer(
                              name: userName.text,
                              mail: userEmail.text,
                              password: userPassword.text,
                              phone: userPhone.text,
                            ).then(
                              (value) => {
                                if (value == false)
                                  {
                                    Fluttertoast.showToast(
                                        msg: 'the email already exists',
                                        backgroundColor: Colors.red),
                                  }
                                else
                                  {
                                    Fluttertoast.showToast(
                                        msg: 'added successfully',
                                        backgroundColor: Colors.green)
                                  }
                              },
                            );
                          } else {
                            addWorker(
                                    name: userName.text,
                                    mail: userEmail.text,
                                    password: userPassword.text,
                                    phone: userPhone.text)
                                .then(
                              (value) => {
                                if (value == false)
                                  {
                                    Fluttertoast.showToast(
                                        msg: 'the email already exists',backgroundColor: Colors.red),
                                  }
                                else
                                  {
                                    Fluttertoast.showToast(
                                        msg: 'added successfully',
                                        backgroundColor: Colors.green)
                                  }
                              },
                            );
                          }
                          setState(
                            () {
                              getUsersFromDataBase().then(
                                (value) {
                                  print(allUsers);
                                },
                              );
                            },
                          );
                        }
                      },
                      child: const Text(
                        'Add User',
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
