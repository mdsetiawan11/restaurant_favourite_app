import 'package:flutter_test/flutter_test.dart';
import 'package:restaurant_favourite_app/src/models/restaurant_list_model.dart';

var jsonRestaurantListTest = {
  "id": "s1knt6za9kkfw1e867",
  "name": "Kafe Kita",
  "description":
      "Quisque rutrum. Aenean imperdiet. Etiam ultricies nisi vel augue. Curabitur ullamcorper ultricies nisi. ...",
  "pictureId": "25",
  "city": "Gorontalo",
  "rating": 4
};

void main() {
  test("Json Parsing Test", () async {
    var expectedId = "s1knt6za9kkfw1e867";
    var expectedName = 'Kafe Kita';
    var resultId = Restaurant.fromJson(jsonRestaurantListTest).id;
    var resultName = Restaurant.fromJson(jsonRestaurantListTest).name;

    expect(resultId, expectedId);
    expect(resultName, expectedName);
  });
}
