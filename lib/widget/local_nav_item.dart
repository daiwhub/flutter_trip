
import 'package:flutter/material.dart';
import 'package:flutter_trip/model/common_model.dart';
///
class LocalNavItemWidget extends StatelessWidget{

  final CommonModel model;
  
  LocalNavItemWidget({Key key,this.model}) : super(key :key);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      child: GestureDetector(
        child: Column(
          children: <Widget>[
            Image.network(model.icon,width: 32,height: 32,),
            Text(model.title,style: TextStyle(fontSize: 12),)
          ],
        ),
      ),
    );
  }

}