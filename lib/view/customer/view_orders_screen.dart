import 'package:flutter/material.dart';
import 'package:pizza_demo/constants.dart';

class ViewingOrdersScreen extends StatefulWidget {
  const ViewingOrdersScreen({super.key});

  @override
  State<ViewingOrdersScreen> createState() => _ViewingOrdersScreenState();
}

class _ViewingOrdersScreenState extends State<ViewingOrdersScreen> {
  @override
  void initState() {
    // TODO: implement initState
    getOrdersForOneUser().then(
      (value) {
        setState(
          () {
            database.rawQuery('select * from orders ').then(
              (value) {
                print(value);
              },
            );
          },
        );
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    getOrdersForOneUser().then((value) {
      setState(() {});
    });
    return Column(
      children: [
        SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              orders.isEmpty
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
                          itemCount: orders.length),
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
                  '${orders[index]['itemName']} ',
                  style: const TextStyle(fontSize: 12),
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
                const Text('order date', style: TextStyle(fontSize: 12)),
                Text(
                  '${orders[index]['date']} ',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 12),
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
                const Text('order statue', style: TextStyle(fontSize: 11)),
                Text(
                  '${orders[index]['statue']} ',
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
                  orders[index]['price'],
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
        ],
      );
}
