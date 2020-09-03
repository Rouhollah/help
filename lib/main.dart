import 'dart:math';

import 'package:flutter/material.dart';
import 'package:help/board.dart';
import 'package:help/drag_object.dart';
import 'package:help/matrix.dart';
import 'package:help/staggerAnimation.dart';
import 'package:help/table_screen.dart';
import 'package:help/trackFinger.dart';

import 'custom_table.dart';
import 'movement.dart';
import 'play.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Define the various properties with default values. Update these properties
  // when the user taps a FloatingActionButton.
  double _width = 50;
  double _height = 50;
  Color _color = Colors.green;
  BorderRadiusGeometry _borderRadius = BorderRadius.circular(8);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('AnimatedContainer Demo'),
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                AnimatedContainer(
                  // Use the properties stored in the State class.
                  width: _width,
                  height: _height,
                  decoration: BoxDecoration(
                    color: _color,
                    borderRadius: _borderRadius,
                  ),
                  // Define how long the animation should take.
                  duration: Duration(seconds: 1),
                  // Provide an optional curve to make the animation feel smoother.
                  curve: Curves.fastOutSlowIn,
                ),
                Row(
                  children: [
                    Column(children: [
                      Container(
                        height: 50,
                        color: Colors.blue,
                        margin: EdgeInsets.all(8.0),
                        child: MaterialButton(
                            child: Text('Board'),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Board()),
                              );
                            }),
                      ),
                      Container(
                        height: 50,
                        color: Colors.blue,
                        margin: EdgeInsets.all(8.0),
                        child: MaterialButton(
                            child: Text('Straggerd Anim'),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ImagesDemo()),
                              );
                            }),
                      ),
                      Container(
                        height: 50,
                        color: Colors.blue,
                        margin: EdgeInsets.all(8.0),
                        child: MaterialButton(
                            child: Text('play'),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => StaggerDemo()),
                              );
                            }),
                      ),
                    ]),
                    Column(
                      // mainAxisAlignment: MainAxisAlignment.start,
                      // verticalDirection: VerticalDirection.down,
                      //crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 50,
                          color: Colors.blue,
                          margin: EdgeInsets.all(8.0),
                          child: MaterialButton(
                              child: Text('Go To Track Finger'),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => TrackFinger()),
                                );
                              }),
                        ),
                        Container(
                          height: 50,
                          color: Colors.amber[100],
                          margin: EdgeInsets.all(8.0),
                          child: MaterialButton(
                              child: Text('Go To Table'),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyTable()),
                                );
                              }),
                        ),
                        Container(
                          height: 50,
                          color: Colors.amber[100],
                          margin: EdgeInsets.all(8.0),
                          child: MaterialButton(
                              child: Text('Go To Matrix'),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Matrix()),
                                );
                              }),
                        ),
                        Container(
                          height: 50,
                          color: Colors.green[100],
                          margin: EdgeInsets.all(8.0),
                          child: MaterialButton(
                              child: Text('Go To Costum Table'),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => CustomTable()),
                                );
                              }),
                        ),
                        Container(
                          height: 50,
                          color: Colors.green[300],
                          margin: EdgeInsets.all(8.0),
                          child: MaterialButton(
                              child: Text('Drag Page'),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Drag()),
                                );
                              }),
                        ),
                        Container(
                          height: 50,
                          color: Colors.green[300],
                          margin: EdgeInsets.all(8.0),
                          child: MaterialButton(
                              child: Text('Movement Page'),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Movement()),
                                );
                              }),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.play_arrow),
          // When the user taps the button
          onPressed: () {
            // Use setState to rebuild the widget with new values.
            setState(() {
              // Create a random number generator.
              final random = Random();

              // Generate a random width and height.
              _width = random.nextInt(300).toDouble();
              _height = random.nextInt(300).toDouble();

              // Generate a random color.
              _color = Color.fromRGBO(
                random.nextInt(256),
                random.nextInt(256),
                random.nextInt(256),
                1,
              );

              // Generate a random border radius.
              _borderRadius =
                  BorderRadius.circular(random.nextInt(100).toDouble());
            });
          },
        ),
      ),
    );
  }
}
