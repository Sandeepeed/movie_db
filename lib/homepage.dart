import 'package:floating_bottom_navigation_bar/floating_bottom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:moviedb/widgets/customText.dart';
import 'package:moviedb/pages/mainpage.dart';
import 'package:moviedb/pages/profile.dart';
import 'package:moviedb/pages/search.dart';
import 'package:moviedb/widgets/customText.dart';
class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List pages = [
    const MainPage(),
    const Search(),
    const Profile(),
  ];
  int currentIndex = 0;
  void onTap(int index)
  {
    setState(() {
      currentIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        title: const Center(child: CustomText("MovieDB", 25.0, Colors.yellow, true)),
        automaticallyImplyLeading: false,
      ),
      backgroundColor: Colors.black,
      body: pages[currentIndex],
      bottomNavigationBar: FloatingNavbar(
        items: [
          FloatingNavbarItem(icon: Icons.home,title: "Home"),
          FloatingNavbarItem(icon: Icons.search,title: "Search"),
          FloatingNavbarItem(icon: Icons.person_rounded,title: "Account")
        ],
        backgroundColor: Colors.black,
        width: double.infinity,
        selectedItemColor: Colors.yellow,
        unselectedItemColor:Colors.blueGrey,
        selectedBackgroundColor: Colors.black,
        onTap: onTap,
        fontSize: 12,
        iconSize: 30,
        currentIndex: currentIndex,
      ),
    );
  }
}
