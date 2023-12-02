import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pizza_demo/constants.dart';
import 'package:pizza_demo/view/admin/admin_home_screen.dart';
import 'package:pizza_demo/view/customer/customer_home_screen.dart';
import 'package:pizza_demo/view/register_screen.dart';
import 'package:pizza_demo/view/worker/worker_home_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController passwordValue = TextEditingController();
  TextEditingController emailValue = TextEditingController();
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                TextFormField(
                  validator: (validation) {
                    if (emailValue.text == null || emailValue.text.isEmpty) {
                      return 'can not be empty';
                    }
                    return null;
                  },
                  controller: emailValue,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('Email'),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                TextFormField(
                  obscureText: true,
                  validator: (validation) {
                    if (passwordValue.text == null ||
                        passwordValue.text.isEmpty) {
                      return 'can not be empty';
                    }
                    return null;
                  },
                  controller: passwordValue,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text('password'),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  children: [
                    const Text('don\'t have an account ? '),
                    TextButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const RegisterScreen(),
                            ),
                          );
                        },
                        child: const Text('register now')),
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
                        loginToTheSystem(emailValue.text, passwordValue.text)
                            .then(
                          (value) => {
                            if (value)
                              {
                                getItemsFromDataBase().then(
                                  (value) {
                                    if (users['isAdmin'] == 1) {
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const AdminLayout(),
                                        ),
                                      );
                                    } else if (users['isWorker'] == 1) {
                                      getAllOrders();
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const WorkerHomeScreen(),
                                        ),
                                      );
                                    } else
                                      Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const CustomerHomePage(),
                                        ),
                                      );
                                  },
                                ),
                              }
                            else
                              Fluttertoast.showToast(
                                toastLength: Toast.LENGTH_LONG,
                                  msg: 'wrong credentials',
                                  backgroundColor: Colors.red),
                          },
                        );
                      }
                    },
                    child: const Text(
                      'LOGIN',
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
