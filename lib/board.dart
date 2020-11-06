import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:help/boxes.dart';
import 'package:help/models/cursor.dart';
import 'package:help/models/game_status.dart';
import 'package:help/models/level.dart';
import 'package:help/movement.dart';
import 'package:help/repository/load_level_repo.dart';
import 'package:help/services/load_level_service.dart';
import 'package:provider/provider.dart';

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
    Future<dynamic> _calculation = levelService.parseJson().then((value) {
      return value;
    });
    return ChangeNotifierProvider<GameStatus>(
        create: (context) => GameStatus(),
        child: FutureBuilder(
            future: _calculation,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                // Future hasn't finished yet, return a placeholder
                return Align(
                    alignment: Alignment.center, child: Text('Loading'));
              } else if (snapshot.hasError) {
                return Center(child: Text("${snapshot.error}"));
              } else {
                var rest = snapshot.data['levels'] as List;
                var list =
                    rest.map<Level>((json) => Level.fromJson(json)).toList();
                // return Stack(children: [TrackFinger(), Boxes(), Movement()]);
                return Container(
                    color: Colors.green[100],
                    child: GridView.count(
                      crossAxisCount: 4,
                      scrollDirection: Axis.vertical,
                      children: List.generate(list.length, (index) {
                        return RaisedButton(
                            onPressed: () {
                              loadLevel(index);
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
                    )

                    // .builder(
                    //     itemCount: list.length,
                    //     itemBuilder: (context, index) {
                    //       return MaterialButton(

                    //         onPressed: loadLevel(index),
                    //         color: Colors.white,
                    //         child: Text(
                    //           "${index + 1}",
                    //           style: TextStyle(fontSize: 24),
                    //         ),
                    //         padding: EdgeInsets.all(16),
                    //         shape: CircleBorder(),
                    //       );
                    //     }),
                    );
              }
            }));
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

  /// ساخت دکمه هر مرحله
  // Future<dynamic> createButtonLeves() async {
  //   LoadLevelService levelService = new LoadLevelService();
  //   // var g = Provider.of<GameStatus>(context, listen: false);
  //   _calculation = await levelService.parseJson().then((value) {
  //     return value;
  //   });
  // //GameStatus game = new GameStatus();
  // print("print from board :${g.levelsList}");
  //   return ListView.builder(
  //       itemCount: levelsList.length,
  //       itemBuilder: (context, index) {
  //         return MaterialButton(
  //           onPressed: loadLevel(index),
  //           color: Colors.white,
  //           child: Text(
  //             "${index + 1}",
  //           ),
  //           padding: EdgeInsets.all(16),
  //           shape: CircleBorder(),
  //         );
  //       });
  // });
  //}

  loadLevel(index) {
    print("load Level ${index + 1}");
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIOverlays(SystemUiOverlay.values);
    super.dispose();
  }
}
