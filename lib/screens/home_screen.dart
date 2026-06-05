import 'package:flutter/material.dart';
import '../services/data_sync_service.dart';
import 'character_screen.dart';

class HomeScreen extends StatefulWidget { // zmień na StatefulWidget
  const HomeScreen({super.key});
  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _init();
  }

  Future<void> _init() async {
    await SyncService.loadInitialDataIfNeeded();
    if (mounted) setState(() => _isLoading = false);
  }


  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Strona Główna'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(27.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              _buildMenuButton(
                title: 'Postacie',
                icon: Icons.people,
                onPressed: () {

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>  HeroesScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 20),
              _buildMenuButton(
                title: 'Mapy',
                icon: Icons.map,
                onPressed: () {
                  print('Kliknięto Mapy');
                },
              ),
              const SizedBox(height: 20),
              _buildMenuButton(
                title: 'Ulubione',
                icon: Icons.favorite,
                onPressed: () {
                  print('Kliknięto Ulubione');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }


  Widget _buildMenuButton({
    required String title,
    required IconData icon,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(vertical: 26),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        textStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
      onPressed: onPressed,
      icon: Icon(icon, size: 30),
      label: Text(title),
    );
  }
}