import 'package:flutter/material.dart';
import 'package:flutter_trip/model/common_model.dart';

class GridNavWidget extends StatefulWidget{

  final List<CommonModel> localNavList;


  GridNavWidget({Key key,@required this.localNavList}) : super(key :key);

  @override
  _GridNavWidgetState createState() => _GridNavWidgetState();
}

class _GridNavWidgetState  extends State<GridNavWidget>{
  @override
  Widget build(BuildContext context) {

    return null;
  }

}