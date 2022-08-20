import 'package:flutter/material.dart';
import 'package:mypasar/model/user.dart';
import 'tab_page_1.dart';
import 'tab_page_2.dart';
import 'tab_page_3.dart';

class MainPage extends StatefulWidget {
  final User user;
  const MainPage({Key? key, required this.user}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  late List<Widget> tabchildren;
  int _currentIndex = 0;
  String mainTitle = "Buyer";
  late double screenHeight, screenWidth, resWidth;

  @override
  void initState() {
    super.initState();
    tabchildren = [const TabPage1(), const TabPage2(), const TabPage3()];
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;
    if (screenWidth <= 600) {
      resWidth = screenWidth;
    } else {
      resWidth = screenWidth * 0.75;
    }

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
