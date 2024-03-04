class CatagoryEntity {
  String catagoryId;
  String name;
  int totalExpenses;
  String icon;
  String color;

  CatagoryEntity({
    required this.catagoryId,
    required this.name,
    required this.totalExpenses,
    required this.icon,
    required this.color,
  });

  //methods to change to document and from document
  Map<String, Object?> toDocument() {
    return {
      'catagoryId': catagoryId,
      'name': name,
      'totalExpenses': totalExpenses,
      'icon': icon,
      'color': color,
    };
  }

  static CatagoryEntity fromDocument(Map<String, Object?> doc) {
    return CatagoryEntity(
      catagoryId: doc['catagoryId'] as String,
      name: doc['name'] as String,
      totalExpenses: doc['totalExpenses'] as int,
      icon: doc['icon'] as String,
      color: doc['color'] as String,
    );
  }

}
