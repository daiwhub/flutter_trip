import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

const CATCH_URLS = [
  'm.ctrip.com/',
  'm.ctrip.com/html5/',
  'm.ctrip.com/html5',
  'm.ctrip.com/webapp/you/'
];

class WebView extends StatefulWidget {
  String url;
  final String statusBarColor;
  final String title;
  final bool hideAppBar;
  final bool backForbid;

  WebView(
      {this.url,
      this.statusBarColor,
      this.title,
      this.hideAppBar,
      this.backForbid = false}) {
    if (url != null && url.contains('ctrip.com')) {
      //fix 携程H5 http://无法打开问题
      url = url.replaceAll("http://", 'https://');
    }
  }

  @override
  _WebViewState createState() => _WebViewState();
}

class _WebViewState extends State<WebView> {
  final flutterWebViewPlugin = FlutterWebviewPlugin();
  StreamSubscription<String> _urlChangeStream;
  StreamSubscription<WebViewStateChanged> _stateStream;
  StreamSubscription<WebViewHttpError> _httpErrorStream;

  bool exiting = false;

  @override
  void initState() {
    super.initState();
    flutterWebViewPlugin.close();
    _urlChangeStream = flutterWebViewPlugin.onUrlChanged.listen((String url) {
      print('url = ' + url);
    });
    _stateStream =
        flutterWebViewPlugin.onStateChanged.listen((WebViewStateChanged state) {
      switch (state.type) {
        case WebViewState.startLoad:
          if (_isToMain(state.url) && !exiting) {
            if (widget.backForbid) {
              flutterWebViewPlugin.launch(widget.url);
            } else {
              Navigator.pop(context);
              exiting = true;
            }
          }
          break;
        default:
          break;
      }
    });
    _httpErrorStream =
        flutterWebViewPlugin.onHttpError.listen((WebViewHttpError error) {});
  }

  _isToMain(String url) {
    bool isResult = false;
    for (final value in CATCH_URLS) {
      if (url?.endsWith(value) ?? false) {
        isResult = true;
        break;
      }
    }
    return isResult;
  }

  @override
  void dispose() {
    _stateStream.cancel();
    _urlChangeStream.cancel();
    _httpErrorStream.cancel();
    flutterWebViewPlugin.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String statusBarColorStr = widget.statusBarColor ?? 'ffffff';
    Color backButtonColor;
    if (statusBarColorStr == 'ffffff') {
      backButtonColor = Colors.black;
    } else {
      backButtonColor = Colors.white;
    }

    return Scaffold(
      body: Column(
        children: <Widget>[
          _appBar(
              Color(int.parse("0xff" + statusBarColorStr)), backButtonColor),
          Expanded(
              child: WebviewScaffold(
            userAgent: 'null',
            //防止携程H5页面重定向到打开携程APP ctrip://wireless/xxx的网址
            url: widget.url,
            withZoom: true,
            withLocalStorage: true,
            hidden: true,
            initialChild: Container(
              color: Colors.white,
              child: Center(
                child: Text('Waiting...'),
              ),
            ),
          ))
        ],
      ),
    );
  }

  _appBar(Color backgroundColor, Color backButtonColor) {
    if (widget.hideAppBar ?? false) {
      return Container(
        color: backgroundColor,
        height: 30,
      );
    }
    return Container(
      color: backgroundColor,
      child: Padding(
        padding: EdgeInsets.fromLTRB(0, 40, 0, 10),
        child: FractionallySizedBox(
          widthFactor: 1,
          child: Stack(
            children: <Widget>[
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Container(
                  margin: EdgeInsets.only(left: 10),
                  child: Icon(
                    Icons.close,
                    color: backButtonColor,
                    size: 26,
                  ),
                ),
              ),
              Positioned(
                  left: 0,
                  right: 0,
                  child: Center(
                    child: Text(
                      widget.title ?? '',
                      style: TextStyle(fontSize: 20, color: backButtonColor),
                    ),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}
