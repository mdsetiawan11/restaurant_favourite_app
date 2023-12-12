import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_favourite_app/src/common/constant.dart';
import 'package:restaurant_favourite_app/src/providers/database_provider.dart';
import 'package:restaurant_favourite_app/src/widgets/favorite_restaurant_card.dart';

class FavoriteRestaurantScreen extends StatelessWidget {
  const FavoriteRestaurantScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<DatabaseProvider>(
        builder: (context, provider, child) {
          if (provider.state == ResultState.hasData) {
            return ListView.builder(
              itemCount: provider.favorites.length,
              itemBuilder: (context, index) {
                return FavoriteRestaurantCard(
                  restaurant: provider.favorites[index],
                );
              },
            );
          } else {
            return const Center(
              child: Text('Favorite Restaurant Not Found'),
            );
          }
        },
      ),
    );
  }
}
