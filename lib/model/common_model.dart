//String icon	String	Nullable
//String title	String	Nullable
//String url	String	NonNull
//String statusBarColor	String	Nullable
//bool hideAppBar	bool	Nullable
///
class CommonModel {
  final String icon;
  final String title;
  final String url;
  final String statusBarColor;
  final bool hideAppBar;

  CommonModel(
      {this.icon, this.title, this.url, this.statusBarColor, this.hideAppBar});

  factory CommonModel.fromJson(Map<String, dynamic> json) {
    return CommonModel(
        icon: json['icon'],
        title: json['title'],
        url: json['url'],
        statusBarColor: json['statusBarColor'],
        hideAppBar: json['hideAppBar']);
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> json = new Map();
    json['icon'] = this.icon;
    json['title'] = this.title;
    json['url'] = this.url;
    json['statusBarColor'] = this.statusBarColor;
    json['hideAppBar'] = this.hideAppBar;
    return json;
  }
}
