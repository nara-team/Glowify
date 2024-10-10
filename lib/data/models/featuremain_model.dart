class MainFeatureModel {
  String? icon;
  String? route;
  String? title;

  MainFeatureModel({this.icon, this.route, this.title});

  factory MainFeatureModel.fromJson(Map<String, dynamic> json) {
    return MainFeatureModel(
      icon: json['icon'],
      route: json['route'],
      title: json['title'],
    );
  }
}
