class SourcesEntity {
  String sourcesId;
  String name;
  String icon;
  int color;

  SourcesEntity({
    required this.sourcesId,
    required this.name,
    required this.icon,
    required this.color,
  });

  Map<String, Object?> toDocument() {
    return {
      'sourcesId': sourcesId,
      'name': name,
      'icon': icon,
      'color': color,
    };
  }

  static SourcesEntity fromDocument(Map<String, dynamic> doc) {
    return SourcesEntity(
      sourcesId: doc['sourcesId'] as String,
      name: doc['name'] as String,
      icon: doc['icon'] as String,
      color: doc['color'] as int,
    );
  }
}
