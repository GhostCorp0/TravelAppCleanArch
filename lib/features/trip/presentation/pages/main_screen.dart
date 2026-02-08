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
        "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQoKZ5ev0ls_lfr-UBnDRwp5-Jh2u3INVeJig&s";

    return Scaffold(
      appBar: AppBar(
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 12, top: 8, bottom: 8),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: Image.network(
                profilePic,
                fit: BoxFit.cover,
                height:60,
                width:60,
                errorBuilder: (_, __, ___) => Icon(Icons.person, size: 44, color: Colors.grey[400]),
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
