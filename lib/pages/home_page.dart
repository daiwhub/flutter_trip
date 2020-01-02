import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_trip/dao/home_dao.dart';
import 'package:flutter_trip/model/common_model.dart';
import 'package:flutter_trip/model/config_model.dart';
import 'package:flutter_trip/model/gridnav_model.dart';
import 'package:flutter_trip/model/home_model.dart';
import 'package:flutter_trip/model/salesbox_model.dart';
import 'package:flutter_trip/widget/grid_nav.dart';
import 'package:flutter_trip/widget/loading_container.dart';
import 'package:flutter_trip/widget/local_nav.dart';
import 'package:flutter_trip/widget/sales_box.dart';
import 'package:flutter_trip/widget/sub_nav.dart';
import 'package:flutter_trip/widget/webview.dart';

///首页
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

const APPBAR_SCROLL_OFFSET = 100;

class _HomePageState extends State<HomePage> {
  double _appBarAlpha = 0;

  ConfigModel config;
  List<CommonModel> bannerList = [];
  List<CommonModel> localNavList = [];
  GridNavModel gridNav;
  List<CommonModel> subNavList = [];
  SalesBoxModel salesBox;

  String resultString;

  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadData();
  }

  Future<Null> _loadData() async {
    HomeDao.fetch().then((homeModel) {
      setState(() {
        config = homeModel.config;
        bannerList = homeModel.bannerList;
        localNavList = homeModel.localNavList;
        gridNav = homeModel.gridNav;
        subNavList = homeModel.subNavList;
        salesBox = homeModel.salesBox;

        isLoading = false;
      });
    }).catchError((e) {
      print(e);

      setState(() {
        isLoading = false;
      });
    });

//    try{
//     HomeModel homeModel = await HomeDao.fetch();
//     setState(() {
////       config = homeModel.config;
////       bannerList = homeModel.bannerList;
////       localNavList = homeModel.localNavList;
////       gridNav = homeModel.gridNav;
////       subNavList = homeModel.subNavList;
////       salesBox = homeModel.salesBox;
//       resultString = json.encode(homeModel.toJson());
//     });
//    }catch(e){
//      print(e);
//    }
  }

  _onScroll(offset) {
    double alpha = offset / APPBAR_SCROLL_OFFSET;
    if (alpha < 0) {
      alpha = 0;
    } else if (alpha > 1) {
      alpha = 1;
    }
    setState(() {
      _appBarAlpha = alpha;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff2f2f2),
      body: RefreshIndicator(
        child: _loadingView(isLoading),
        onRefresh: _loadData,
      ),
    );
  }

  _loadingView(bool isLoading) {
    return LoadingContainer(child: _stack(), isLoading: isLoading);
  }

  _stack() {
    return Stack(
      children: <Widget>[
        // ignore: missing_return
        MediaQuery.removePadding(
            context: context,
            removeTop: true,
            child: NotificationListener(
                // ignore: missing_return
                onNotification: (scrollNotification) {
                  // ignore: missing_return
                  if (scrollNotification is ScrollUpdateNotification &&
                      scrollNotification.depth == 0) {
                    //滚动且是列表滚动的时候
                    // ignore: missing_return
                    _onScroll(scrollNotification.metrics.pixels);
                  }
                },
                child: _listView())),
        Opacity(
          opacity: _appBarAlpha,
          child: Container(
            height: 80,
            decoration: BoxDecoration(color: Colors.white),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text('首页'),
              ),
            ),
          ),
        )
      ],
    );
  }

  _banner() {
    return Container(
      height: 160,
      child: Swiper(
        itemCount: bannerList?.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              CommonModel model = bannerList[index];
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
            child: Image.network(
              bannerList[index].icon,
              fit: BoxFit.fill,
            ),
          );
        },
        autoplay: true,
        pagination: SwiperPagination(),
        controller: SwiperController(),
      ),
    );
  }

  _listView() {
    return ListView(
      children: <Widget>[
        _banner(),
        Padding(
          padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
          child: LocalNavWidget(localNavList: localNavList),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(7, 3, 7, 3),
          child: GridNavWidget(
            gridNavModel: gridNav,
          ),
        ),
        Padding(
          padding: EdgeInsets.fromLTRB(7, 0, 7, 0),
          child: SubNav(
            subNavList: subNavList,
          ),
        ),
        Padding(
            padding: EdgeInsets.fromLTRB(7, 7, 7, 4),
            child: SalesBox(
              salesBox: salesBox,
            ))
      ],
    );
  }
}
