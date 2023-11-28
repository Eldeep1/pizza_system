import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pizza_demo/constants.dart';
import 'package:pizza_demo/view/admin/add_food_screen.dart';
import 'package:pizza_demo/view/admin/food_edit_screen.dart';

class AdminItemsScreen extends StatefulWidget {
  const AdminItemsScreen({super.key});

  @override
  State<AdminItemsScreen> createState() => _AdminItemsScreenState();
}

class _AdminItemsScreenState extends State<AdminItemsScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              items.isEmpty
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
                            height:
                                items.length == 1 ? 280 : items.length * 140,
                            child: GridView.builder(
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      childAspectRatio: 3 / 4,
                                      crossAxisCount: 2),
                              itemBuilder: (context, index) {
                                return buildGridItems(index);
                              },
                              itemCount: items.length,
                            ),
                          ),
                        ],
                      ),
                    ),
            ],
          ),
        ),
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AddFoodScreen(),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: const Icon(
                  Icons.add,
                  size: 50,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildGridItems(index) => InkWell(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Material(
            elevation: 2,
            child: Container(
              child: Stack(
                alignment: Alignment.bottomCenter,
                children: [
                  Container(
                      child: Image.network(
                    height: 250,
                    fit: BoxFit.cover,
                    '${items[index]['image']}',
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
                  )),
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
                                '${items[index]['name']}',
                                style: const TextStyle(color: Colors.white),
                                maxLines: 2,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                '${items[index]['price']}\$',
                                style: const TextStyle(color: Colors.white),
                                maxLines: 2,
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Container(
                      width: 30,
                      height: 30,
                      color: Colors.white,
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: InkWell(
                          onTap: () {
                            database
                                .rawQuery(
                              'select * from items where id=${items[index]['id']}',
                            )
                                .then((value) {
                              itemToChange = value;
                              if (itemToChange[0]['isHot'] == 1 ||
                                  itemToChange[0]['isHot'] == true) {
                                print('sssssssss');
                                print(itemToChange[0]['isHot']);
                              }
                              print(itemToChange[0]['isHot']);

                              print(value);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const FoodEditScreen()),
                              );
                            });
                          },
                          child: const Icon(Icons.edit),
                        ),
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.topLeft,
                    child: Container(
                      width: 30,
                      height: 30,
                      color: Colors.white,
                      child: Align(
                        alignment: Alignment.topCenter,
                        child: InkWell(
                          onTap: () {
                            database
                                .rawQuery(
                              'delete from items where id=${items[index]['id']}',
                            )
                                .then((value) {
                              setState(() {
                                getItemsFromDataBase().then((value) {
                                  setState(() {});
                                });
                                Fluttertoast.showToast(
                                    msg: 'deleted successfully');
                              });
                            });
                          },
                          child: const Icon(
                            Icons.delete_outlined,
                            color: Colors.red,
                          ),
                        ),
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
