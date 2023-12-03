import 'dart:io';

import 'package:flutter/material.dart';
import 'package:open_file/open_file.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pizza_demo/constants.dart';
import 'package:pizza_demo/view/admin/edit_order_screen.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pdfWid;
import 'package:printing/printing.dart';

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
        Align(
          alignment: Alignment.bottomRight,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: InkWell(
              onTap: () {
                createPdf();
              },
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(),
                  borderRadius: const BorderRadius.all(
                    Radius.circular(20),
                  ),
                ),
                child: const Icon(
                  Icons.download_outlined,
                  size: 50,
                ),
              ),
            ),
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

  Future<void> createPdf() async {
    final pdf = pdfWid.Document(
      version: PdfVersion.pdf_1_4,
      compress: true,
    );
    for(int i=0;i<usersOrders.length;i++){
    pdf.addPage(
      pdfWid.Page(
        build: (context) {
          return pdfWid.Column(children: [
            pdfWid.Row(children: [
              pdfWid.Text('food name',style: pdfWid.TextStyle(
                  fontSize: 24, fontWeight: pdfWid.FontWeight.bold),),
              pdfWid.SizedBox(width: 10),
              pdfWid.Text('${usersOrders[i]['itemName']}',style: pdfWid.TextStyle(
                  fontSize: 24,),),
            ]),
            pdfWid.SizedBox(height: 20),
            pdfWid.Row(children: [
              pdfWid.Text('customer name',style: pdfWid.TextStyle(
                  fontSize: 24, fontWeight: pdfWid.FontWeight.bold),),
              pdfWid.SizedBox(width: 10),
              pdfWid.Text('${usersOrders[i]['userName']}',style: pdfWid.TextStyle(
                fontSize: 24,)),
            ]),
            pdfWid.SizedBox(height: 20),
            pdfWid.Row(children: [
              pdfWid.Text('customer phone',style: pdfWid.TextStyle(
                  fontSize: 24, fontWeight: pdfWid.FontWeight.bold),),
              pdfWid.SizedBox(width: 10),
              pdfWid.Text('${usersOrders[i]['userName']}',style: pdfWid.TextStyle(
                fontSize: 24,)),
            ]),
            pdfWid.SizedBox(height: 20),
            pdfWid.Row(children: [
              pdfWid.Text('order date',style: pdfWid.TextStyle(
                  fontSize: 24, fontWeight: pdfWid.FontWeight.bold),),
              pdfWid.SizedBox(width: 10),
              pdfWid.Text('${usersOrders[i]['date']}',style: pdfWid.TextStyle(
                fontSize: 24,)),
            ]),
            pdfWid.SizedBox(height: 20),
            pdfWid.Row(children: [
              pdfWid.Text('order quantity',style: pdfWid.TextStyle(
                  fontSize: 24, fontWeight: pdfWid.FontWeight.bold),),
              pdfWid.SizedBox(width: 10),
              pdfWid.Text('${usersOrders[i]['quantity']}',style: pdfWid.TextStyle(
                fontSize: 24,)),
            ]),
            pdfWid.SizedBox(height: 20),
            pdfWid.Row(children: [
              pdfWid.Text('order price',style: pdfWid.TextStyle(
                  fontSize: 24, fontWeight: pdfWid.FontWeight.bold),),
              pdfWid.SizedBox(width: 10),
              pdfWid.Text('${usersOrders[i]['price']}',style: pdfWid.TextStyle(
                fontSize: 24,)),
            ]),
            pdfWid.SizedBox(height: 20),
            pdfWid.Row(children: [
              pdfWid.Text(
                'order statue',
                style: pdfWid.TextStyle(
                    fontSize: 24, fontWeight: pdfWid.FontWeight.bold),
              ),
              pdfWid.SizedBox(width: 10),
              pdfWid.Text('${usersOrders[i]['statue']}',style: pdfWid.TextStyle(
                fontSize: 24,)),
            ]),
          ]);
        },
      ),
    );}
    final path = (await getExternalStorageDirectory())!.path;
    final file = File('$path/orders.pdf');
print(path);
    await file.writeAsBytes(await pdf.save());
    OpenFile.open('$path/orders.pdf');
  }
}
