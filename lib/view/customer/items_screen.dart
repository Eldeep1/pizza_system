import 'package:flutter/material.dart';
import 'package:pizza_demo/constants.dart';
import 'package:pizza_demo/view/customer/ordering_screen.dart';

class ItemsScreen extends StatefulWidget {
  const ItemsScreen({super.key});

  @override
  State<ItemsScreen> createState() => _ItemsScreenState();
}

class _ItemsScreenState extends State<ItemsScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              coldItems.isEmpty
                  ? const Align(
                      alignment: Alignment.topCenter,
                      child: Center(
                        child: Text('there\'s no items to view'),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 50),
                      child: Column(
                        children: [
                          Container(
                            width: double.maxFinite,
                            height: coldItems.length == 1
                                ? (coldItems.length + 2) * 140
                                : coldItems.length * 140,
                            child: GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      childAspectRatio: 3 / 4,
                                      crossAxisCount: 2),
                              itemBuilder: (context, index) {
                                return buildGridItems(index);
                              },
                              itemCount: coldItems.length,
                            ),
                          ),
                        ],
                      ),
                    ),
            ],
          ),
        ),
      ],
    );
  }

  Widget buildGridItems(index) => InkWell(
        onTap: () {
          itemToOrder = coldItems[index];
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const OrderingScreen(),
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Material(
            elevation: 2,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Image.network(
                  height: 250,
                  fit: BoxFit.cover,
                  '${coldItems[index]['image']}',
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) {
                      // Image is fully loaded, return the child (the actual image)
                      return child;
                    } else {
                      // Image is still loading, you can return a loading indicator here if needed
                      return const CircularProgressIndicator();
                    }
                  },
                  errorBuilder: (BuildContext context, Object error,
                      StackTrace? stackTrace) {
                    return const Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.error),
                          Text('image can not be loaded'),
                        ],
                      ),
                    ); // You can replace this with any widget you want
                  },
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Container(
                    color: Colors.black.withOpacity(.7),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              '${coldItems[index]['name']}',
                              style: const TextStyle(color: Colors.white),
                              maxLines: 2,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              '${coldItems[index]['price']}\$',
                              style: const TextStyle(color: Colors.white),
                              maxLines: 2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
