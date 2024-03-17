import 'package:magic5/color.dart';
import 'package:magic5/game.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';

class StartPage extends StatefulWidget {
  StartPage({Key? key}) : super(key: key);
  final nameController = TextEditingController();
  @override
  _StartPageState createState() => _StartPageState();
}

class _StartPageState extends State<StartPage> with TickerProviderStateMixin {
  // BubbleOptions _bubbleOptions = BubbleOptions();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.transparent,
        body: Container(
          child: Column(
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
              Container(
                  height: MediaQuery.of(context).size.height * 0.55,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 45),
                        child: TextField(
                          controller: widget.nameController,
                          obscureText: false,
                          decoration: InputDecoration(
                            enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey.shade400),
                            ),
                            fillColor: Colors.grey.shade200,
                            filled: true,
                            hintText: "Enter Nickname",
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 18),
                                height: 55,
                                width: 55,
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
                                child: Icon(
                                  LineIcons.book,
                                  color: darkgrey,
                                )),
                          ),
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
                            child: Container(
                                height: 60,
                                width: 140,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: activeBlue,
                                    boxShadow: [
                                      BoxShadow(
                                          color: activeBlue.withOpacity(0.2),
                                          offset: Offset(1, 1),
                                          blurRadius: 6,
                                          spreadRadius: 4)
                                    ]),
                                alignment: Alignment.center,
                                child: Text(
                                  "Play",
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 32,
                                      fontWeight: FontWeight.w300),
                                )),
                          ),
                          GestureDetector(
                            onTap: () {},
                            child: Container(
                                margin: EdgeInsets.symmetric(horizontal: 18),
                                height: 55,
                                width: 55,
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
                                child: Icon(
                                  LineIcons.trophy,
                                  color: darkgrey,
                                )),
                          ),
                        ],
                      ),
                    ],
                  ))
            ],
          ),
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
}
