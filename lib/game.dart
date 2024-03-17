import 'dart:async';
import 'dart:math';

import 'package:magic5/color.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:line_icons/line_icons.dart';
import 'package:magic5/main.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:time/time.dart';
import 'package:timer_builder/timer_builder.dart';

class GamePage extends StatefulWidget {
  GamePage({Key? key}) : super(key: key);

  @override
  _GamePageState createState() => _GamePageState();
}

class _GamePageState extends State<GamePage> {
  Duration? time;
  bool pause = false;
  bool showdenied = false;
  String pin = '';
  var rand = Random();
  TextEditingController pinController = TextEditingController();
  StreamController<ErrorAnimationType> errorController =
      StreamController<ErrorAnimationType>();
  List<int> numpad = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
  List<int> indArray = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0];
  List<int> pinArray = [-1, -1, -1, -1];
  List<String> logs = [];
  int tryCount = 0;
  @override
  void initState() {
    time = 0.seconds;
    pinController.text = "";
    generatePin();
    super.initState();
  }

  void checkPin() {
    tryCount++;
    if (pinArray.join() == pinController.text) {
      showCupertinoDialog(
          context: context,
          builder: (context) => CupertinoPopupSurface(
              isSurfacePainted: false, child: buildPopup()));
      return;
    }

    logs.add(pinController.text +
        "  \n" +
        countCows().toString() +
        checkGrammar(countCows()) +
        " CORRECT. \n" +
        countBulls().toString() +
        checkGrammar(countBulls()) +
        " IN PLACE.");
    reset();
    errorController.add(ErrorAnimationType.shake);
  }

  String checkGrammar(int number) {
    if (number <= 1) {
      return " Digit is";
    } else {
      return " Digits are";
    }
  }

  void reset() {
    pinController.clear();
    for (int i = 0; i < numpad.length; i++) numpad[i] = 0;

    // numpad.forEach((element) => element = 0);
    setState(() {});
  }

  int countCows() {
    int cows = 0;
    pinArray.forEach((element) {
      if (pinController.text.contains(element.toString())) {
        ++cows;
      }
    });
    // numpad.forEach((element) {
    //   if (element == 1) {
    //     if (pinArray.contains(element)) {
    //       cows++;
    //     }
    //   }
    // });
    return cows;
  }

  int countBulls() {
    int bulls = 0;
    for (int i = 0; i < 4; i++) {
      if (pinController.text[i] == pinArray[i].toString()) {
        bulls++;
      }
    }
    return bulls;
  }

  void generatePin() {
    pinArray[0] = rand.nextInt(10);
    int temp = rand.nextInt(10);
    while (pinArray.contains(temp)) {
      temp = rand.nextInt(10);
    }
    pinArray[1] = temp;
    temp = rand.nextInt(10);
    while (pinArray.contains(temp)) {
      temp = rand.nextInt(10);
    }
    pinArray[2] = temp;
    temp = rand.nextInt(10);
    while (pinArray.contains(temp)) {
      temp = rand.nextInt(10);
    }
    pinArray[3] = temp;
    print(pinArray.join());
  }

  void resetBoard() {
    reset();
    for (int i = 0; i < indArray.length; i++) {
      indArray[i] = 0;
    }
    time = 0.seconds;
    tryCount = 0;
    logs.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 224, 130),
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            LineIcons.angleLeft,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Container(
          alignment: Alignment.center,
          child: Column(
            children: <Widget>[
              Text(
                "Magic 5",
                style:
                    TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              LineIcons.cog,
              color: activeBlue,
            ),
            onPressed: () {
              //Add Function for Settings
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          Wrap(
            alignment: WrapAlignment.center,
            crossAxisAlignment: WrapCrossAlignment.center,
            // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Container(
                  width: MediaQuery.of(context).size.width,
                  child: Text(
                    "Hi Name",
                    style: TextStyle(
                        color: white,
                        fontWeight: FontWeight.bold,
                        fontSize: 40),
                  )),
              Expanded(child: buildTimerUI())
            ],
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(22)),
              child: Padding(
                padding: const EdgeInsets.all(15),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Enter the pin:",
                        style: normal,
                      ),
                    ),
                    Container(
                      //height: 200,
                      padding: EdgeInsets.symmetric(horizontal: 45),
                      child: PinCodeTextField(
                        appContext: context,
                        length: 4,
                        obscureText: false,
                        animationType: AnimationType.slide,
                        controller: pinController,
                        //enabled: false,
                        animationDuration: Duration(milliseconds: 300),
                        pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(12),
                          fieldHeight: 50,
                          fieldWidth: 50,
                          activeFillColor: activeBlue,
                          inactiveColor: Colors.blueGrey,
                        ),
                        backgroundColor: Colors.transparent,
                        errorAnimationController: errorController,
                        focusNode: AlwaysDisabledFocusNode(),
                        onChanged: (value) {
                          setState(() {});
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Expanded(
            child: Row(
              children: <Widget>[
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          "Hints:",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                              color: white),
                        ),
                      ),
                      Expanded(
                        child: ListView.separated(
                            itemBuilder: (context, i) => Container(
                                  padding: EdgeInsets.all(5),
                                  child: Row(
                                    children: <Widget>[
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        child: Icon(LineIcons.arrowRight,
                                            color: CupertinoColors.systemBlue),
                                      ),
                                      Text(
                                        logs[i],
                                        style: TextStyle(
                                            fontSize: 18,
                                            color:
                                                Color.fromARGB(131, 0, 255, 0)),
                                      )
                                    ],
                                  ),
                                ),
                            separatorBuilder: (context, i) => Divider(),
                            itemCount: logs.length),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    buildNumpad(1),
                    buildNumpad(2),
                    buildNumpad(3),
                    buildNumpad(4),
                    buildNumpad(5),
                    Flexible(
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: GestureDetector(
                          onTap: () {
                            reset();
                          },
                          child: Card(
                            elevation: 0,
                            color:
                                CupertinoColors.destructiveRed.withOpacity(0.9),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                                side: BorderSide(
                                    color: CupertinoColors.destructiveRed
                                        .withOpacity(0.5))),
                            child: Center(
                              child: Padding(
                                padding: const EdgeInsets.all(5.0),
                                child: Icon(
                                  LineIcons.windowClose,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  children: <Widget>[
                    buildNumpad(6),
                    buildNumpad(7),
                    buildNumpad(8),
                    buildNumpad(9),
                    buildNumpad(0),
                    Flexible(
                      child: AspectRatio(
                        aspectRatio: 1,
                        child: GestureDetector(
                          onTap: () {
                            if (pinController.text.length == 4) {
                              print("enter");
                              checkPin();
                            }
                          },
                          child: Card(
                            elevation: 0,
                            color: CupertinoColors.activeGreen.withOpacity(0.9),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                                side: BorderSide(
                                    color: CupertinoColors.activeGreen
                                        .withOpacity(0.5))),
                            child: Center(
                              child: Padding(
                                  padding: const EdgeInsets.all(5.0),
                                  child: Icon(
                                    LineIcons.check,
                                    color: Colors.white,
                                  )

                                  //  Text(
                                  //   "OK",
                                  //   style: normal.copyWith(color: Colors.white),
                                  // ),
                                  ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTimerUI() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text(
          "TIME:",
          style: TextStyle(
              fontSize: 20, color: white, fontWeight: FontWeight.bold),
        ),
        TimerBuilder.periodic(Duration(seconds: 1), builder: (context) {
          time = time! + 1.seconds;
          return Text(
            time!.inSeconds.toString(),
            style: TextStyle(
                fontSize: 20,
                color: Color.fromARGB(255, 255, 251, 0),
                fontWeight: FontWeight.bold),
          );
        }),
        Text("Attempts:",
            style: TextStyle(
                fontSize: 20, color: white, fontWeight: FontWeight.bold)),
        Text(
          tryCount.toString(),
          style: TextStyle(
              fontSize: 20,
              color: Color.fromARGB(255, 255, 251, 0),
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget buildNumpad(int no) {
    return Flexible(
      child: AspectRatio(
        aspectRatio: 1,
        child: GestureDetector(
          onTap: () {
            if (pinController.text.length < 4) {
              if (numpad[no] == 0) {
                numpad[no]++;
                pinController.text += no.toString();
                setState(() {});
              }
            }
          },
          child: Card(
            elevation: 0,
            color: numpad[no] == 0 ? activeBlue.withOpacity(0.05) : activeBlue,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: activeBlue.withOpacity(0.5))),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  no.toString(),
                  style: normal.copyWith(
                      color: numpad[no] == 0
                          ? activeBlue
                          : const Color.fromARGB(255, 0, 0, 0)),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildindicator(int no) {
    return Container(
      height: 50,
      child: AspectRatio(
        aspectRatio: 1,
        child: GestureDetector(
          onTap: () {
            indArray[no]++;
            print(indArray[no]);
            if (indArray[no] > 2) {
              indArray[no] = 0;
            }
            setState(() {});
          },
          child: Card(
            elevation: 0,
            color: indArray[no] == 0
                ? Colors.white
                : indArray[no] == 1
                    ? CupertinoColors.activeGreen.withOpacity(0.3)
                    : CupertinoColors.activeOrange.withOpacity(0.3),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
                side: BorderSide(color: Colors.grey.withOpacity(0.5))),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: Text(
                  no.toString(),
                  style: normal,
                ),
              ),
            ),
          ),
        ),
      ),
    );
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
                        offset: Offset(1, 1),
                        blurRadius: 6,
                        spreadRadius: 2)
                  ]),
              alignment: Alignment.center,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Text(
                    title = title! + " ",
                    style: TextStyle(
                        color: ispressed ? activeBlue : white,
                        fontSize: 22,
                        fontWeight: FontWeight.w300),
                  ),
                  icon != null
                      ? Icon(
                          icon,
                          color: Colors.white,
                        )
                      : Container()
                ],
              )),
        ),
      ),
    );
  }

  Widget buildPopup() {
    return Container(
      //color: Colors.red,
      child: Center(
          child: Container(
              height: MediaQuery.of(context).size.height * 0.6,
              width: MediaQuery.of(context).size.width * 0.75,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    Icon(
                      LineIcons.trophy,
                      size: 100,
                      color: CupertinoColors.systemYellow,
                    ),
                    Text(
                      "GOOD JOB!!!",
                      style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.8),
                    ),
                    Text(
                      "code: ${pinArray.join()}",
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          letterSpacing: 0.8),
                    ),
                    Text(
                      "Total time taken: ${time?.inSeconds} Sec",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                          letterSpacing: 0.8),
                    ),
                    Text(
                      "Tries taken: ${tryCount.toString()}",
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                          letterSpacing: 0.8),
                    ),
                    // Text(
                    //   "Tries taken: ${tryCount.toString()}",
                    //   style:
                    //       TextStyle(fontSize: 18, fontWeight: FontWeight.w300, letterSpacing: 0.8),
                    // ),
                    buttonUi(
                      title: "Next",
                      callback: () {
                        Navigator.of(context).pop();
                        Navigator.of(context).pushReplacement(MaterialPageRoute(
                            builder: (context) => GamePage()));
                      },
                      icon: LineIcons.angleRight,
                    ),

                    buttonUi(
                        title: "Main Menu",
                        callback: () {
                          Navigator.of(context).pop();
                          Navigator.of(context).pushReplacement(
                              MaterialPageRoute(builder: (context) => MyApp()));
                        })
                  ],
                ),
              ))),
    );
  }
}

class AlwaysDisabledFocusNode extends FocusNode {
  @override
  bool get hasFocus => false;
}
