import 'package:flutter/material.dart';
import 'package:pizza_demo/constants.dart';
import 'package:pizza_demo/view/customer/ordering_screen.dart';

class HotOfferes extends StatefulWidget {
  const HotOfferes({super.key});

  @override
  State<HotOfferes> createState() => _HotOfferesState();
}

class _HotOfferesState extends State<HotOfferes> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              hotItems.isEmpty
                  ? const Align(
                      alignment: Alignment.topCenter,
                      child: Center(
                        child: Text('there\'s no hot items to view'),
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 50),
                      child: Column(
                        children: [
                          Container(
                            width: double.maxFinite,
                            height: hotItems.length == 1
                                ? (hotItems.length + 2) * 140
                                : hotItems.length * 140,
                            child: GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      childAspectRatio: 3 / 4,
                                      crossAxisCount: 2),
                              itemBuilder: (context, index) {
                                return buildGridItems(index);
                              },
                              itemCount: hotItems.length,
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
          itemToOrder = hotItems[index];
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
                  '${hotItems[index]['image']}',
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
                              '${hotItems[index]['name']}',
                              style: const TextStyle(color: Colors.white),
                              maxLines: 2,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              '${hotItems[index]['price']}\$',
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
