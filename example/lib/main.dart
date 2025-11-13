import 'package:flutter/material.dart';
import 'package:my_nav_rail/my_nav_rail.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  int _index = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MyNavRail Demo',
      theme: ThemeData(useMaterial3: true, colorSchemeSeed: Colors.deepPurple),
      home:MyNavRail(
        currentIndex: _index,
        onDestinationSelected: (i) => setState(() => _index = i),
        destinations: [
          NavigationMyDestination(icon: const Icon(Icons.home_outlined), label: 'Home', selectedIcon: const Icon(Icons.home)),
          NavigationMyDestination(icon: const Icon(Icons.search), label: 'Search'),
          NavigationMyDestination(icon: const Icon(Icons.person_outline), label: 'Profile', selectedIcon: const Icon(Icons.person)),
        ],
        body: [
          const Center(child: Text('Home Page', style: TextStyle(fontSize: 32))),
          const Center(child: Text('Search Page', style: TextStyle(fontSize: 32))),
          const Center(child: Text('Profile Page', style: TextStyle(fontSize: 32))),
        ][_index],
        title: const Text('MyNavRail'),
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: const Icon(Icons.add),
        ),
        drawerHeader: (_) => const UserAccountsDrawerHeader(
          accountName: Text('John Doe'),
          accountEmail: Text('john@example.com'),
          currentAccountPicture: CircleAvatar(backgroundColor: Colors.white, child: Text('J')),
        ),
        drawerFooter: (_) => const Padding(
          padding: EdgeInsets.all(16),
          child: Text('v1.0.0', style: TextStyle(color: Colors.grey)),
        ),
      ),
    );
  }
}