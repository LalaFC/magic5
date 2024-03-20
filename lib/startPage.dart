// ignore_for_file: non_constant_identifier_names, dead_code, library_private_types_in_public_api

import 'dart:ffi';

import 'package:magic5/color.dart';
import 'package:magic5/game.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

import 'package:magic5/model/User.dart';
import 'package:magic5/database_handler.dart';

class StartPage extends StatefulWidget {
  StartPage({super.key});
  final nameController = TextEditingController();
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> with TickerProviderStateMixin {
  // BubbleOptions _bubbleOptions = BubbleOptions();

  late DatabaseHandler handler;
  List<User>? list;
  @override
  void initState() {
    super.initState();
    handler = DatabaseHandler();
    handler.initializeDB().whenComplete(() async {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Expanded(
                child: Container(
              alignment: Alignment.bottomCenter,
              child: Text(
                "Magic\n5",
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: white,
                    fontSize: 42,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 1.5),
              ),
            )),
            SizedBox(
                height: MediaQuery.of(context).size.height * 0.55,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 45),
                      child: TextField(
                        controller: widget.nameController,
                        obscureText: false,
                        decoration: InputDecoration(
                          enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.grey.shade400),
                          ),
                          fillColor: Colors.grey.shade200,
                          filled: true,
                          hintText: "Enter Nickname",
                        ),
                      ),
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        // GestureDetector(
                        //   onTap: () {},
                        //   child: Container(
                        //       margin:
                        //           const EdgeInsets.symmetric(horizontal: 18),
                        //       height: 55,
                        //       width: 55,
                        //       decoration: BoxDecoration(
                        //         borderRadius: BorderRadius.circular(10),
                        //         border: Border.all(color: darkgrey, width: 2),
                        //         color: white,
                        //         // boxShadow: [
                        //         //   BoxShadow(
                        //         //       color: Colors.blueGrey.withOpacity(0.2),
                        //         //       offset: Offset(1, 1),
                        //         //       blurRadius: 6,
                        //         //       spreadRadius: 4)
                        //         // ]
                        //       ),
                        //       alignment: Alignment.center,
                        //       child: Icon(
                        //         LineIcons.book,
                        //         color: darkgrey,
                        //       )),
                        // ),
                        GestureDetector(
                            onTap: () {
                              if (widget.nameController.text == "") {
                                NoName();
                              } else {
                                Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) =>
                                        GamePage(widget.nameController.text)));
                              }
                            },
                            child: Padding(
                              padding: EdgeInsets.all(15),
                              child: Container(
                                  height: 60,
                                  width: 140,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: activeBlue,
                                      boxShadow: [
                                        BoxShadow(
                                            color: activeBlue.withOpacity(0.2),
                                            offset: const Offset(1, 1),
                                            blurRadius: 6,
                                            spreadRadius: 4)
                                      ]),
                                  alignment: Alignment.center,
                                  child: const Text(
                                    "Play",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 32,
                                        fontWeight: FontWeight.w300),
                                  )),
                            )),
                        GestureDetector(
                          onTap: () {
                            showCupertinoDialog(
                                context: context,
                                builder: (context) => CupertinoPopupSurface(
                                    isSurfacePainted: false,
                                    child: buildPopup(context)));
                          },
                          child: Container(
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 18),
                              height: 50,
                              width: 120,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: darkgrey, width: 2),
                                color: white,
                                // boxShadow: [
                                //   BoxShadow(
                                //       color: Colors.blueGrey.withOpacity(0.2),
                                //       offset: Offset(1, 1),
                                //       blurRadius: 6,
                                //       spreadRadius: 4)
                                // ]
                              ),
                              alignment: Alignment.center,
                              child: Padding(
                                padding: EdgeInsets.only(left: 5, right: 5),
                                child: Row(
                                  children: [
                                    Icon(
                                      LineIcons.trophy,
                                      color: darkgrey,
                                    ),
                                    const Text(
                                      "Ranking",
                                      textAlign: TextAlign.right,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w300),
                                    )
                                  ],
                                ),
                              )),
                        ),
                      ],
                    ),
                  ],
                ))
          ],
        ));
  }

  void NoName() {
    showDialog(
        context: context,
        builder: (context) {
          return const AlertDialog(
            backgroundColor: Color.fromARGB(228, 155, 155, 155),
            title: Center(
              child: Text(
                "Please Enter a Name",
                style: TextStyle(color: Colors.white),
              ),
            ),
          );
        });
  }

  Future<List<DataRow>> getRows() async {
    List<DataRow> dataRows = [];

    var listUsers = await handler.showTop10();
    for (var user in listUsers) {
      var index = 0;
      index = listUsers.indexOf(user) + 1;
      dataRows.add(DataRow(
        cells: <DataCell>[
          DataCell(Text(index.toString(), textAlign: TextAlign.center)),
          DataCell(Text(user.name, textAlign: TextAlign.center)),
          DataCell(Text(user.time.toString(), textAlign: TextAlign.center)),
          DataCell(Text(user.attempts.toString(), textAlign: TextAlign.center)),
        ],
      ));
    }

    // Adding an extra DataRow for the Refresh button
    dataRows.add(DataRow(
      cells: <DataCell>[
        const DataCell(Text('')), // Placeholder for rank
        DataCell(TextButton(
          style: TextButton.styleFrom(
            padding: const EdgeInsets.all(10.0),
          ),
          onPressed: () {},
          child: const Text('Refresh'),
        )),
        const DataCell(Text('')), // Placeholders for time and attempts
        const DataCell(Text('')),
      ],
    ));

    return dataRows;
  }

  @override
  Widget buildPopup(BuildContext context) {
    return Center(
        child: SizedBox(
            height: MediaQuery.of(context).size.height * 0.6,
            width: MediaQuery.of(context).size.width * 0.75,
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  const Icon(
                    LineIcons.trophy,
                    size: 100,
                    color: CupertinoColors.systemYellow,
                  ),
                  const Text(
                    "Top 10 Players",
                    style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.8),
                  ),

                  Expanded(
                      child: SingleChildScrollView(
                          child: FutureBuilder(
                              future: getRows(),
                              builder: (BuildContext context,
                                  AsyncSnapshot asyncSnapshot) {
                                if (asyncSnapshot.data == null) {
                                  return const Center(
                                      child: CircularProgressIndicator());
                                } else {
                                  return DataTable(
                                    columnSpacing: 10,
                                    columns: const <DataColumn>[
                                      DataColumn(
                                        label: Expanded(
                                          child: Text(
                                            'Rank',
                                            style: TextStyle(
                                                fontStyle: FontStyle.italic),
                                          ),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Expanded(
                                          child: Text(
                                            'Name',
                                            style: TextStyle(
                                                fontStyle: FontStyle.italic),
                                          ),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Expanded(
                                          child: Text(
                                            'Time',
                                            style: TextStyle(
                                                fontStyle: FontStyle.italic),
                                          ),
                                        ),
                                      ),
                                      DataColumn(
                                        label: Expanded(
                                          child: Text(
                                            'Attempts',
                                            style: TextStyle(
                                                fontStyle: FontStyle.italic),
                                          ),
                                        ),
                                      ),
                                    ],
                                    rows: asyncSnapshot.data,
                                  );
                                }
                              }))),

                  // Text(
                  //   "Tries taken: ${tryCount.toString()}",
                  //   style:
                  //       TextStyle(fontSize: 18, fontWeight: FontWeight.w300, letterSpacing: 0.8),
                  // ),
                  // buttonUi(
                  //   title: "Back",
                  //   callback: () {
                  //     Navigator.of(context).pop();
                  //   },
                  //   icon: LineIcons.arrowLeft,
                  // ),
                  buttonUi(
                    title: "Back",
                    callback: () {
                      if (mounted) {
                        // Check if the widget is still mounted
                        Navigator.of(context).pop();
                      }
                    },
                    icon: LineIcons.arrowLeft,
                  )
                ],
              ),
            )));
  }

  Future<void> GetTop10() async {
    var newList = await handler.showTop10();
    setState(() {
      list = newList;
    });
  }

  Widget buttonUi({String? title, Function? callback, IconData? icon}) {
    bool ispressed = false;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 28),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
        child: GestureDetector(
          onTap: () {
            callback!();
          },
          child: Container(
              height: 50,
              //width: 120,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: activeBlue,
                  boxShadow: [
                    BoxShadow(
                        color: activeBlue.withOpacity(0.2),
                        offset: const Offset(1, 1),
                        blurRadius: 6,
                        spreadRadius: 2)
                  ]),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    title = "${title!} ",
                    style: TextStyle(
                        color: ispressed ? activeBlue : Colors.black,
                        fontSize: 22,
                        fontWeight: FontWeight.w300),
                  ),
                  icon != null
                      ? Icon(
                          icon,
                          color: const Color.fromARGB(255, 0, 0, 0),
                        )
                      : Container()
                ],
              )),
        ),
      ),
    );
  }
}
