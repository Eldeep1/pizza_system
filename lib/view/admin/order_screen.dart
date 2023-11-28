
import 'package:flutter/material.dart';
import 'package:pizza_demo/constants.dart';
import 'package:pizza_demo/view/admin/edit_order_screen.dart';


class SeeOrdersClass extends StatefulWidget {
  const SeeOrdersClass({super.key});

  @override
  State<SeeOrdersClass> createState() => _SeeOrdersClassState();
}

class _SeeOrdersClassState extends State<SeeOrdersClass> {
  @override
  Widget build(BuildContext context) {
    getAllOrders().then((value) {
      setState(() {});
    });
    return Stack(
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
                          separatorBuilder: (context, index) => Container(
                                height: 2,
                                color: Colors.grey,
                              ),
                          itemCount: usersOrders.length),
                    ),
            ],
          ),
        ),
      ],
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
