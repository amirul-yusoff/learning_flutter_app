import 'package:flutter/material.dart';
import 'tab_page_1.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late List<Widget> tabchildren;
  int _currentIndex = 0;
  String mainTitle = "Buyer";

  @override
  void initState() {
    super.initState();
    tabchildren = [const TabPage1(), const TabPage1(), const TabPage1()];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Pasar'),
      ),
      body: tabchildren[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        onTap: onTabTapped,
        currentIndex: _currentIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.attach_money_outlined, color: Colors.white),
              label: "Buyer"),
          BottomNavigationBarItem(
              icon: Icon(Icons.store_mall_directory_sharp, color: Colors.white),
              label: "Seler"),
          BottomNavigationBarItem(
              icon: Icon(Icons.person, color: Colors.white), label: "Profile"),
        ],
      ),
    );
  }

  void onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      if (_currentIndex == 0) {
        mainTitle = "Buyer";
      }
      if (_currentIndex == 1) {
        mainTitle = "Seller";
      }
      if (_currentIndex == 2) {
        mainTitle = "Buyer";
      }
    });
  }
}