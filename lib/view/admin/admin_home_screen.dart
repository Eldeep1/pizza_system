import 'package:flutter/material.dart';
import 'package:pizza_demo/constants.dart';
import 'package:pizza_demo/view/admin/order_screen.dart';
import 'package:pizza_demo/view/admin/see_users.dart';
import 'package:pizza_demo/view/login_screen.dart';

import 'items_screen.dart';

class AdminLayout extends StatefulWidget {
  const AdminLayout({super.key});

  @override
  State<AdminLayout> createState() => _AdminLayoutState();
}

class _AdminLayoutState extends State<AdminLayout> {
  @override
  void initState() {
    // TODO: implement initState
    getUsersFromDataBase();
    super.initState();
  }

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              setState(
                () {
                  getUsersFromDataBase().then(
                    (value) {
                      getItemsFromDataBase().then(
                        (value) {
                          setState(() {});
                        },
                      );
                    },
                  );
                },
              );
            },
            icon: const Icon(Icons.refresh),
          ),
          IconButton(
            onPressed: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ));
            },
            icon: const Icon(Icons.logout_outlined),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'items',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'users',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_cart),
            label: 'orders',
          ),
        ],
        currentIndex: currentIndex,
        onTap: (value) {
          currentIndex = value;
          setState(() {});
        },
      ),
      body: currentIndex == 0
          ? const AdminItemsScreen()
          : currentIndex == 1
              ? const SeeUsersScreen()
              : const SeeOrdersClass(),
    );
  }
}
