class CategoryModel {
  final int id;
  final String label;
  final String iconName;
  final String colorHex;

  const CategoryModel({
    required this.id,
    required this.label,
    required this.iconName,
    required this.colorHex,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'],
      label: json['label'],
      iconName: json['iconName'],
      colorHex: json['colorHex'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'label': label,
      'iconName': iconName,
      'colorHex': colorHex,
    };
  }

  @override
  String toString() {
    return 'CategoryModel(id: $id, label: $label, icon: $iconName, color: $colorHex)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) || (other is CategoryModel && other.id == id);
  }

  @override
  int get hashCode => id.hashCode;
}
