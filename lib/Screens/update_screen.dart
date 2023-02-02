import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'commons/colorselect.dart';

class UpdateScreen extends StatefulWidget {
  final String id;
  UpdateScreen({Key? key, required this.id}) : super(key: key);

  @override
  State<UpdateScreen> createState() => _UpdateScreenState();
}

class _UpdateScreenState extends State<UpdateScreen> {
  final titleController = TextEditingController();
  final desController = TextEditingController();
  final dateController = TextEditingController();

  final _key = GlobalKey<FormState>();
  bool isLoading = true;

  var name = "";
  var des = "";
  var date = "";

  CollectionReference task = FirebaseFirestore.instance.collection('Task');

  Future<void> updateTask(id, name, des, date) async {
    return await task
        .doc(id)
        .update({'Name': name, 'Description': des, 'Date': date})
        .then((value) => print("Task Updated"))
        .catchError((error) => print("Failed to update Task: $error"));
  }

  @override
  void initState() {
    log("M..." + widget.id);
    isLoading = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    var height = MediaQuery.of(context).size.height;
    Color color = Colors.white;

    return Scaffold(
      backgroundColor: Colors.black,
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Form(
              key: _key,
              // Getting Specific Data by ID
              child: FutureBuilder<DocumentSnapshot<Map<String, dynamic>>>(
                future: FirebaseFirestore.instance
                    .collection('Task')
                    .doc(widget.id)
                    .get(),
                builder: ((context, AsyncSnapshot snapshot) {
                  if (snapshot.hasError) {
                    print('Something Went Wrong');
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.data!.data() != null) {
                    //var data = snapshot.data!.data();
                    var data = snapshot.data!.data();

                    name = data['Name'];
                    des = data['Description'];
                    date = data['Date'];
                  }

                  print(name + des + date);

                  return SafeArea(
                    child: SizedBox(
                      height: height,
                      width: width,
                      child: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const SizedBox(
                              height: 20,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: (() {
                                    Navigator.pop(context, true);
                                  }),
                                  child: const Icon(
                                    Icons.arrow_back,
                                    size: 30,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(
                                  width: 15.0,
                                ),
                                Text(
                                  "Update Task",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6!
                                      .copyWith(
                                          fontWeight: FontWeight.w500,
                                          color: Colors.white),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Center(
                              child: Container(
                                height: 80,
                                width: 80,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(50),
                                    border:
                                        Border.all(color: color, width: 0.5)),
                                child: Icon(
                                  Icons.edit_note,
                                  color: color,
                                  size: 60,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 18),
                              child: Text(
                                ' Task Name',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontFamily: 'Merriweather',
                                    color: color,
                                    fontWeight: FontWeight.w100),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12.0, vertical: 8),
                              child: SizedBox(
                                height: 45,
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      border: Border.all(
                                          color: ColorSelect.grey200,
                                          width: 0.5)),
                                  child: TextFormField(
                                    initialValue: name,
                                    style: TextStyle(color: color),
                                    //controller: titleController,
                                    autofocus: false,
                                    onChanged: (value) {
                                      setState(() {
                                        name = value;
                                      });
                                    },
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Please Enter Task Name';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: const EdgeInsets.all(10),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                          borderSide: BorderSide(
                                            color: ColorSelect.grey350,
                                            width: 0.5,
                                          )),
                                      errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                          borderSide: const BorderSide(
                                            color: Colors.red,
                                            width: 0.5,
                                          )),
                                      disabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(25),
                                        borderSide: const BorderSide(
                                            width: 0.5,
                                            style: BorderStyle.none),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        gapPadding: 0.0,
                                        borderRadius: BorderRadius.circular(25),
                                        borderSide: BorderSide(
                                          color: ColorSelect.primary,
                                          width: 1.0,
                                          //style: BorderStyle.none
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 18),
                              child: Text(
                                ' Description',
                                textAlign: TextAlign.start,
                                style: TextStyle(
                                    fontFamily: 'Merriweather',
                                    color: color,
                                    fontWeight: FontWeight.w100),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12.0, vertical: 8),
                              child: SizedBox(
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      border: Border.all(
                                          color: ColorSelect.grey200,
                                          width: 0.5)),
                                  child: TextFormField(
                                    initialValue: des,
                                    style: TextStyle(color: color),
                                    maxLines: 3,
                                    //controller: desController,
                                    autofocus: false,
                                    onChanged: (value) {
                                      setState(() {
                                        des = value;
                                      });
                                    },
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Enter Description';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      border: InputBorder.none,
                                      contentPadding: const EdgeInsets.all(10),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                          borderSide: BorderSide(
                                            color: ColorSelect.grey350,
                                            width: 0.5,
                                          )),
                                      errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                          borderSide: const BorderSide(
                                            color: Colors.red,
                                            width: 0.5,
                                          )),
                                      disabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(25),
                                        borderSide: const BorderSide(
                                            width: 0.5,
                                            style: BorderStyle.none),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        gapPadding: 0.0,
                                        borderRadius: BorderRadius.circular(25),
                                        borderSide: BorderSide(
                                          color: ColorSelect.primary,
                                          width: 1.0,
                                          //style: BorderStyle.none
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12.0, vertical: 8),
                              child: SizedBox(
                                height: 45,
                                child: Container(
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(25),
                                      //color: ColorSelect.grey200,
                                      border: Border.all(
                                          color: ColorSelect.grey200,
                                          width: 0.5)),
                                  child: TextFormField(
                                    initialValue: date,
                                    style: TextStyle(color: color),
                                    //controller: dateController,
                                    autofocus: false,
                                    onChanged: (value) {
                                      setState(() {
                                        date = value;
                                      });
                                    },
                                    keyboardType: TextInputType.number,
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return '';
                                      }
                                      return null;
                                    },
                                    decoration: InputDecoration(
                                      suffixIcon: Icon(
                                        Icons.calendar_month_outlined,
                                        color: color,
                                      ),
                                      hintText: "Select date",
                                      hintStyle: TextStyle(
                                          color: color,
                                          fontWeight: FontWeight.w100),
                                      border: InputBorder.none,
                                      contentPadding: const EdgeInsets.all(10),
                                      enabledBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                          borderSide: BorderSide(
                                            color: ColorSelect.grey350,
                                            width: 0.5,
                                          )),
                                      errorBorder: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(25.0),
                                          borderSide: const BorderSide(
                                            color: Colors.red,
                                            width: 0.5,
                                          )),
                                      disabledBorder: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(25),
                                        borderSide: const BorderSide(
                                            width: 0.5,
                                            style: BorderStyle.none),
                                      ),
                                      focusedBorder: OutlineInputBorder(
                                        gapPadding: 0.0,
                                        borderRadius: BorderRadius.circular(25),
                                        borderSide: BorderSide(
                                          color: ColorSelect.primary,
                                          width: 1.0,
                                          //style: BorderStyle.none
                                        ),
                                      ),
                                    ),
                                    readOnly: true,
                                    onTap: () async {
                                      DateTime? pickedDate =
                                          await showDatePicker(
                                              context: context,
                                              initialDate: DateTime.now(),
                                              firstDate: DateTime(1950),
                                              lastDate: DateTime(2100));
                                      if (pickedDate != null) {
                                        String formattedDate =
                                            DateFormat('dd-MM-yyyy')
                                                .format(pickedDate);
                                        setState(() {
                                          dateController.text =
                                              formattedDate; //set output date to TextField value.
                                        });
                                      } else {}
                                    },
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 50,
                            ),
                            Center(
                              child: GestureDetector(
                                onTap: () {
                                  try {
                                    if (name != null) {
                                      setState(() {
                                        print("" + name);

                                        updateTask(widget.id, name, des, date);
                                        Navigator.pop(context, true);
                                      });
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(const SnackBar(
                                        backgroundColor: Colors.red,
                                        content:
                                            Text("Please fill all the details"),
                                      ));
                                    }
                                  } catch (e) {
                                    print(e);
                                  }
                                },
                                child: Container(
                                  height: 50,
                                  width: 300,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      gradient: const LinearGradient(colors: [
                                        Colors.orange,
                                        Colors.pink
                                      ])),
                                  child: const Center(
                                    child: Text(
                                      "Update Task ",
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.white,
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: 1),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                }),
              )),
    );
  }
}
