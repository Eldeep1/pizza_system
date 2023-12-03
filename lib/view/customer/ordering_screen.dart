import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pizza_demo/constants.dart';

class OrderingScreen extends StatefulWidget {
  const OrderingScreen({super.key});

  @override
  State<OrderingScreen> createState() => _OrderingScreenState();
}

class _OrderingScreenState extends State<OrderingScreen> {
  TextEditingController quantityController = TextEditingController(text: '1');
  int? price;

  @override
  Widget build(BuildContext context) {
    generatePrice();
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: 400,
                child: Image.network(
                  height: 400,
                  width: double.maxFinite,
                  fit: BoxFit.cover,
                  '${itemToOrder['image']}',
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
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.error),
                            Text('image can not be loaded'),
                          ],
                        ),
                      ),
                    ); // You can replace this with any widget you want
                  },
                ),
              ),
              Row(
                children: [
                  Text('${itemToOrder['name']}',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                ],
              ),
              Text('${itemToOrder['description']}'),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  const Text('quantity'),
                  const SizedBox(
                    width: 50,
                  ),
                  Container(
                    height: 40,
                    width: 80,
                    child: TextFormField(
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      controller: quantityController,
                      decoration: const InputDecoration(
                        contentPadding: EdgeInsets.symmetric(horizontal: 8),
                        border: OutlineInputBorder(),
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  TextButton(
                      onPressed: () {
                        generatePrice();
                        setState(() {});
                      },
                      child: const Text('update price')),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Row(
                children: [
                  const Text('price :'),
                  Text(price == null ? '${itemToOrder['price']}' : '$price')
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              Container(
                width: double.maxFinite,
                color: Colors.blue,
                child: TextButton(
                  onPressed: () {
                    generatePrice();
                    print(users['id']);
                    database.insert('orders', {
                      'userId': users['id'],
                      'userName': users['name'],
                      'phone': users['phone'],
                      'itemName': itemToOrder['name'],
                      'price': price ?? itemToOrder['price'],
                      'date': '${DateTime.now()}',
                      'statue': 'preparing',
                      'quantity': quantityController.text
                    }).then(
                      (value) {
                        Fluttertoast.showToast(
                            msg: 'ordered successfully',
                            backgroundColor: Colors.green);
                      },
                    );
                  },
                  child: const Text(
                    'order',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void generatePrice() {
    int quantity = int.parse(quantityController.text);
    price = int.parse(itemToOrder['price']) * quantity;
    int toMinus = 0;



    if (price! > 500) {
      toMinus += 100;
    }

    if (quantity >= 5) {
      toMinus += (price! * (20 / 100)).floor();
    }
    else if (quantity >= 3) {
      toMinus += (price! * (10 / 100)).floor();
    }

    print(quantity);
    print(toMinus);
    price = (price! - toMinus);
    print(price);
  }
}
