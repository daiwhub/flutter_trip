//GridNavItem hotel	Object	NonNull
//GridNavItem flight	Object	NonNull
//GridNavItem travel	Object	NonNull
import 'package:flutter_trip/model/common_model.dart';

///

class GridNavModel {
  final GridNavItem hotel;
  final GridNavItem flight;
  final GridNavItem travel;

  GridNavModel({this.hotel, this.flight, this.travel});

  factory GridNavModel.fromJson(Map<String, dynamic> json) {
    return GridNavModel(
      hotel: GridNavItem.fromJson(json['hotel']),
      flight: GridNavItem.fromJson(json['flight']),
      travel: GridNavItem.fromJson(json['travel']),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = new Map();
    json['hotel'] = this.hotel;
    json['flight'] = this.flight;
    json['travel'] = this.travel;

    return json;
  }
}

//String startColor	String	NonNull
//String endColor	String	NonNull
//CommonModel mainItem	Object	NonNull
//CommonModel item1	Object	NonNull
//CommonModel item2	Object	NonNull
//CommonModel item3	Object	NonNull
//CommonModel item4	Object	NonNull
class GridNavItem {
  final String startColor;
  final String endColor;
  final CommonModel mainItem;
  final CommonModel item1;
  final CommonModel item2;
  final CommonModel item3;
  final CommonModel item4;

  GridNavItem(
      {this.startColor,
      this.endColor,
      this.mainItem,
      this.item1,
      this.item2,
      this.item3,
      this.item4});

  factory GridNavItem.fromJson(Map<String, dynamic> json) {
    return GridNavItem(
      startColor: json['startColor'],
      endColor: json['endColor'],
      mainItem: CommonModel.fromJson(json['mainItem']),
      item1: CommonModel.fromJson(json['item1']),
      item2: CommonModel.fromJson(json['item2']),
      item3: CommonModel.fromJson(json['item3']),
      item4: CommonModel.fromJson(json['item4']),
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = new Map();
    json['startColor'] = this.startColor;
    json['endColor'] = this.endColor;
    json['mainItem'] = this.mainItem;
    json['item1'] = this.item1;
    json['item2'] = this.item2;
    json['item3'] = this.item3;
    json['item4'] = this.item4;

    return json;
  }
}
