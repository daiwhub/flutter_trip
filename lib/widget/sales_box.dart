import 'package:flutter/material.dart';
import 'package:flutter_trip/model/common_model.dart';
import 'package:flutter_trip/model/salesbox_model.dart';
import 'package:flutter_trip/widget/webview.dart';

///底部活动
class SalesBox extends StatefulWidget {
  final SalesBoxModel salesBox;

  SalesBox({this.salesBox});

  @override
  _SalesBoxState createState() => _SalesBoxState();
}

class _SalesBoxState extends State<SalesBox> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.all(Radius.circular(6)),
      ),
      child: Column(
        children: _items(context, widget.salesBox),
      ),
    );
  }

  _items(BuildContext context, SalesBoxModel salesBox) {
    List<Widget> items = [];

    if (salesBox == null) return items;

    items.add(_toItem(context, salesBox.icon, salesBox.moreUrl));
    items.add(_doubleItems(
        context, salesBox.bigCard1, salesBox.bigCard2, true, false));
    items.add(_doubleItems(
        context, salesBox.smallCard1, salesBox.smallCard2, false, false));
    items.add(_doubleItems(
        context, salesBox.smallCard3, salesBox.smallCard4, false, true));
    return items;
  }

  _toItem(BuildContext context, String icon, String moreUrl) {
    return Container(
      height: 44,
      decoration: BoxDecoration(
          border:
              Border(bottom: BorderSide(width: 1.0, color: Color(0xfff2f2f2)))),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 10),
            child: Image.network(
              icon,
              height: 15,
              fit: BoxFit.fill,
            ),
          ),
          Container(
            padding: EdgeInsets.fromLTRB(10, 1, 8, 1),
            margin: EdgeInsets.only(right: 7),
            decoration: BoxDecoration(
                color: Colors.pink[100],
                borderRadius: BorderRadius.circular(12),
                gradient: LinearGradient(colors: [
                  Color(0xffff4e63),
                  Color(0xffff6cc9),
                ], begin: Alignment.centerLeft, end: Alignment.centerRight)),
            child: GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => WebView(
                              url: moreUrl,
                              title: '更多福利',
                            )));
              },
              child: Text(
                '获取更多福利 >',
                style: TextStyle(fontSize: 8, color: Colors.white),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

_doubleItems(BuildContext context, CommonModel leftModel,
    CommonModel rightModel, bool isBig, bool isLast) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: <Widget>[
      _item(context, leftModel, isBig, true, isLast),
      _item(context, rightModel, isBig, false, isLast),
    ],
  );
}

_item(BuildContext context, CommonModel model, bool isBig, bool isLeft,
    bool isLast) {
  BorderSide borderSide = BorderSide(width: 0.8, color: Color(0xfff2f2f2));

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
    child: Container(
      decoration: BoxDecoration(
          border: Border(
              right: isLeft ? borderSide : BorderSide.none,
              bottom: isLast ? BorderSide.none : borderSide)),
      child: Image.network(
        model.icon,
        width: MediaQuery.of(context).size.width / 2 - 10,
        height: isBig ? 129 : 88,
      ),
    ),
  );
}
