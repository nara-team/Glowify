class OnboardingModel {
  final String imagePath;
  final String title;
  final String subtitle;

  OnboardingModel({
    required this.imagePath,
    required this.title,
    required this.subtitle,
  });

  factory OnboardingModel.fromJson(Map<String, dynamic> json) {
    return OnboardingModel(
      imagePath: json['image_path'] ?? '',
      title: json['title'] ?? '',
      subtitle: json['subtitle'] ?? '',
    );
  }
}
