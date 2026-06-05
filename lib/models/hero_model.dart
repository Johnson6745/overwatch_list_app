class HeroModel {
  final String name;
  final String portrait;
  final String role;

  HeroModel({
    required this.name,
    required this.portrait,
    required this.role,
  });

 
  factory HeroModel.fromJson(Map<dynamic, dynamic> json) {
    return HeroModel(
      name: json['name'] ?? 'Nieznany',
      portrait: json['portrait'] ?? '',
      role: json['role'] ?? '',
    );
  }
}