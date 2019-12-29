import 'package:flutter/material.dart';
import 'package:flutter_trip/model/common_model.dart';
import 'package:flutter_trip/model/gridnav_model.dart';

class GridNavWidget extends StatefulWidget {
  final GridNavModel gridNavModel;

  GridNavWidget({Key key, @required this.gridNavModel}) : super(key: key);

  @override
  _GridNavWidgetState createState() => _GridNavWidgetState();
}

class _GridNavWidgetState extends State<GridNavWidget> {
  @override
  Widget build(BuildContext context) {
    return PhysicalModel(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(6),
      clipBehavior: Clip.antiAlias,
      child: Column(
        children: _gridNavItems(context),
      ),
    );
  }

  _gridNavItems(BuildContext context) {
    List<Widget> items = [];
    if (widget.gridNavModel == null) return items;

    if (widget.gridNavModel.hotel != null) {
      items.add(_gridNavItem(context, widget.gridNavModel.hotel));
    }
    if (widget.gridNavModel.hotel != null) {
      items.add(_gridNavItem(context, widget.gridNavModel.flight));
    }
    if (widget.gridNavModel.hotel != null) {
      items.add(_gridNavItem(context, widget.gridNavModel.travel));
    }

    return items;
  }

  _gridNavItem(BuildContext context, GridNavItem gridNavItem) {
    List<Widget> items = [];
    items.add(_mainItem(context, gridNavItem.mainItem));
    items.add(_doubleItem(context, gridNavItem.item1, gridNavItem.item2));
    items.add(_doubleItem(context, gridNavItem.item3, gridNavItem.item4));

    List<Widget> itemNav = [];

    items.forEach((item) {
      itemNav.add(Expanded(
        child: item,
        flex: 1,
      ));
    });

    Color startColor = Color(int.parse("0xff" + gridNavItem.startColor));
    Color endColor = Color(int.parse("0xff" + gridNavItem.endColor));

    return Container(
      height: 88,
      decoration: BoxDecoration(
          gradient: LinearGradient(colors: [startColor, endColor])),
      child: Row(
        children: itemNav,
      ),
    );
  }

  _mainItem(BuildContext context, CommonModel model) {
    return _wrapGesture(
        context,
        model,
        Stack(
          alignment: AlignmentDirectional.topCenter,
          children: <Widget>[
            Image.network(
              model.icon,
              height: 88,
              width: 120,
              alignment: AlignmentDirectional.bottomEnd,
            ),
            Container(
              margin: EdgeInsets.only(top: 11),
              child: Text(
                model.title,
                textAlign: TextAlign.center,
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            )
          ],
        ));
  }

  _doubleItem(
      BuildContext context, CommonModel topModel, CommonModel bottomModel) {
    List<Widget> items = [];
    items.add(Expanded(
      child: _item(context, topModel, true),
    ));
    items.add(Expanded(
      child: _item(context, bottomModel, false),
    ));

    return Column(
      children: items,
    );
  }

  _item(BuildContext context, CommonModel model, isTop) {
    BorderSide borderSide = BorderSide(width: 0.8, color: Colors.white);
    return FractionallySizedBox(
      widthFactor: 1,
      child: _wrapGesture(
          context,
          model,
          Container(
            decoration: BoxDecoration(
                border: Border(
                    left: borderSide,
                    bottom: isTop ? borderSide : BorderSide.none)),
            child: Center(
              child: Text(
                model.title,
                style: TextStyle(fontSize: 14, color: Colors.white),
              ),
            ),
          )),
    );
  }

  _wrapGesture(BuildContext context, CommonModel model, Widget widget) {
    return GestureDetector(
      onTap: () {},
      child: widget,
    );
  }
}
