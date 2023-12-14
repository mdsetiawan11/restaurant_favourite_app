import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:ndialog/ndialog.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_favourite_app/src/common/constant.dart';
import 'package:restaurant_favourite_app/src/providers/preferences_provider.dart';
import 'package:restaurant_favourite_app/src/providers/restaurant_list_provider.dart';
import 'package:restaurant_favourite_app/src/widgets/restaurant_card.dart';

class RestaurantListScreen extends StatelessWidget {
  const RestaurantListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
          child: Consumer<RestaurantListProvider>(builder: (context, state, _) {
            if (state.state == ResultState.loading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (state.state == ResultState.hasData) {
              return CustomScrollView(
                slivers: [
                  SliverAppBar(
                    floating: true,
                    title: const Row(
                      children: [
                        Text('Restaurant'),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          'App',
                          style: TextStyle(
                            color: Colors.deepPurple,
                          ),
                        )
                      ],
                    ),
                    actions: [
                      GestureDetector(
                        onTap: () {
                          NDialog(
                            title: const Text('Settings'),
                            content: SizedBox(
                              width: MediaQuery.of(context).size.width,
                              child: ListTile(
                                title: const Text('Daily Reminder'),
                                trailing: Consumer<PreferencesProvider>(
                                  builder: (context, provider, child) {
                                    return Switch.adaptive(
                                        value: provider.isDailyReminderActive,
                                        onChanged: (value) {
                                          provider.enableDailyReminder(value);
                                        });
                                  },
                                ),
                              ),
                            ),
                            actions: <Widget>[
                              TextButton(
                                  child: const Text("Close"),
                                  onPressed: () => Navigator.pop(context)),
                            ],
                          ).show(context);
                        },
                        child: const Icon(
                          Icons.settings,
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      )
                    ],
                  ),
                  SliverList.builder(
                    itemCount: state.result.restaurants.length,
                    itemBuilder: ((context, index) {
                      var restaurant = state.result.restaurants[index];
                      return GestureDetector(
                              onTap: () {
                                context.pushNamed('detail', pathParameters: {
                                  "id": restaurant.id,
                                });
                              },
                              child: RestaurantCard(restaurant: restaurant))
                          .animate()
                          .fade();
                    }),
                  )
                ],
              );
            } else if (state.state == ResultState.noData) {
              return Center(
                child: Material(
                  child: Text(state.message),
                ),
              );
            } else if (state.state == ResultState.error) {
              return Center(
                child: Material(
                  child: Text(state.message),
                ),
              );
            }
            return const SizedBox();
          }),
        ),
      ),
    );
  }
}
