import 'package:flutter/material.dart';

///加载进度条组件
class LoadingContainer extends StatefulWidget {
  final Widget child;
  final bool isLoading;
  final bool cover;

  LoadingContainer(
      {@required this.child, @required this.isLoading, this.cover = false});

  @override
  _LoadingContainerState createState() => _LoadingContainerState();
}

class _LoadingContainerState extends State<LoadingContainer> {
  @override
  Widget build(BuildContext context) {
    return !widget.cover
        ? !widget.isLoading ? widget.child : _loadingView
        : Stack(
            children: <Widget>[
              widget.child,
              widget.isLoading ? _loadingView : Container()
            ],
          );
  }
}

Widget get _loadingView {
  return Center(
    child: CircularProgressIndicator(),
  );
}
