import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pizza_demo/constants.dart';
import 'package:pizza_demo/view/customer/customer_home_screen.dart';
import 'package:pizza_demo/view/login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    var formKey = GlobalKey<FormState>();
    TextEditingController nameValue = TextEditingController();
    TextEditingController emailValue = TextEditingController();
    TextEditingController passwordValue = TextEditingController();
    TextEditingController phoneValue = TextEditingController();
    return Scaffold(
      body: Center(
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
                    controller: emailValue,
                    validator: (validation) {
                      if (emailValue.text == null || emailValue.text.isEmpty) {
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
                          registerCustomer(
                                  name: nameValue.text,
                                  mail: emailValue.text,
                                  password: passwordValue.text,
                                  phone: phoneValue.text)
                              .then(
                            (value) {
                              if (value) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LoginScreen(),
                                  ),
                                );
                              } else
                                Fluttertoast.showToast(
                                    msg: 'the email is not valid',
                                    backgroundColor: Colors.red);
                            },
                          );
                        }
                      },
                      child: const Text(
                        'Register',
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
