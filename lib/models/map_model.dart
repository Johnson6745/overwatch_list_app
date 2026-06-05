class MapModel {
  final String name;
  final String screenshot;
  final String gamemode;
  final String localization;
  MapModel({
    required this.name,
    required this.screenshot,
    required this.gamemode,
    required this.localization
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
      localization: json['location'],
    );
  }
}