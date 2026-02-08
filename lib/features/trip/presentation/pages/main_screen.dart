import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_clean_architecture/features/trip/presentation/pages/add_trip_screen.dart';
import 'package:riverpod_clean_architecture/features/trip/presentation/providers/trip_providers.dart';

import 'my_trips_screen.dart';

class MainScreen extends ConsumerWidget {
  final PageController _pageController = PageController();
  final ValueNotifier<int> _currentPage = ValueNotifier<int>(0);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(tripListNotifierProvider.notifier).loadTrips();
    _pageController.addListener(() {
      _currentPage.value = _pageController.page!.round();
    });
    String profilePic =
        "https://thumbs.dreamstime.com/b/d-icon-avatar-cartoon-cute-freelancer-woman-working-online-learning-laptop-transparent-png-background-works-embodying-345422695.jpg";

    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: EdgeInsets.all(100),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: Image.network(
                profilePic,
                fit: BoxFit.cover,
                height: 60,
                width: 60,
              ),
            ),
          ),
        ],
        centerTitle: false,
        elevation: 0,
        toolbarHeight: 100,
        backgroundColor: Colors.white,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Hi Fabrice",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            Text(
              "Travelling Today ?",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
      body: PageView(
        controller: _pageController,
        children: [MyTripsScreen(), AddTripScreen(), Text('3')],
      ),
      bottomNavigationBar: ValueListenableBuilder(
        valueListenable: _currentPage,
        builder: (context, pageIndex, child) {
          return BottomNavigationBar(
            currentIndex: pageIndex,
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.list),
                label: "My trips",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.add),
                label: "Add trips",
              ),
              BottomNavigationBarItem(icon: Icon(Icons.map), label: "Maps"),
            ],
            onTap: (index) {
              _pageController.jumpToPage(index);
            },
          );
        },
      ),
    );
  }
}
