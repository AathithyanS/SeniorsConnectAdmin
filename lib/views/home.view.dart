import 'package:flutter/material.dart';
import 'package:seniors_connect/utils/global.color.dart';
import 'package:get/get.dart';
import 'package:ionicons/ionicons.dart';
import 'package:seniors_connect/views/pages/add.page.dart';
import 'package:seniors_connect/views/pages/home.page.dart';
import 'package:seniors_connect/views/pages/profile.page.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  int myCurrentIndex = 0;
  List pages = [HomePage(),AddPage(),ProfilePage()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          boxShadow:[
            BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10
          )
          ],
        ),
        child: BottomNavigationBar(
          backgroundColor: GlobalColors.navBackgroundColor,
          selectedItemColor: GlobalColors.mainColor,
          unselectedItemColor: GlobalColors.navUnselectedItemColor,
          currentIndex: myCurrentIndex,
          onTap: (index){
            setState(() {
              myCurrentIndex = index;
            });
          },
          items: const [
            BottomNavigationBarItem(icon: Icon(Ionicons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Ionicons.add), label: "Add"),
            BottomNavigationBarItem(icon: Icon(Ionicons.person), label: "Profile")
          ],
        ),
      ),
      body: Container(
        child: pages[myCurrentIndex],
      )
    );
  }
}
