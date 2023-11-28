import 'package:flutter/material.dart';
import 'package:pizza_demo/constants.dart';
import 'package:pizza_demo/view/login_screen.dart';
import 'package:pizza_demo/view/worker/edit_order_screen.dart';
import 'package:pizza_demo/view/worker/settings_screen.dart';

class WorkerHomeScreen extends StatefulWidget {
  const WorkerHomeScreen({super.key});

  @override
  State<WorkerHomeScreen> createState() => _WorkerHomeScreenState();
}

class _WorkerHomeScreenState extends State<WorkerHomeScreen> {
  int currentIndex = 0;

  @override
  void initState() {
    getAllOrders().then(
      (value) {
        setState(() {});
      },
    );
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getAllOrders().then(
      (value) {
        setState(() {});
      },
    );
    return Scaffold(
      appBar: AppBar(actions: [
        IconButton(
          onPressed: () {
            setState(
              () {
                getAllOrders().then(
                  (value) {
                    setState(() {});
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
            icon: const Icon(Icons.logout_outlined))
      ]),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
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
      body: currentIndex == 1
          ? const WorkerSettingsScreen()
          : Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      usersOrders.isEmpty
                          ? const Align(
                              alignment: Alignment.topCenter,
                              child: Center(
                                child: Text('there\'s no orders to view'),
                              ),
                            )
                          : Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 20, vertical: 50),
                              child: ListView.separated(
                                  physics: const NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemBuilder: (context, index) =>
                                      buildListViewItems(index),
                                  separatorBuilder: (context, index) =>
                                      Container(
                                        height: 2,
                                        color: Colors.grey,
                                      ),
                                  itemCount: usersOrders.length),
                            ),
                    ],
                  ),
                ),
              ],
            ),
    );
  }

  Widget buildListViewItems(index) => Row(
        children: [
          Expanded(
            child: Column(
              children: [
                const Text('food name', style: TextStyle(fontSize: 12)),
                Text(
                  '${usersOrders[index]['itemName']} ',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          Container(
            width: 3,
            height: 60,
            color: Colors.grey,
          ),
          Expanded(
            child: Column(
              children: [
                const Text(
                  'order date',
                  style: TextStyle(fontSize: 12),
                ),
                Text('${usersOrders[index]['date']} ',
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontSize: 12)),
              ],
            ),
          ),
          Container(
            width: 3,
            height: 60,
            color: Colors.grey,
          ),
          Expanded(
            child: Column(
              children: [
                const Text('order statue', style: TextStyle(fontSize: 11)),
                Text(
                  '${usersOrders[index]['statue']} ',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 11),
                ),
              ],
            ),
          ),
          Container(
            width: 3,
            height: 60,
            color: Colors.grey,
          ),
          Expanded(
            child: Column(
              children: [
                const Text('price'),
                Text(
                  usersOrders[index]['price'],
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
          IconButton(
              padding: EdgeInsets.zero,
              onPressed: () {
                orderToChange = usersOrders[index];
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const EditOrderScreen(),
                  ),
                );
              },
              icon: const Icon(Icons.edit)),
        ],
      );
}
