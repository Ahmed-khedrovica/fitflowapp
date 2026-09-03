class Exercise {
  const Exercise({
    required this.id,
    required this.title,
    required this.videoUrl,
    required this.thumbnailUrl,
    required this.equipment,
    required this.muscles,
    required this.formCues,
  });

  factory Exercise.fromJson(Map<String, dynamic> json) {
    return Exercise(
      id: json['id'] as String,
      title: _localizedText(json['title']),
      videoUrl: json['video_url'] as String,
      thumbnailUrl: json['thumbnail_url'] as String,
      equipment: _stringList(json['equipment']),
      muscles: ExerciseMuscles.fromJson(
        Map<String, dynamic>.from(json['muscles'] as Map),
      ),
      formCues: _localizedList(json['form_cues']),
    );
  }

  final String id;
  final Map<String, String> title;
  final String videoUrl;
  final String thumbnailUrl;
  final List<String> equipment;
  final ExerciseMuscles muscles;
  final Map<String, List<String>> formCues;

  String localizedTitle(String languageCode) =>
      title[languageCode] ?? title['en'] ?? '';

  List<String> localizedFormCues(String languageCode) =>
      formCues[languageCode] ?? formCues['en'] ?? const [];

  static List<String> _stringList(Object? value) {
    return (value as List<dynamic>).cast<String>();
  }

  static Map<String, String> _localizedText(Object? value) {
    final json = value as Map<String, dynamic>;
    return json.map((key, text) => MapEntry(key, text as String));
  }

  static Map<String, List<String>> _localizedList(Object? value) {
    final json = value as Map<String, dynamic>;
    return json.map((key, list) => MapEntry(key, _stringList(list)));
  }
}

class ExerciseMuscles {
  const ExerciseMuscles({
    required this.primary,
    required this.secondary,
    required this.stabilizers,
  });

  factory ExerciseMuscles.fromJson(Map<String, dynamic> json) {
    return ExerciseMuscles(
      primary: Exercise._stringList(json['primary']),
      secondary: Exercise._stringList(json['secondary']),
      stabilizers: Exercise._stringList(json['stabilizers']),
    );
  }

  final List<String> primary;
  final List<String> secondary;
  final List<String> stabilizers;
}
