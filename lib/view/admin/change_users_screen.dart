import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pizza_demo/constants.dart';

class ChangeUserScreen extends StatefulWidget {
  const ChangeUserScreen({super.key});

  @override
  State<ChangeUserScreen> createState() => _ChangeUserScreenState();
}

class _ChangeUserScreenState extends State<ChangeUserScreen> {
  TextEditingController userName =
      TextEditingController(text: userToChange['name']);
  TextEditingController userPhone =
      TextEditingController(text: userToChange['email']);
  TextEditingController userEmail =
      TextEditingController(text: userToChange['phone']);
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
                      label: Text('user email'),
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
                      label: Text('user phone'),
                    ),
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
                          changeUsersDetails(userToChange['id'], userName.text,
                              userPhone.text, userEmail.text);
                          setState(
                            () {
                              print(userToChange['isHot']);
                              getUsersFromDataBase();
                              Fluttertoast.showToast(
                                  msg: ' updated successfully',
                                  backgroundColor: Colors.green);
                            },
                          );
                        }
                      },
                      child: const Text(
                        'Update',
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
