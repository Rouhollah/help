import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:help/models/cursor.dart';
import 'package:help/models/level.dart';
import 'package:help/play.dart';
import 'package:help/services/load_level_service.dart';

class Board extends StatefulWidget {
  @override
  _BoardState createState() => _BoardState();
}

class _BoardState extends State<Board> {
  Random random = new Random();
  Cursor cursor = new Cursor();

  @override
  void initState() {
    SystemChrome.setEnabledSystemUIOverlays([]);
    super.initState();

    // content دسترسی به
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Schedule code execution once after the frame has rendered
      // print(MediaQuery.of(context).size.toString());
    });
    //or
    // new Future.delayed(Duration.zero, () {
    //       // Schedule a zero-delay future to be executed
    //       print(MediaQuery.of(context).size.toString());
    //   });
  }

  @override
  Widget build(BuildContext context) {
    LoadLevelService levelService = new LoadLevelService();
    Future<dynamic> levelList = levelService.parseJson().then((value) {
      return value;
    });
    return FutureBuilder(
        future: levelList,
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            // Future hasn't finished yet, return a placeholder
            return Align(alignment: Alignment.center, child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text("${snapshot.error}"));
          } else {
            var rest = snapshot.data['levels'] as List;
            var list = rest.map<Level>((json) => Level.fromJson(json)).toList();

            return Container(
                color: Colors.green[100],
                child: GridView.count(
                  crossAxisCount: 4,
                  scrollDirection: Axis.vertical,
                  children: List.generate(list.length, (index) {
                    return RaisedButton(
                        onPressed: () {
                          Level level = list.where((element) => element.level == index + 1).first;
                          loadLevel(level);
                        },
                        //color: Colors.purple,
                        child: Text(
                          "${index + 1}",
                          style: TextStyle(fontSize: 30),
                        ),
                        // shape: RoundedRectangleBorder(
                        //     borderRadius: BorderRadius.circular(100))
                        shape: StadiumBorder());
                  }),
                ));
          }
        });
    // return SafeArea(
    //   top: true,
    //   bottom: true,
    //   child: Stack(children: [
    //     TrackFinger(),
    //     Boxes(),
    //     Movement(),
    //   ]),
    // );
  }

  loadLevel(level) {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Play(level)));
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    super.dispose();
  }
}
