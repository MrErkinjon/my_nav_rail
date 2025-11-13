// test/widget_test/my_nav_rail_test.dart
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:my_nav_rail/my_nav_rail.dart';

void main() {
  group('MyNavRail', () {
    testWidgets('renders mobile layout', (tester) async {
      await tester.pumpWidget(
         MaterialApp(
          home: MyNavRail(
            currentIndex: 0,
            onDestinationSelected:(index){},
            destinations: const [
              NavigationMyDestination(icon:  Icon(Icons.home_outlined), label: 'Home', selectedIcon:  Icon(Icons.home)),
              NavigationMyDestination(icon:  Icon(Icons.search), label: 'Search'),
              NavigationMyDestination(icon:  Icon(Icons.person_outline), label: 'Profile', selectedIcon:  Icon(Icons.person)),
            ],
            body: Text('Body'),
          ),
        ),
      );
      expect(find.byType(BottomNavigationBar), findsOneWidget);
    });

    testWidgets('renders tablet layout', (tester) async {
      await tester.pumpWidget(
         MaterialApp(
          home: SizedBox(
            width: 800,
            height: 600,
            child: MyNavRail(
              currentIndex: 0,
              onDestinationSelected:(index){},
              destinations: [
                NavigationMyDestination(icon: const Icon(Icons.home_outlined), label: 'Home', selectedIcon: const Icon(Icons.home)),
                NavigationMyDestination(icon: const Icon(Icons.search), label: 'Search'),
                NavigationMyDestination(icon: const Icon(Icons.person_outline), label: 'Profile', selectedIcon: const Icon(Icons.person)),
              ],
              body: Text('Body'),
            ),
          ),
        ),
      );
      expect(find.byType(NavigationRail), findsOneWidget);
    });

    testWidgets('renders desktop layout', (tester) async {
      await tester.pumpWidget(
         MaterialApp(
          home: SizedBox(
            width: 1600,
            height: 900,
            child: MyNavRail(
              currentIndex: 0,
              onDestinationSelected:(index){},
              destinations: [
                NavigationMyDestination(icon: const Icon(Icons.home_outlined), label: 'Home', selectedIcon: const Icon(Icons.home)),
                NavigationMyDestination(icon: const Icon(Icons.search), label: 'Search'),
                NavigationMyDestination(icon: const Icon(Icons.person_outline), label: 'Profile', selectedIcon: const Icon(Icons.person)),
              ],
              body: Text('Body'),
            ),
          ),
        ),
      );
      expect(find.byType(Drawer), findsOneWidget);
    });
  });
}
