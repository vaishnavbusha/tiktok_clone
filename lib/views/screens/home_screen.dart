// ignore_for_file: prefer_const_constructors, deprecated_member_use, prefer_final_fields, unused_field, use_key_in_widget_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tiktok_clone/views/screens/profile_screen.dart';
import 'package:tiktok_clone/views/screens/search_screen.dart';
import 'package:tiktok_clone/views/screens/video_screen.dart';
import 'package:tiktok_clone/views/widgets/customicon.dart';

import '../../constants.dart';
import 'add_video_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  //final _pageViewController = PageController();
  final pages = [
    VideoScreen(),
    SearchScreen(),
    AddVideoScreen(),
    Scaffold(
      backgroundColor: backgroundColor,
      body: Center(
          child: Text(
        'Coming soon',
        style: TextStyle(fontFamily: 'gilroy_bold', fontSize: 30),
      )),
    ),
    ProfileScreen(uid: authcontroller.user.uid),
  ];

  late CupertinoTabController tabController;
  final GlobalKey<NavigatorState> p0 = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> p1 = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> p2 = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> p3 = GlobalKey<NavigatorState>();
  final GlobalKey<NavigatorState> p4 = GlobalKey<NavigatorState>();
  @override
  void initState() {
    super.initState();
    tabController = CupertinoTabController(initialIndex: 0);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final listOfKeys = [p0, p1, p2, p3, p4];
    return WillPopScope(
      onWillPop: () async {
        return !await listOfKeys[tabController.index].currentState!.maybePop();
      },
      child: CupertinoTabScaffold(
        backgroundColor: backgroundColor,
        controller: tabController,
        tabBar: CupertinoTabBar(
          activeColor: Colors.red[400]!,
          backgroundColor: backgroundColor,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home),
                title: Text(
                  'Home',
                  style: TextStyle(fontFamily: 'gilroy_regular'),
                )),
            BottomNavigationBarItem(
                icon: Icon(Icons.search),
                title: Text(
                  'Search',
                  style: TextStyle(fontFamily: 'gilroy_regular'),
                )),
            BottomNavigationBarItem(
              icon: CustomIcon(),
              title: Text("", style: TextStyle(fontSize: 0)),
            ),
            BottomNavigationBarItem(
                icon: Icon(Icons.message),
                title: Text(
                  'Messages',
                  style: TextStyle(fontFamily: 'gilroy_regular'),
                )),
            BottomNavigationBarItem(
                icon: Icon(Icons.person),
                title: Text(
                  'Profile',
                  style: TextStyle(fontFamily: 'gilroy_regular'),
                )),
          ],
        ),
        tabBuilder: (BuildContext context, int index) {
          return CupertinoTabView(
              navigatorKey: listOfKeys[index],
              builder: (context) {
                return CupertinoPageScaffold(
                  child: SafeArea(child: pages[index]),
                );
              });
        },
      ),
    );
  }
}












// // ignore_for_file: prefer_const_constructors, deprecated_member_use

// import 'package:flutter/material.dart';
// import 'package:tiktok_clone/views/widgets/customicon.dart';

// import '../../constants.dart';

// class HomeScreen extends StatefulWidget {
//   const HomeScreen({Key? key}) : super(key: key);

//   @override
//   State<HomeScreen> createState() => _HomeScreenState();
// }

// class _HomeScreenState extends State<HomeScreen> {
//   int pageindex = 0;
//   late PageController _pageViewController;
//   //final _pageViewController = PageController();

//   @override
//   void initState() {
//     _pageViewController = PageController();
//     super.initState();
//   }

//   @override
//   void dispose() {
//     _pageViewController.dispose();
//     super.dispose();
//   }

//   changePage(value) {
//     setState(() {
//       pageindex = value;
//       _pageViewController.jumpToPage(pageindex);
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: backgroundColor,
//       bottomNavigationBar: BottomNavigationBar(
//         onTap: changePage,
//         type: BottomNavigationBarType.fixed,
//         selectedItemColor: Colors.red[400],
//         unselectedItemColor: Colors.white,
//         backgroundColor: backgroundColor,
//         currentIndex: pageindex,
//         items: const [
//           BottomNavigationBarItem(icon: Icon(Icons.home), title: Text('Home')),
//           BottomNavigationBarItem(
//               icon: Icon(Icons.search), title: Text('Search')),
//           BottomNavigationBarItem(
//             icon: CustomIcon(),
//             title: Text("", style: TextStyle(fontSize: 0)),
//           ),
//           BottomNavigationBarItem(
//               icon: Icon(Icons.message), title: Text('Messages')),
//           BottomNavigationBarItem(
//               icon: Icon(Icons.person), title: Text('Profile')),
//         ],
//       ),
//       body: PageView(
//         controller: _pageViewController,
//         physics: NeverScrollableScrollPhysics(),
//         children: pages,
//         // onPageChanged: (value) {
//         //   setState(() {
//         //     pageindex = value;
//         //   });
//         // },
//       ),
//     );
//   }
// }
