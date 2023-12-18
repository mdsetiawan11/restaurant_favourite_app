import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:restaurant_favourite_app/src/models/restaurant_list_model.dart';
import 'package:restaurant_favourite_app/src/providers/restaurant_list_provider.dart';
import 'package:restaurant_favourite_app/src/services/restaurant_services.dart';

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
    id: "rqdv5juczeskfw1e867",
    name: "Melting Pot",
    description:
        "Lorem ipsum dolor sit amet, consectetuer adipiscing elit. Aenean commodo ligula eget dolor. Aenean massa. Cum sociis natoque penatibus et magnis dis parturient montes, nascetur ridiculus mus. Donec quam felis, ultricies nec, pellentesque eu, pretium quis, sem. Nulla consequat massa quis enim. Donec pede justo, fringilla vel, aliquet nec, vulputate eget, arcu. In enim justo, rhoncus ut, imperdiet a, venenatis vitae, justo. Nullam dictum felis eu pede mollis pretium. Integer tincidunt. Cras dapibus. Vivamus elementum semper nisi. Aenean vulputate eleifend tellus. Aenean leo ligula, porttitor eu, consequat vitae, eleifend ac, enim. Aliquam lorem ante, dapibus in, viverra quis, feugiat a, tellus. Phasellus viverra nulla ut metus varius laoreet.",
    pictureId: "14",
    city: "Medan",
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
  late RestaurantServices restaurantServices;
  late RestaurantListProvider restaurantListProvider;

  setUp(() {
    restaurantServices = RestaurantServicesTest();
    restaurantListProvider =
        RestaurantListProvider(restaurantServices: restaurantServices);
  });

  test("_fetchAllRestaurant should return list of restaurants", () async {
    when(restaurantServices.getRestaurantList()).thenAnswer(
        (_) async => await restaurantListProvider.fetchAllRestaurantTest());

    var result = restaurantListProvider.result.restaurants!;
    var expected = testRestaurants;

    expect(result.length == 20, true);
    expect(result[0]?.id == expected[0].id, true);
    expect(result[0]?.name == expected[0].name, true);
    expect(result[0]?.description == expected[0].description, true);
    expect(result[0]?.pictureId == expected[0].pictureId, true);
    expect(result[0]?.city == expected[0].city, true);
    expect(result[0]?.rating == expected[0].rating, true);
  });
}
