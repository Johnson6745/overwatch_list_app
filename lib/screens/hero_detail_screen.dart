import 'package:flutter/material.dart';
import '../models/hero_model.dart';
import '../services/local_database.dart';

class HeroDetailScreen extends StatefulWidget {
  final HeroModel hero;

  const HeroDetailScreen({super.key, required this.hero});

  @override
  State<HeroDetailScreen> createState() => _HeroDetailScreenState();
}

class _HeroDetailScreenState extends State<HeroDetailScreen> {
  final LocalDatabase _localDb = LocalDatabase();
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _isFavorite = _localDb.isFavoriteHero(widget.hero.name);
  }

  Future<void> _toggleFavorite() async {
    if (_isFavorite) {
      await _localDb.removeFavoriteHero(widget.hero.name);
    } else {
      await _localDb.addFavoriteHero(widget.hero.name);
    }
    setState(() => _isFavorite = !_isFavorite);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(_isFavorite
            ? '${widget.hero.name} dodano do ulubionych'
            : '${widget.hero.name} usunięto z ulubionych'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final hero = widget.hero;

    return Scaffold(
      appBar: AppBar(
        title: Text(hero.name),
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
              aspectRatio: 1,
              child: Image.network(
                hero.portrait,
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
                    hero.name,
                    style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Chip(
                    label: Text(
                      hero.role.toUpperCase(),
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                    backgroundColor: _roleColor(hero.role),
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

  Color _roleColor(String role) {
    switch (role.toLowerCase()) {
      case 'tank':
        return Colors.blue[800]!;
      case 'damage':
        return Colors.red[800]!;
      case 'support':
        return Colors.green[800]!;
      default:
        return Colors.grey[800]!;
    }
  }
}