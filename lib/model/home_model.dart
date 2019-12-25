//ConfigModel config	Object	NonNull
//List<CommonModel> bannerList	Array	NonNull
//List<CommonModel> localNavList	Array	NonNull
//GridNavModel gridNav	Object	NonNull
//List<CommonModel> subNavList	Array	NonNull
//SalesBoxModel salesBox	Object	NonNull
import 'package:flutter_trip/model/common_model.dart';
import 'package:flutter_trip/model/config_model.dart';
import 'package:flutter_trip/model/gridnav_model.dart';
import 'package:flutter_trip/model/salesbox_model.dart';

///首页
class HomeModel {
  final ConfigModel config;
  final List<CommonModel> bannerList;
  final List<CommonModel> localNavList;
  final GridNavModel gridNav;
  final List<CommonModel> subNavList;
  final SalesBoxModel salesBox;

  HomeModel(
      {this.config,
      this.bannerList,
      this.localNavList,
      this.gridNav,
      this.subNavList,
      this.salesBox});

  factory HomeModel.fromJson(Map<String, dynamic> json) {
    var bannerListJson = json['bannerList'] as List;
    List<CommonModel> bannerList =
        bannerListJson.map((i) => CommonModel.fromJson(i)).toList();

    var localNavListJson = json['localNavList'] as List;
    List<CommonModel> localNavList =
        localNavListJson.map((i) => CommonModel.fromJson(i)).toList();

    var subNavListJson = json['subNavList'] as List;
    List<CommonModel> subNavList =
        subNavListJson.map((i) => CommonModel.fromJson(i)).toList();

    return HomeModel(
      config: ConfigModel.fromJson(json['config']),
      bannerList: bannerList,
      localNavList: localNavList,
      gridNav: GridNavModel.fromJson(json['gridNav']),
      subNavList: subNavList,
      salesBox: SalesBoxModel.fromJson(json['salesBox']),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = new Map();
    json['config'] = this.config;
    json['bannerList'] = this.bannerList;
    json['localNavList'] = this.localNavList;
    json['gridNav'] = this.gridNav;
    json['subNavList'] = this.subNavList;
    json['cosalesBoxnfig'] = this.salesBox;

    return json;
  }
}
