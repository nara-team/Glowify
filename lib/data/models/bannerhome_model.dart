class BannerSliderModel {
  final String image;
  final String route;

  BannerSliderModel({required this.image, required this.route});

  factory BannerSliderModel.fromJson(Map<String, dynamic> json) {
    return BannerSliderModel(
      image: json['image'] as String,
      route: json['route'] as String,
    );
  }
}
