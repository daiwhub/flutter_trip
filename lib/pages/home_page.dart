import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_swiper/flutter_swiper.dart';
import 'package:flutter_trip/dao/home_dao.dart';
import 'package:flutter_trip/model/common_model.dart';
import 'package:flutter_trip/model/config_model.dart';
import 'package:flutter_trip/model/gridnav_model.dart';
import 'package:flutter_trip/model/home_model.dart';
import 'package:flutter_trip/model/salesbox_model.dart';
import 'package:flutter_trip/widget/local_nav.dart';

///首页
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

const APPBAR_SCROLL_OFFSET = 100;

class _HomePageState extends State<HomePage> {
  List _imageUrls = [
    'http://pages.ctrip.com/commerce/promote/20180718/yxzy/img/640sygd.jpg',
    'https://dimg04.c-ctrip.com/images/700u0r000000gxvb93E54_810_235_85.jpg',
    'https://dimg04.c-ctrip.com/images/700c10000000pdili7D8B_780_235_57.jpg'
  ];

  double _appBarAlpha = 0;

  ConfigModel config;
  List<CommonModel> bannerList;
  List<CommonModel> localNavList;
  GridNavModel gridNav;
  List<CommonModel> subNavList;
  SalesBoxModel salesBox;

  String resultString;

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
      });
    }).catchError((e) {
      print(e);
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
    return
      Scaffold(
        backgroundColor: Color(0xfff2f2f2),
        body: Stack(
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
                    child: ListView(
                      children: <Widget>[
                        Container(
                          height: 160,
                          child: Swiper(
                            itemCount: _imageUrls.length,
                            itemBuilder: (BuildContext context, int index) {
                              return Image.network(
                                _imageUrls[index],
                                fit: BoxFit.fill,
                              );
                            },
                            autoplay: true,
                            pagination: SwiperPagination(),
                            controller: SwiperController(),
                          ),
                        ),
                        Container(
                          height: 800,
                          child: ListView(
                            children: <Widget>[
                              Padding(
                                padding: EdgeInsets.fromLTRB(7, 4, 7, 4),
                                child: LocalNavWidget(localNavList: localNavList),
                              )
                            ],
                          ),
                        )
                      ],
                    ))),
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
        ),
      );
  }
}
