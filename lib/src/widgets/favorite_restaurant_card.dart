import 'package:flutter/material.dart';
import 'package:restaurant_favourite_app/src/common/constant.dart';
import 'package:restaurant_favourite_app/src/models/favorite_restaurant_model.dart';

class FavoriteRestaurantCard extends StatelessWidget {
  final Restaurant restaurant;

  const FavoriteRestaurantCard({
    super.key,
    required this.restaurant,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      color: Colors.transparent,
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              imgUrl + restaurant.pictureId,
              width: 130,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            width: 15,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                restaurant.name,
                style: const TextStyle(fontSize: 18),
              ),
              Row(
                children: [
                  Icon(
                    Icons.pin_drop_sharp,
                    color: Colors.red.shade700,
                  ),
                  Text(restaurant.city)
                ],
              ),
              Row(
                children: [
                  Icon(
                    Icons.star,
                    color: Colors.yellow.shade700,
                  ),
                  Text(restaurant.rating.toString())
                ],
              )
            ],
          )
        ],
      ),
    );
  }
}
