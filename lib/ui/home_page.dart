import 'dart:io';

import 'package:dicoding_news_app/model/article.dart';
import 'package:dicoding_news_app/ui/article_list_page.dart';
import 'package:dicoding_news_app/ui/article_detail_page.dart';
import 'package:dicoding_news_app/ui/settings_page.dart';
import 'package:dicoding_news_app/cummon/styles.dart';
import 'package:dicoding_news_app/widgets/platform_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static const routeName = '/home_page';

  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _bottomNavIndex = 0;
  // Kita dapat menyederhanakannya dengan membuat variabel yang menampung item tab
  final List<BottomNavigationBarItem> _bottomNavBarItems = [
    BottomNavigationBarItem(
      icon: Icon(Platform.isIOS ? CupertinoIcons.news : Icons.public),
      label: "Headline",
    ),
    BottomNavigationBarItem(
      icon: Icon(Platform.isIOS ? CupertinoIcons.settings : Icons.settings),
      label: "Setting",
    ),
  ];
  // buatkan list widget untuk menampilkan halaman ketika tab dipilih
  final List<Widget> _listWidget = [
    ArticleListPage(),
    SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
    // ketika sudah di extract menjadi widget kita ubah NewListPage ini menjadi HomePage
    // return const Scaffold(
    //   body: ArticleListPage(),
    // );
    // karna sudah di bungkus menjadi PlatformWidget yg nanti akan berubah sesuai ios/andro
    // return Scaffold(
    //   appBar: AppBar(
    //     title: const Text(
    //       'News App',
    //     ),
    //   ),
    //   body: _buildList(context),
    // );
  }

// _buildAndroid untuk android
  Widget _buildAndroid(BuildContext context) {
    // int _bottomNavIndex = 0;
    return Scaffold(
      // body: _bottomNavIndex == 0 ? ArticleListPage() : Placeholder(),
      // lalu ubahkan Placeholder untuk implemen SettingPage
      // body: _bottomNavIndex == 0 ? ArticleListPage() : SettingsPage(),
      // lalu ketika membuat listWidget di implementasi
      body: _listWidget[_bottomNavIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: secondaryColor,
        currentIndex: _bottomNavIndex,
        items: _bottomNavBarItems,
        onTap: (selected) {
          setState(() {
            _bottomNavIndex = selected;
          });
        },
      ),
    );
  }

  // buildIOS untuk IOS
  Widget _buildIos(BuildContext context) {
    return CupertinoTabScaffold(
      tabBar: CupertinoTabBar(
          activeColor: secondaryColor, items: _bottomNavBarItems),
      tabBuilder: (context, index) {
        // switch (index) {
        //   case 1:
        //     return SettingsPage();
        //   default:
        //     return ArticleListPage();
        // }
        // sudah di define list widget di atas jadi seperti ini
        return _listWidget[index];
      },
    );
  }
}
