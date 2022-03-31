import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:neph_care_user/constants/colors.dart';
import 'package:neph_care_user/screens/bottom_navigation_bar/navigation_pages/covidTestRequest/covid_test_request.dart';
import 'package:neph_care_user/screens/bottom_navigation_bar/navigation_pages/home/home.dart';
import 'package:neph_care_user/screens/bottom_navigation_bar/navigation_pages/Profile/profile_page.dart';
import 'package:neph_care_user/screens/bottom_navigation_bar/navigation_pages/setting/setting.dart';

class MyNavigationBar extends StatefulWidget {
  const MyNavigationBar({Key? key}) : super(key: key);

  @override
  State<MyNavigationBar> createState() => _MyNavigationBarState();
}

class _MyNavigationBarState extends State<MyNavigationBar> {
  int selectedIndex = 0;
  static const List<Widget> widgetOptions = <Widget>[
    Home(),
    CovidTestRequest(),
    ProfilePage(),
    Setting(),
  ];

  onItemTapped(
    int index,
  ) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          // Navigator.pushNamedAndRemoveUntil(
          //   context,
          //   signInroute,
          //       (route) => false,
          // );
          return true;
        },
        child: Scaffold(
          drawerEnableOpenDragGesture: false,
          body: Center(
            child: widgetOptions.elementAt(selectedIndex),
          ),
          bottomNavigationBar: BottomNavigationBar(
              showUnselectedLabels: true,
              unselectedFontSize: 12.0,
              selectedFontSize: 12.0,
              unselectedItemColor: Colors.black,
              selectedLabelStyle: TextStyle(decorationColor: Colors.amber),
              type: BottomNavigationBarType.fixed,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  activeIcon: Icon(
                    CupertinoIcons.home,
                  ),
                  icon: Icon(
                    CupertinoIcons.home,
                  ),
                  label: ('Home'),
                ),
                BottomNavigationBarItem(
                  activeIcon: Icon(
                    CupertinoIcons.add_circled,
                  ),
                  icon: Icon(
                    CupertinoIcons.add_circled,
                  ),
                  label: ('Covid Test'),
                ),
                BottomNavigationBarItem(
                  activeIcon: Icon(
                    CupertinoIcons.person,
                  ),
                  icon: Icon(
                    CupertinoIcons.person,
                  ),
                  label: ('Profile'),
                ),
                BottomNavigationBarItem(
                  activeIcon: Icon(
                    CupertinoIcons.settings,
                  ),
                  icon: Icon(
                    CupertinoIcons.settings,
                  ),
                  label: ('Settings'),
                ),
              ],
              currentIndex: selectedIndex,
              selectedItemColor: basicthemecolor,
              iconSize: 20,
              onTap: onItemTapped,
              elevation: 5),
        ),
      ),
    );
  }
}
