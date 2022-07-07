import 'package:field_recruitment/Account/account_screen.dart';
import 'package:field_recruitment/Report/report_screen.dart';
import 'package:field_recruitment/beranda/beranda_view.dart';
import 'package:field_recruitment/constans.dart';
import 'package:flutter/material.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => new _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  int _bottomNavCurrentIndex = 0;
  List<Widget> _container = [
    BerandaPage(),
    ReportScreen(),
    AccountScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _container[_bottomNavCurrentIndex],
      bottomNavigationBar: _buildBottomNavigation(),
    );
  }

  Widget _buildBottomNavigation() {
    return BottomNavigationBar(
      type: BottomNavigationBarType.fixed,
      onTap: (index) {
        setState(() {
          _bottomNavCurrentIndex = index;
        });
      },
      currentIndex: _bottomNavCurrentIndex,
      fixedColor: Color(0xff2da5d9),
      items: [
        BottomNavigationBarItem(
          activeIcon: Icon(Icons.home, color: Color(0xff2da5d9)),
          icon: Icon(
            Icons.home,
            color: Colors.grey,
          ),
          title: Text(
            'Beranda',
          ),
        ),
        BottomNavigationBarItem(
          activeIcon: Icon(Icons.history_outlined, color: Color(0xff2da5d9)),
          icon: Icon(
            Icons.history_outlined,
            color: Colors.grey,
          ),
          title: Text(
            'Laporan',
          ),
        ),
        BottomNavigationBarItem(
          activeIcon:
              Icon(Icons.account_circle_outlined, color: Color(0xff2da5d9)),
          icon: Icon(
            Icons.account_circle_outlined,
            color: Colors.grey,
          ),
          title: Text(
            'Akun',
          ),
        ),
      ],
    );
  }
}
