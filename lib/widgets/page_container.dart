import 'package:auctionapp/const/colors.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

import '../screens/home_page.dart';

class PageContainer extends StatefulWidget {
  const PageContainer({Key? key}) : super(key: key);

  @override
  State<PageContainer> createState() => _PageContainerState();
}

class _PageContainerState extends State<PageContainer> {
  int _currentIndex = 1;

  final List<Widget> _pages = [
    DashboardPage(),
    HomePage(),
    ProfilePage(),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.primary,
      bottomNavigationBar: CurvedNavigationBar(
        backgroundColor: Colors.transparent,
        color: AppColor.green,
        height: 60,
        index: _currentIndex,
        animationDuration: Duration(milliseconds: 600),
        animationCurve: Curves.easeOut,
        onTap: (index){
          setState(() {
            _currentIndex = index;
          });
        },
        items: const [
          Icon(Icons.store, color: AppColor.primary,),
          Icon(Icons.home_filled, color: AppColor.primary),
          Icon(Icons.person, color: AppColor.primary,),
        ],
      ),
      body: _pages[_currentIndex],
    );
  }
}
class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Dashboard Page',
        style: TextStyle(
          color: Colors.white,
          fontSize: 24,
        ),
      ),
    );
  }
}





class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Profile Page',
        style: TextStyle(
          color: Colors.white,
          fontSize: 24,
        ),
      ),
    );
  }
}