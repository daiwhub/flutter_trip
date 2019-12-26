import 'package:flutter/material.dart';
import 'package:flutter_trip/model/common_model.dart';
import 'package:flutter_trip/widget/local_nav_item.dart';

class LocalNavWidget extends StatefulWidget {
  final List<CommonModel> localNavList;

  LocalNavWidget({Key key, @required this.localNavList}) : super(key: key);

  @override
  _LocalNavWidgetState createState() => _LocalNavWidgetState();
}

class _LocalNavWidgetState extends State<LocalNavWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(5))),
      child: Padding(
        padding: EdgeInsets.all(7),
        child: items(),
      ),
    );
  }

  items() {
    if (widget.localNavList == null) {
      return null;
    }
    List<Widget> items = [];
    widget.localNavList.forEach((model) {
      items.add(_item(model));
    });
    return Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween, children: items);
  }

  _item(CommonModel model) {
    return LocalNavItemWidget(
      model: model,
    );
  }
}
