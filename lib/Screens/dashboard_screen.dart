import 'dart:developer';
//import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/Screens/add_task.dart';
import 'package:todo_app/Screens/commons/colorselect.dart';
import 'package:todo_app/Screens/onboard_screen.dart';
import 'package:todo_app/Screens/update_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final user = FirebaseAuth.instance.currentUser!;
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  var date;
  var listStream = FirebaseFirestore.instance.collection('Task');
  final List storedocs = [];
  bool isEditIconClicked = false;

  @override
  void initState() {
    datepicker();
    super.initState();
  }

  // For Deleting task
  CollectionReference task = FirebaseFirestore.instance.collection('Task');
  Future<void> deleteUser(id) {
    //print("User Deleted $id");
    return task.doc(id).delete().then((value) {
      //print('task Deleted');
      storedocs.remove(id);
    }).catchError((error) => print('Failed to Delete task: $error'));
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;

    return Scaffold(
      key: _key,
      backgroundColor: Colors.black,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddTaskScreen()),
          ).then((value) => updateScreen(value));
        },
        backgroundColor: Colors.red[400],
        child: const Icon(Icons.add),
      ),
      drawer: drawer(),
      body: SafeArea(
          //tume edit btn ra tap funct dekhucha
          child: Container(
        //color: Colors.amber,
        height: height,
        width: width,
        margin: const EdgeInsets.only(left: 8, right: 8),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Opacity(
                    opacity: 1.0,
                    child: Image.asset(
                      'assets/images/wallpaper.jpg',
                      width: MediaQuery.of(context).size.width,
                      height: 250,
                      fit: BoxFit.fill,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      InkWell(
                        onTap: () {
                          _key.currentState!.openDrawer();
                        },
                        child: const SizedBox(
                          height: 45,
                          width: 45,
                          child: Icon(
                            Icons.menu_sharp,
                            color: Colors.white,
                          ),
                        ),
                      ),
                      Column(
                        children: [
                          Text(
                            user.displayName.toString(),
                            style: const TextStyle(
                                color: Colors.white, fontFamily: 'Raleway'),
                          ),
                          const SizedBox(
                            height: 2,
                          ),
                          Text(
                            date.toString(),
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontFamily: 'Raleway'),
                          )
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(30.0),
                            child: Image.network(
                              user.photoURL.toString(),
                              height: 45,
                              width: 45,
                            )
                            // Image.asset(
                            //   'assets/images/bg.jpg',
                            //   width: 45,
                            //   height: 45,
                            //   //fit: BoxFit.fill,
                            // ),
                            ),
                      )
                    ],
                  ),
                  Positioned(
                      bottom: 50,
                      left: 8,
                      child: Text(
                        " Your\n Things",
                        textAlign: TextAlign.start,
                        style: Theme.of(context).textTheme.bodyText2!.copyWith(
                            fontWeight: FontWeight.w200,
                            fontFamily: 'OpenSans',
                            color: Colors.white,
                            fontSize: 40),
                      )),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: width,
                color: const Color.fromARGB(137, 56, 55, 55),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    "Task",
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              StreamBuilder<QuerySnapshot>(
                stream: listStream.snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    print('Something went Wrong');
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  // final List storedocs = [];
                  storedocs.clear();
                  snapshot.data!.docs.map((DocumentSnapshot document) {
                    Map a = document.data() as Map<String, dynamic>;
                    storedocs.add(document.id);
                    a['id'] = document.id;
                  }).toList();
                  // if (mounted) {
                  //   setState(() {});
                  // }
                  log(storedocs.toString());

                  return snapshot.hasData
                      ? SizedBox(
                          height: MediaQuery.of(context).size.height / 1.9,
                          child: ListView.builder(
                              itemCount: snapshot.data!.docs.length,
                              itemBuilder: (context, index) {
                                return Card(
                                  elevation: 2,
                                  child: Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(30.0),
                                                child: const Icon(
                                                    Icons.file_copy)),
                                            const SizedBox(
                                              width: 10,
                                            ),
                                            Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  snapshot.data!.docs[index]
                                                      ["Name"],
                                                  //  storedocs[index]['Name']
                                                  //  .toString(),
                                                  // "Task Title",
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 15),
                                                ),
                                                Text(
                                                  // storedocs[index]
                                                  //         ['Description']
                                                  //     .toString(),
                                                  snapshot.data!.docs[index]
                                                      ["Description"],
                                                  // "Description",
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 13),
                                                ),
                                                const SizedBox(
                                                  height: 2,
                                                ),
                                                Text(
                                                  snapshot.data!.docs[index]
                                                      ["Date"],
                                                  // storedocs[index]['Date']
                                                  //     .toString(),
                                                  style: const TextStyle(
                                                      color: Colors.black,
                                                      fontSize: 8),
                                                ),
                                              ],
                                            )
                                          ],
                                        ),
                                        PopupMenuButton(
                                          itemBuilder: (context) => [
                                            PopupMenuItem(
                                                onTap: () {
                                                  isEditIconClicked = true;
                                                },
                                                value: 1,
                                                child: const Text("Edit")),
                                            PopupMenuItem(
                                                onTap: () {},
                                                value: 2,
                                                child: const Text("Delete"))
                                          ],
                                          onSelected: (value) {
                                            if (value == 1) {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        UpdateScreen(
                                                          id: storedocs[index],
                                                          // snapshot.data!
                                                          //         .docs[
                                                          //     index]["id"],
                                                        )),
                                              );
                                            } else if (value == 2) {
                                              deleteUser(storedocs[index]);
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                  ),
                                );
                              }),
                        )
                      : const SizedBox(
                          child: Center(
                              child: Text(
                            "No task yet",
                            style: TextStyle(color: Colors.white),
                          )),
                        );
                },
              ),
            ],
          ),
        ),
      )),
    );
  }

  Widget? drawer() {
    return Container(
      color: Colors.white,
      width: MediaQuery.of(context).size.width * 0.65,
      height: MediaQuery.of(context).size.height,
      child: ListView(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            height: 165,
            color: Colors.red[400],
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(100.0),
                  child: FadeInImage(
                    height: 80.0,
                    width: 80.0,
                    fit: BoxFit.cover,
                    placeholder: const AssetImage("assets/images/proimg.png"),
                    image: NetworkImage(user.photoURL.toString()),
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(user.displayName.toString(),
                    style: const TextStyle(fontSize: 14, color: Colors.white)),
                const SizedBox(
                  height: 5,
                ),
                Text(user.email.toString(),
                    style: TextStyle(fontSize: 13, color: Colors.white)),
                const SizedBox(
                  height: 4,
                ),
              ],
            ),
          ),
          ListTile(
            title: Text(
              "Home",
              style: TextStyle(fontSize: 13, color: ColorSelect.black),
            ),
            leading: Icon(
              Icons.home,
              color: ColorSelect.black,
            ),
            onTap: () {
              Navigator.of(context).pop();
            },
            visualDensity: const VisualDensity(vertical: -3),
          ),
          ListTile(
            title: Text(
              "About us",
              style: TextStyle(fontSize: 13, color: ColorSelect.black),
            ),
            leading: Icon(
              Icons.account_circle,
              color: ColorSelect.black,
            ),
            onTap: () {
              Navigator.of(context).pop();
            },
            visualDensity: const VisualDensity(vertical: -3),
          ),
        ],
      ),
    );
  }

  datepicker() async {
    date = DateTime.now();
    String formattedDate = DateFormat('dd-MM-yyyy').format(date);
    setState(() {
      date = formattedDate; //set output date to TextField value.
    });
  }

  void updateScreen(value) {
    Stream listStream = FirebaseFirestore.instance.collection('Task') as Stream;
    // listStream.count();
    Future.delayed(const Duration(milliseconds: 500), () {
      setState(() {});
      log("updated" + value.toString());
      log("data" + listStream.toString());
    });
  }
}
