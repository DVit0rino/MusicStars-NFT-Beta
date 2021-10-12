import 'package:audio_testing_app/screens/category_selector.dart';
import 'package:audio_testing_app/styles/styles.dart';
import 'package:flutter/material.dart';
import 'package:side_navigation/side_navigation.dart';

class Home extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeState();
  }
}

class _HomeState extends State<Home> {
  int _currentIndex = 0;
  final List<Widget> _children = [
    CategorySelector(),
    Text("Discover"),
    Text("Tracks"),
    Text("Albums"),
    Text("Artists"),
    Text("NFT Marketplace"),
  ];
  String currentAddress = '';
  int currentChain = -1;
  var wcConnected = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: true,
          title: Text('MusicStars Beta', style: ThemeText.twentyEightBold),
          backgroundColor: ThemeColors.colorBlack,
          actions: <Widget>[
            // WalletWidget(),
            Text("Wallet"),
          ]),
      body: Row(
        children: [
          SideNavigationBar(
            color: ThemeColors.colorDarkGrey,
            selectedItemColor: ThemeColors.colorYellowBrand,
            expandable: false,
            selectedIndex: _currentIndex,
            items: const [
              SideNavigationBarItem(
                icon: Icons.library_music,
                label: 'Playlists',
              ),
              SideNavigationBarItem(
                icon: Icons.screen_search_desktop_outlined,
                label: 'Discover',
              ),
              SideNavigationBarItem(
                icon: Icons.music_note_sharp,
                label: 'Tracks',
              ),
              SideNavigationBarItem(
                icon: Icons.disc_full_rounded,
                label: 'Albums',
              ),
              SideNavigationBarItem(
                icon: Icons.person,
                label: 'Artists',
              ),
              SideNavigationBarItem(
                icon: Icons.shop_2_sharp,
                label: 'NFT Marketplace',
              ),
            ],
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          Expanded(
            child: _children.elementAt(_currentIndex),
          )
        ],
      ),

      /*CategorySelector(),
      drawer: Drawer(
        child: Text("Hello"),
      ),*/ // new
      // bottomNavigationBar: BottomNavigationBar(
      //   onTap: onTabTapped, // new
      //   currentIndex: _currentIndex, // new
      //   items: [
      //     new BottomNavigationBarItem(
      //       icon: Icon(Icons.home),
      //       label: 'Home',
      //     ),
      //     new BottomNavigationBarItem(
      //       icon: Icon(Icons.create),
      //       label: 'Mint NFT',
      //     ),
      //     // new BottomNavigationBarItem(
      //     //     icon: Icon(Icons.person), label: 'Profile'),
      //     new BottomNavigationBarItem(
      //         icon: Icon(Icons.access_alarm), label: 'NFT')
      //   ],
      // ),
    );
  }
  // void onTabTapped(int index) {
  //   setState(() {
  //     _currentIndex = index;
  //   });
  // }
}
