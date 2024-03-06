import '../entities/entities.dart';

class Sources {
  String sourcesId;
  String name;
  String icon;
  int color;

  Sources({
    required this.sourcesId,
    required this.name,
    required this.icon,
    required this.color,
  });

  static final empty = Sources(
    sourcesId: '',
    name: '',
    icon: '',
    color: 0,
  );

  SourcesEntity toEntity() {
    return SourcesEntity(
      sourcesId: sourcesId,
      name: name,
      icon: icon,
      color: color,
    );
  }

  static Sources fromEntity(SourcesEntity entity) {
    return Sources(
      sourcesId: entity.sourcesId,
      name: entity.name,
      icon: entity.icon,
      color: entity.color,
    );
  }
}
