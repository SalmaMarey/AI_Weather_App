import 'package:flutter/material.dart';
import 'package:tennis_app/features/auth/presentation/screens/introduction_screen.dart';



class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 2; 

  static const List<Widget> _pages = <Widget>[
    Center(child: Text('Search Page')),
    Center(child: Text('Profile Page')),
    Center(child: Text('Home Page')),
    Center(child: Text('Notifications Page')),
    Center(child: Text('Settings Page')),
  ];

  
  void _onItemTapped(int index) {
    if (index == 4) {
     
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const IntroductionScreen()),
      );
    } else {
      setState(() {
        _selectedIndex = index; 
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        type: BottomNavigationBarType.fixed,
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notifications),
            label: 'Notifications',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
        ],
      ),
    );
  }
}
