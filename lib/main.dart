import 'package:magic5/color.dart';
import 'package:magic5/startPage.dart';
import 'package:flutter/material.dart';
import 'package:vitality/vitality.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
            // This is the theme of your application.
            //
            // Try running your application with "flutter run". You'll see the
            // application has a blue toolbar. Then, without quitting the app, try
            // changing the primarySwatch below to Colors.green and then invoke
            // "hot reload" (press "r" in the console where you ran "flutter run",
            // or simply save your changes to "hot reload" in a Flutter IDE).
            // Notice that the counter didn't reset back to zero; the application
            // is not restarted.
            primaryColor: activeBlue,
            secondaryHeaderColor: activeBlue),
        home: Stack(
          children: <Widget>[
            Vitality.randomly(
              background: Colors.black,
              maxOpacity: 0.8,
              minOpacity: 0.3,
              itemsCount: 80,
              enableXMovements: false,
              whenOutOfScreenMode: WhenOutOfScreenMode.Teleport,
              maxSpeed: 1.5,
              maxSize: 30,
              minSpeed: 0.5,
              randomItemsColors: [Colors.yellowAccent, Colors.white],
              randomItemsBehaviours: [
                ItemBehaviour(shape: ShapeType.Icon, icon: Icons.star),
                ItemBehaviour(shape: ShapeType.Icon, icon: Icons.star_border),
                ItemBehaviour(shape: ShapeType.StrokeCircle),
              ],
            ),
            StartPage(),
          ],
        )
        //child: StartPage(),
        );
  }
}

class HexColor extends Color {
  HexColor(final String hexColor) : super(_getColorFromHex(hexColor));

  static int _getColorFromHex(String hexColor) {
    hexColor = hexColor.toUpperCase().replaceAll('#', '');
    if (hexColor.length == 6) {
      hexColor = 'FF$hexColor';
    }
    return int.parse(hexColor, radix: 16);
  }
}
