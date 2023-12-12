import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_favourite_app/src/providers/database_provider.dart';

class FavoriteRestaurantScreen extends StatelessWidget {
  const FavoriteRestaurantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<DatabaseProvider>(
        builder: (context, provider, child) {
          return ListView.builder(
            itemCount: provider.favorites.length,
            itemBuilder: (context, index) {
              return const Text('data');
            },
          );
        },
      ),
    );
  }
}
