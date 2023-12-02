import 'package:flutter/material.dart';
import 'package:pizza_demo/constants.dart';
import 'package:pizza_demo/view/customer/hot_offers_screen.dart';
import 'package:pizza_demo/view/customer/items_screen.dart';
import 'package:pizza_demo/view/customer/settings_screen.dart';
import 'package:pizza_demo/view/customer/view_orders_screen.dart';
import 'package:pizza_demo/view/login_screen.dart';

class CustomerHomePage extends StatefulWidget {
  const CustomerHomePage({super.key});

  @override
  State<CustomerHomePage> createState() => _CustomerHomePageState();
}

class _CustomerHomePageState extends State<CustomerHomePage> {
  int currentIndex = 0;

  @override
  void initState() {
    // TODO: implement initState
    getItemsFromDataBase().then((value) {
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              setState(
                () {


                      getItemsFromDataBase().then(
                        (value) {
                          getOrdersForOneUser();
                          setState(() {});
                        },
                      );
                    },


              );
              setState(() {
                print(coldItems);
              });
            },
            icon: const Icon(Icons.refresh),
          ),
          IconButton(
              onPressed: () {
                // users = {};
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LoginScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.logout_outlined)),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.home_outlined), label: 'home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.local_fire_department), label: 'offers'),
          BottomNavigationBarItem(
              icon: Icon(Icons.shopping_cart), label: 'orders'),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings), label: 'settings'),
        ],
        currentIndex: currentIndex,
        onTap: (value) {
          currentIndex = value;
          setState(() {});
        },
      ),
      body: currentIndex == 0
          ? const ItemsScreen() : currentIndex == 3
              ? const SettingsScreen()
              : currentIndex == 1
                  ? const HotOfferes()
                  : const ViewingOrdersScreen(),
    );
  }
}
