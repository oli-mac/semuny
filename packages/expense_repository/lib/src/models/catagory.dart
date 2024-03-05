import '../entities/entities.dart';

class Catagory {
  String catagoryId;
  String name;
  int totalExpenses;
  String icon;
  int color;

  Catagory({
    required this.catagoryId,
    required this.name,
    required this.totalExpenses,
    required this.icon,
    required this.color,
  });

  static final empty = Catagory(
    catagoryId: '',
    name: '',
    totalExpenses: 0,
    icon: '',
    color: 0,
  );

  CatagoryEntity toEntity() {
    return CatagoryEntity(
      catagoryId: catagoryId,
      name: name,
      totalExpenses: totalExpenses,
      icon: icon,
      color: color,
    );
  }

  static Catagory fromEntity(CatagoryEntity entity) {
    return Catagory(
      catagoryId: entity.catagoryId,
      name: entity.name,
      totalExpenses: entity.totalExpenses,
      icon: entity.icon,
      color: entity.color,
    );
  }
}
