class OnboardingGoal {
  const OnboardingGoal({
    required this.id,
    required this.title,
    required this.description,
  });

  factory OnboardingGoal.fromJson(Map<String, dynamic> json) {
    return OnboardingGoal(
      id: json['id'] as String,
      title: _localizedText(json['title']),
      description: _localizedText(json['description']),
    );
  }

  final String id;
  final Map<String, String> title;
  final Map<String, String> description;

  String localizedTitle(String languageCode) =>
      title[languageCode] ?? title['en'] ?? '';

  String localizedDescription(String languageCode) =>
      description[languageCode] ?? description['en'] ?? '';

  static Map<String, String> _localizedText(Object? value) {
    final json = value as Map<String, dynamic>;
    return json.map((key, text) => MapEntry(key, text as String));
  }
}
