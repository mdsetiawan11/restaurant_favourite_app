import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_favourite_app/src/models/restaurant_list_model.dart';
import 'package:restaurant_favourite_app/src/providers/restaurant_list_provider.dart';
import 'package:restaurant_favourite_app/src/services/restaurant_services.dart';

import 'restaurant_list_provider.mocks.dart';

class RestaurantServicesTest extends Mock implements RestaurantServices {}

const apiListResponse = {
  "error": false,
  "message": "success",
  "count": 2,
  "restaurants": [
    {
      "id": "w9pga3s2tubkfw1e867",
      "name": "Bring Your Phone Cafe",
      "description":
          "Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc,",
      "pictureId": "03",
      "city": "Surabaya",
      "rating": 4.2
    },
    {
      "id": "uewq1zg2zlskfw1e867",
      "name": "Kafein",
      "description":
          "Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc,",
      "pictureId": "15",
      "city": "Aceh",
      "rating": 4.6
    },
  ]
};

List<Restaurant> testRestaurants = [
  Restaurant(
    id: "w9pga3s2tubkfw1e867",
    name: "Bring Your Phone Cafe",
    description:
        "Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc,",
    pictureId: "03",
    city: "Surabaya",
    rating: 4.2,
  ),
  Restaurant(
    id: "uewq1zg2zlskfw1e867",
    name: "Kafein",
    description:
        "Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. Nam eget dui. Etiam rhoncus. Maecenas tempus, tellus eget condimentum rhoncus, sem quam semper libero, sit amet adipiscing sem neque sed ipsum. Nam quam nunc, blandit vel, luctus pulvinar, hendrerit id, lorem. Maecenas nec odio et ante tincidunt tempus. Donec vitae sapien ut libero venenatis faucibus. Nullam quis ante. Etiam sit amet orci eget eros faucibus tincidunt. Duis leo. Sed fringilla mauris sit amet nibh. Donec sodales sagittis magna. Sed consequat, leo eget bibendum sodales, augue velit cursus nunc,",
    pictureId: "15",
    city: "Aceh",
    rating: 4.6,
  ),
];

@GenerateMocks([RestaurantServicesTest])
Future<void> main() async {
  group("Restaurant Provider Test", () {
    late RestaurantListProvider restaurantListProvider;
    late RestaurantServices restaurantServices;

    setUp(() {
      restaurantServices = MockRestaurantServicesTest();
      restaurantListProvider =
          RestaurantListProvider(restaurantServices: restaurantServices);
    });

    test("_fetchAllRestaurant should return list of restaurants", () async {
      when(restaurantServices.getRestaurantList()).thenAnswer(
          (_) async => RestaurantListModel.fromJson(apiListResponse));

      var result = RestaurantListModel.fromJson(apiListResponse);
      var expected = testRestaurants;

      expect(result.restaurants.length == expected.length, true);
      expect(result.restaurants[0]?.id == expected[0].id, true);
      expect(result.restaurants[0]?.name == expected[0].name, true);
      expect(
          result.restaurants[0]?.description == expected[0].description, true);
      expect(result.restaurants[0]?.pictureId == expected[0].pictureId, true);
      expect(result.restaurants[0]?.city == expected[0].city, true);
      expect(result.restaurants[0]?.rating == expected[0].rating, true);
    });
  });
}
