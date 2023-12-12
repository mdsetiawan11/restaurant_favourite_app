import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
            return CustomScrollView(slivers: [
              const SliverAppBar(
                floating: true,
                title: Row(
                  children: [
                    Text('Favorite'),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Restaurant',
                      style: TextStyle(
                        color: Colors.deepPurple,
                      ),
                    )
                  ],
                ),
              ),
              SliverList.builder(
                itemCount: provider.favorites.length,
                itemBuilder: ((context, index) {
                  var restaurant = provider.favorites[index];
                  return GestureDetector(
                      onTap: () {
                        context.pushNamed('detail', pathParameters: {
                          "id": restaurant.id,
                        });
                      },
                      child: FavoriteRestaurantCard(restaurant: restaurant));
                }),
              )
            ]);
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
