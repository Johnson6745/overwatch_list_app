import 'package:flutter/material.dart';
import 'package:overwatch_list_app/services/analytics_service.dart';
import '../models/hero_model.dart';
import '../services/local_database.dart';
import '../services/api_service.dart';

class HeroDetailScreen extends StatefulWidget {
  final HeroModel hero;

  const HeroDetailScreen({super.key, required this.hero});

  @override
  State<HeroDetailScreen> createState() => _HeroDetailScreenState();
}

class _HeroDetailScreenState extends State<HeroDetailScreen> {
  final LocalDatabase _localDb = LocalDatabase();
  final ApiService _api = ApiService();
  bool _snackbarShown = false;
  bool _isFavorite = false;
  bool _isLoadingDetail = true;
  bool _fromCache = false;
  HeroModel? _detailedHero;

  @override
  void initState() {
    super.initState();
    _isFavorite = _localDb.isFavoriteHero(widget.hero.name);
    _loadDetail();
  }

  Future<void> _loadDetail() async {
    if (widget.hero.key.isEmpty) {
      setState(() => _isLoadingDetail = false);
      return;
    }
    final cached = _localDb.getHeroDetail(widget.hero.key);
    if (cached != null) {
      setState(() => _fromCache = true);
    }

    final data = await _api.fetchHeroDetail(widget.hero.key);
    if (mounted) {
      setState(() {
        _detailedHero = data != null ? HeroModel.fromDetailJson(data) : null;
        _isLoadingDetail = false;
      });
    }
  }

  Future<void> _toggleFavorite() async {
    if (_isFavorite) {
      await _localDb.removeFavoriteHero(widget.hero.name);
    } else {
      await _localDb.addFavoriteHero(widget.hero.name);
      await AnalyticsService.logFavouriteAdded(widget.hero.name);
    }
    setState(() => _isFavorite = !_isFavorite);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(_isFavorite
              ? '${widget.hero.name} dodano do ulubionych'
              : '${widget.hero.name} usunięto z ulubionych'),
          duration: const Duration(seconds: 1),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;
    final hero = _detailedHero ?? widget.hero;

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
              aspectRatio: 16 / 9,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    hero.largeImage ?? hero.portrait,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      if (!_snackbarShown) {
                        _snackbarShown = true;
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Row(
                                  children: [
                                    const Icon(Icons.wifi_off_rounded, color: Colors.white, size: 18),
                                    const SizedBox(width: 8),
                                    Text(_fromCache
                                        ? 'Brak internetu - nie można załadować zdjęcia\n Zaladowano opis z bazy danych'
                                        : 'Brak internetu - nie można załadować zdjęcia\n Brak opisu w lokalnej bazie'),
                                  ],
                                ),
                                backgroundColor: Colors.red[800],
                                duration: const Duration(seconds: 3),
                              ),
                            );
                          }
                        });
                      }
                      return const Icon(Icons.broken_image, size: 50, color: Colors.grey);
                    },
                  ),
                  DecoratedBox(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          theme.scaffoldBackgroundColor,
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          hero.name,
                          style: const TextStyle(
                            fontSize: 26,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      _RoleChip(role: hero.role),
                    ],
                  ),

                  if (hero.location != null) ...[
                    const SizedBox(height: 6),
                    Row(
                      children: [
                        Icon(Icons.location_on_outlined,
                            size: 14,
                            color: theme.colorScheme.onSurface.withOpacity(0.5)),
                        const SizedBox(width: 4),
                        Text(
                          hero.location!,
                          style: TextStyle(
                            fontSize: 13,
                            color: theme.colorScheme.onSurface.withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),
                  ],

                  const SizedBox(height: 20),


                  ElevatedButton.icon(
                    onPressed: _toggleFavorite,
                    icon: Icon(
                        _isFavorite ? Icons.favorite : Icons.favorite_border),
                    label: Text(_isFavorite
                        ? 'Usuń z ulubionych'
                        : 'Dodaj do ulubionych'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: _isFavorite ? Colors.red[800] : null,
                      foregroundColor: _isFavorite ? Colors.white : null,
                      minimumSize: const Size(double.infinity, 48),
                    ),
                  ),

                  const SizedBox(height: 28),

                  if (_isLoadingDetail)
                    Center(
                      child: CircularProgressIndicator(color: primary),
                    )
                  else ...[

                    if (hero.description != null) ...[
                      _SectionLabel(text: 'OPIS', color: primary),
                      const SizedBox(height: 10),
                      Text(
                        hero.description!,
                        style: TextStyle(
                          fontSize: 14,
                          height: 1.6,
                          color: theme.colorScheme.onSurface.withOpacity(0.8),
                        ),
                      ),
                      const SizedBox(height: 28),
                    ],


                    if (hero.abilities != null &&
                        hero.abilities!.isNotEmpty) ...[
                      Divider(color: theme.dividerColor),
                      const SizedBox(height: 20),
                      _SectionLabel(text: 'UMIEJĘTNOŚCI', color: primary),
                      const SizedBox(height: 12),
                      ...hero.abilities!.map(
                            (ability) => _AbilityTile(ability: ability),
                      ),
                    ],
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SectionLabel extends StatelessWidget {
  final String text;
  final Color color;

  const _SectionLabel({required this.text, required this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 11,
        letterSpacing: 1.5,
        fontWeight: FontWeight.w500,
        color: color,
      ),
    );
  }
}

class _RoleChip extends StatelessWidget {
  final String role;
  const _RoleChip({required this.role});

  @override
  Widget build(BuildContext context) {
    Color color;
    switch (role.toLowerCase()) {
      case 'tank':
        color = const Color(0xFF378ADD);
        break;
      case 'damage':
        color = const Color(0xFFE24B4A);
        break;
      case 'support':
        color = const Color(0xFF639922);
        break;
      default:
        color = Colors.grey;
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.15),
        border: Border.all(color: color),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        role.toUpperCase(),
        style: TextStyle(
            fontSize: 11, fontWeight: FontWeight.w600, color: color),
      ),
    );
  }
}

class _AbilityTile extends StatelessWidget {
  final AbilityModel ability;
  const _AbilityTile({required this.ability});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: theme.cardTheme.color,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: theme.dividerColor),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: theme.colorScheme.primary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                ability.icon,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => Icon(
                  Icons.flash_on,
                  color: theme.colorScheme.primary,
                  size: 24,
                ),
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  ability.name,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  ability.description,
                  style: TextStyle(
                    fontSize: 13,
                    height: 1.5,
                    color: theme.colorScheme.onSurface.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}