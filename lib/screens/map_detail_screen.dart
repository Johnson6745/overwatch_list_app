import 'package:flutter/material.dart';
import '../models/map_model.dart';
import '../services/local_database.dart';

class MapDetailScreen extends StatefulWidget {
  final MapModel map;

  const MapDetailScreen({super.key, required this.map});

  @override
  State<MapDetailScreen> createState() => _MapDetailScreenState();
}

class _MapDetailScreenState extends State<MapDetailScreen> {
  final LocalDatabase _localDb = LocalDatabase();
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _isFavorite = _localDb.isFavoriteMap(widget.map.name);
  }

  Future<void> _toggleFavorite() async {
    if (_isFavorite) {
      await _localDb.removeFavoriteMap(widget.map.name);
    } else {
      await _localDb.addFavoriteMap(widget.map.name);
    }
    setState(() => _isFavorite = !_isFavorite);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_isFavorite
            ? '${widget.map.name} dodano do ulubionych'
            : '${widget.map.name} usunięto z ulubionych'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final map = widget.map;

    return Scaffold(
      appBar: AppBar(
        title: Text(map.name),
        actions: [
          IconButton(
            icon: Icon(
              _isFavorite ? Icons.favorite : Icons.favorite_border,
              color: _isFavorite ? Colors.red : null,
            ),
            onPressed: _toggleFavorite,
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AspectRatio(
              aspectRatio: 16 / 9,
              child: Image.network(
                map.screenshot,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Container(
                  color: Colors.grey[800],
                  child: const Icon(Icons.broken_image, size: 80, color: Colors.grey),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                children: [
                  Text(
                    map.name,
                    style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Chip(
                    label: Text(
                      map.gamemode.toUpperCase(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 8),
                  Chip(
                    label: Text(
                      'Lokalizacja: ${map.localization}'.toUpperCase()
                      ,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton.icon(
                    onPressed: _toggleFavorite,
                    icon: Icon(_isFavorite ? Icons.favorite : Icons.favorite_border),
                    label: Text(_isFavorite ? 'Usuń z ulubionych' : 'Dodaj do ulubionych'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _isFavorite ? Colors.red[800] : null,
                      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}