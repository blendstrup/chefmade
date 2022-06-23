import 'package:flutter/material.dart';

import '../../theme.dart';
import '../../widgets/common/login.dart';
import 'mat_dining_info_page.dart';
import 'mat_dinings_page.dart';
import 'mat_login_page.dart';
import 'mat_overview_page.dart';
import 'mat_profile_page.dart';

class ChefmadeMatApp extends StatelessWidget {
  const ChefmadeMatApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'chefmade',
      theme: AppTheme.materialLightTheme,
      darkTheme: AppTheme.materialDarkTheme,
      home: const Scaffold(
        body: Login(
          home: MatHome(),
          loginPage: MatLoginPage(),
        ),
      ),
      routes: {
        'overview_page': (context) => const MatOverviewPage(),
        'dinings_page': (context) => const MatDiningsPage(),
        'dining': (context) => const MatDiningInfoPage(),
        'profile_page': (context) => const MatProfilePage(),
      },
    );
  }
}

class MatHome extends StatefulWidget {
  const MatHome({Key? key}) : super(key: key);

  @override
  State<MatHome> createState() => _MatHomeState();
}

class _MatHomeState extends State<MatHome> {
  int _index = 0;
  Widget _child = const MatOverviewPage();

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    Color? inactiveColor = theme.textTheme.button!.color!.withOpacity(0.4);
    Color? activeColor = theme.textTheme.button!.color;

    switch (_index) {
      case 0:
        _child = const MatOverviewPage();
        break;
      case 1:
        _child = const MatDiningsPage();
        break;
      case 2:
        _child = const MatProfilePage();
        break;
    }

    return Scaffold(
      body: SizedBox.expand(child: _child),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (newIndex) => setState(() => _index = newIndex),
        currentIndex: _index,
        items: [
          BottomNavigationBarItem(
            label: 'Overview',
            icon: Icon(
              Icons.home,
              color: _index == 0 ? activeColor : inactiveColor,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Dinings',
            icon: Icon(
              Icons.calendar_today,
              color: _index == 1 ? activeColor : inactiveColor,
            ),
          ),
          BottomNavigationBarItem(
            label: 'Profile',
            icon: Icon(
              Icons.person,
              color: _index == 2 ? activeColor : inactiveColor,
            ),
          ),
        ],
      ),
    );
  }
}
