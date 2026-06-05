class MapModel {
  final String name;
  final String screenshot;
  final String gamemode;

  MapModel({
    required this.name,
    required this.screenshot,
    required this.gamemode,
  });

  factory MapModel.fromJson(Map<dynamic, dynamic> json) {
    String mode = 'Nieznany tryb';
    if (json['gamemodes'] != null && (json['gamemodes'] as List).isNotEmpty) {
      mode = json['gamemodes'][0].toString();
    }

    return MapModel(
      name: json['name'] ?? 'Nieznana mapa',
      screenshot: json['screenshot'] ?? '',
      gamemode: mode,
    );
  }
}