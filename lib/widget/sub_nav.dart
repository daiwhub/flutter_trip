import 'package:flutter/material.dart';
import 'package:flutter_trip/model/common_model.dart';
import 'package:flutter_trip/widget/webview.dart';

///活动入口
class SubNav extends StatefulWidget {
  final List<CommonModel> subNavList;

  SubNav({this.subNavList});

  @override
  _SubNavState createState() => _SubNavState();
}

class _SubNavState extends State<SubNav> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: _items(context),
    );
  }

  _items(BuildContext context) {
    List<Widget> items = [];
    if (widget.subNavList == null) {
      return items;
    }

    int line = (widget.subNavList.length / 2 + 0.5).toInt();

    List<CommonModel> topList = widget.subNavList.sublist(0, line);
    List<CommonModel> bottomList =
        widget.subNavList.sublist(line, widget.subNavList.length);

    items.add(_rowItem(context, topList));
    items.add(_rowItem(context, bottomList));

    return items;
  }

  _rowItem(BuildContext context, List<CommonModel> rowSubList) {
    List<Widget> items = [];

    for (final value in rowSubList) {
      items.add(Expanded(flex: 1, child: _item(context, value)));
    }

    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: Row(
        children: items,
      ),
    );
  }

  _item(BuildContext context, CommonModel model) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => WebView(
                      url: model.url,
                      statusBarColor: model.statusBarColor,
                      title: model.title,
                      hideAppBar: model.hideAppBar,
                    )));
      },
      child: Column(
        children: <Widget>[
          Image.network(
            model.icon,
            width: 20,
            height: 20,
          ),
          Center(
            child: Text(
              model.title,
              style: TextStyle(fontSize: 10, color: Colors.black),
            ),
          )
        ],
      ),
    );
  }
}
