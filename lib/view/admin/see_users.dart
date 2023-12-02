import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pizza_demo/constants.dart';
import 'package:pizza_demo/view/admin/add_user_screen.dart';
import 'package:pizza_demo/view/admin/change_users_screen.dart';

class SeeUsersScreen extends StatefulWidget {
  const SeeUsersScreen({super.key});

  @override
  State<SeeUsersScreen> createState() => _SeeUsersScreenState();
}

class _SeeUsersScreenState extends State<SeeUsersScreen> {
  @override
  void initState() {

    // TODO: implement initState
    super.initState();
    getUsersFromDataBase().then((value) {
      setState(() {

      });
    });
  }
  @override
  void didChangeDependencies() {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();
    getUsersFromDataBase().then((value) {
      setState(() {

      });
    });
  }
  @override
  void didUpdateWidget(covariant SeeUsersScreen oldWidget) {
    // TODO: implement didUpdateWidget
    super.didUpdateWidget(oldWidget);
    getUsersFromDataBase().then((value) {
      setState(() {

      });
    });
  }
  @override
  Widget build(BuildContext context) {
    setState(() {
      getUsersFromDataBase().then((value) {
        setState(() {

        });
      });
    });
    return Stack(
      children: [
        SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              allUsers.isEmpty
                  ? const Align(
                      alignment: Alignment.topCenter,
                      child: Center(
                        child: Text('there\'s no users to view'),
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
                          itemCount: allUsers.length),
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
                    builder: (context) => const AddUsersScreen(),
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

  Widget buildListViewItems(index) => Row(
        children: [
          Expanded(
            child: Column(
              children: [
                const Text('name'),
                Text(
                  '${allUsers[index]['name']} ',
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
                const Text('phone'),
                Text(
                  '${allUsers[index]['phone']} ',
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
                const Text('type'),
                Text(
                  allUsers[index]['isCustomer'] == 1
                      ? 'customer'
                      : allUsers[index]['isWorker'] == 1
                          ? 'worker'
                          : 'ADMIN',
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
                IconButton(
                    onPressed: () {
                      userToChange = allUsers[index];
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ChangeUserScreen(),
                        ),
                      );
                    },
                    icon: const Icon(Icons.edit)),
                if (index != 0)
                  IconButton(
                    onPressed: () {
                      database
                          .rawQuery(
                        'delete from users where id=${allUsers[index]['id']}',
                      )
                          .then(
                        (value) {
                          setState(
                            () {
                              print(allUsers[index]['name']);
                              getUsersFromDataBase().then(
                                (value) {
                                  setState(() {});
                                },
                              );
                              Fluttertoast.showToast(
                                  msg: 'deleted successfully',
                                  backgroundColor: Colors.green);
                            },
                          );
                        },
                      );
                    },
                    icon: const Icon(
                      Icons.delete_outline,
                      color: Colors.red,
                    ),
                  ),
              ],
            ),
          ),
        ],
      );
}
