class AbilityModel {
  final String name;
  final String description;
  final String icon;

  AbilityModel({
    required this.name,
    required this.description,
    required this.icon,
  });

  factory AbilityModel.fromJson(Map<dynamic, dynamic> json) {
    return AbilityModel(
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      icon: json['icon'] ?? '',
    );
  }
}

class HeroModel {
  final String name;
  final String portrait;
  final String role;
  final String key;
  final String? description;
  final String? location;
  final String? largeImage;
  final List<AbilityModel>? abilities;

  HeroModel({
    required this.name,
    required this.portrait,
    required this.role,
    required this.key,
    this.description,
    this.location,
    this.largeImage,
    this.abilities,
  });

  factory HeroModel.fromJson(Map<dynamic, dynamic> json) {
    return HeroModel(
      name: json['name'] ?? 'Nieznany',
      portrait: json['portrait'] ?? '',
      role: json['role'] ?? '',
      key: json['key'] ?? '',
    );
  }

  factory HeroModel.fromDetailJson(Map<dynamic, dynamic> json) {
    String? largeImage;
    final backgrounds = json['backgrounds'] as List?;
    if (backgrounds != null && backgrounds.isNotEmpty) {
      final bg = backgrounds.length > 1 ? backgrounds[1] : backgrounds[0];
      largeImage = bg['url'] as String?;
    }

    final abilitiesList = (json['abilities'] as List?)
        ?.map((a) => AbilityModel.fromJson(a as Map))
        .toList();

    return HeroModel(
      name: json['name'] ?? 'Nieznany',
      portrait: json['portrait'] ?? '',
      role: json['role'] ?? '',
      key: json['key'] ?? '',
      description: json['description'],
      location: json['location'],
      largeImage: largeImage,
      abilities: abilitiesList,
    );
  }
}