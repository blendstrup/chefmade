import 'package:flutter/cupertino.dart';

import '../../theme.dart';
import '../../widgets/common/login.dart';
import 'cup_dinings_list_page.dart';
import 'cup_login_page.dart';
import 'cup_overview_page.dart';
import 'cup_profile_page.dart';
import '../../widgets/cupertino/cup_bottom_sheet.dart';

class ChefmadeCupApp extends StatelessWidget {
  const ChefmadeCupApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoApp(
      title: 'chefmade',
      theme: AppTheme.cupertinoTheme,
      debugShowCheckedModeBanner: false,
      home: const CupertinoPageScaffold(
        resizeToAvoidBottomInset: false,
        child: Login(
          loginPage: CupLoginPage(),
          home: CupHome(),
        ),
      ),
    );
  }
}

class CupHome extends StatelessWidget {
  const CupHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppCupertinoScaffold(
      body: CupertinoTabScaffold(
        tabBar: CupertinoTabBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(icon: Icon(CupertinoIcons.home)),
            BottomNavigationBarItem(icon: Icon(CupertinoIcons.calendar)),
            BottomNavigationBarItem(icon: Icon(CupertinoIcons.profile_circled)),
          ],
        ),
        tabBuilder: (BuildContext context, int index) {
          return CupertinoTabView(
            builder: (BuildContext context) {
              switch (index) {
                case 0:
                  return const CupOverviewPage();
                case 1:
                  return const CupDiningsListPage();
                case 2:
                  return const CupProfilePage();
                default:
                  return const CupOverviewPage();
              }
            },
          );
        },
      ),
    );
  }
}
