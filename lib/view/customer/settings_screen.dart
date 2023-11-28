import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pizza_demo/constants.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  TextEditingController nameValue = TextEditingController(text: users['name']);
  TextEditingController passwordValue =
      TextEditingController(text: users['password']);
  TextEditingController mailValue = TextEditingController(text: users['email']);
  TextEditingController phoneValue =
      TextEditingController(text: users['phone']);
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  controller: nameValue,
                  validator: (validation) {
                    if (nameValue.text == null || nameValue.text.isEmpty) {
                      return 'can not be empty';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Name'),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: mailValue,
                  validator: (validation) {
                    if (mailValue.text == null || mailValue.text.isEmpty) {
                      return 'can not be empty';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Email'),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  controller: phoneValue,
                  validator: (validation) {
                    if (phoneValue.text == null || phoneValue.text.isEmpty) {
                      return 'can not be empty';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Phone'),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  obscureText: true,
                  controller: passwordValue,
                  validator: (validation) {
                    if (passwordValue.text == null ||
                        passwordValue.text.isEmpty) {
                      return 'can not be empty';
                    }
                    return null;
                  },
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Password'),
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
                        updateInformation(users['id'], nameValue.text,
                                mailValue.text, passwordValue.text)
                            .then(
                          (value) {
                            Fluttertoast.showToast(
                                msg: 'updated successfully',
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
    );
  }
}
