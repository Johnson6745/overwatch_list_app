import 'package:flutter/material.dart';

class CustomGridView<T> extends StatelessWidget {
  final List<T> items;
  final String Function(T item) getTitle;
  final String Function(T item) getSubtitle;
  final String Function(T item) getImageUrl;
  final void Function(T item)? onTap;
  bool _snackbarShown = false;
  CustomGridView({
    super.key,
    required this.items,
    required this.getTitle,
    required this.getSubtitle,
    required this.getImageUrl,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) {
      return const Center(
        child: Text('Brak danych.', style: TextStyle(fontSize: 16)),
      );
    }

    return GridView.builder(
      padding: const EdgeInsets.all(12),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 0.8,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: items.length,

      itemBuilder: (context, index) {
        final item = items[index];
        return GestureDetector(
            onTap: () => onTap?.call(item),
            child:
            Card(
          clipBehavior: Clip.antiAlias,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
          elevation: 4,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Container(
                  color: Colors.grey[800],
                  child: Image.network(
                    getImageUrl(item),
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      if (!_snackbarShown) {
                        _snackbarShown = true;
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          if (context.mounted) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: const Row(
                                  children: [
                                    Icon(Icons.wifi_off_rounded, color: Colors.white, size: 18),
                                    SizedBox(width: 8),
                                    Text('Brak internetu – nie można załadować zdjęć'),
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
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  children: [
                    Text(
                      getTitle(item),
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      getSubtitle(item),
                      style: TextStyle(fontSize: 14, color: Colors.blueGrey[300]),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
      },
    );
  }
}