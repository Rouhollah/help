import 'package:flutter/material.dart';
import 'package:help/models/game_status.dart';
import 'package:help/services/inherited_provider.dart';

class InheritedDataWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final data = InheritedProvider.of<GameStatus>(context);
    return Container(
      child: Column(
        children: <Widget>[
          Text('Parent'),
          Text("${data.ballPostion}"),
          Text("${data.started}"),
          Text("${data.leftPositionOfCursor}"),
          //InheritedDataWidgetChild()
        ],
      ),
    );
  }
}
