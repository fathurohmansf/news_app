import 'dart:io';

import 'package:dicoding_news_app/provider/preferences_provider.dart';
import 'package:dicoding_news_app/provider/scheduling_provider.dart';
import 'package:dicoding_news_app/widgets/custom_dialog.dart';
import 'package:dicoding_news_app/widgets/platform_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return PlatformWidget(
      androidBuilder: _buildAndroid,
      iosBuilder: _buildIos,
    );
    // bukan placeholder lagi karna sudah di bungkus PlatformWidget
    // return Placeholder();
  }

  // Widget ini berfungsi untuk switch theme dark mode
  Widget _buildList(BuildContext context) {
    return Consumer<PreferencesProvider>(
      builder: (context, provider, child) {
        return ListView(
          children: [
            Material(
              child: ListTile(
                title: const Text('Dark Theme'),
                trailing: Switch.adaptive(
                  value: provider.isDarkTheme,
                  // value: false,
                  onChanged: (value) {
                    provider.enableDarkTheme(value);
                    // di matikan karna pakai provider untuk dark time bukan menampilkan dialog lagi untuk mengubah cupertino
                    // customDialog(context);
                    // buat alert ga bisa showDialog aja,
                    // harus di define 22 nya showCupertinoDialog=IOS dan showDialog=android karna akan error
                    // di matikan karna mau menerapkan notification
                    // defaultTargetPlatform == TargetPlatform.iOS
                    //     ? showCupertinoDialog(
                    //         context: context,
                    //         barrierDismissible: true,
                    //         builder: (context) {
                    //           return CupertinoAlertDialog(
                    //             title: const Text('Coming Soon!'),
                    //             content:
                    //                 const Text('This feature will be coming soon!'),
                    //             actions: [
                    //               CupertinoDialogAction(
                    //                 child: const Text('Ok'),
                    //                 onPressed: () {
                    //                   Navigator.pop(context);
                    //                 },
                    //               ),
                    //             ],
                    //           );
                    //         },
                    //       )
                    //     : showDialog(
                    //         context: context,
                    //         builder: (context) {
                    //           return AlertDialog(
                    //             title: const Text('Coming Soon!'),
                    //             content:
                    //                 const Text('This feature will be coming soon!'),
                    //             actions: [
                    //               TextButton(
                    //                 onPressed: () {
                    //                   Navigator.pop(context);
                    //                 },
                    //                 child: const Text('Ok'),
                    //               ),
                    //             ],
                    //           );
                    //         },
                    //       );
                  },
                ),
              ),
            ),
            // membuat widget untuk melakukan proses pengaktifan dari scheduling tersebut
            Material(
              child: ListTile(
                title: const Text('Scheduling News'),
                trailing: Consumer<SchedulingProvider>(
                  builder: (context, scheduled, _) {
                    // Switch mengirim nilai bool ke dalam fungsi scheduled.scheduledNews(value)
                    // nilai default Switch = 0 / false
                    return Switch.adaptive(
                      value: provider.isDailyNewsActive,
                      onChanged: (value) async {
                        if (Platform.isIOS) {
                          customDialog(context);
                        } else {
                          scheduled.scheduledNews(value);
                          provider.enableDailyNews(value);
                        }
                      },
                      // di matikan karna menerapkan provider dark theme dll di main.dart
                      // Mengaktifkan Provider menjadi true
                      // value: scheduled.isScheduled,
                      // onChanged: (value) async {
                      //   if (Platform.isIOS) {
                      //     customDialog(context);
                      //   } else {
                      //     scheduled.scheduledNews(value);
                      //   }
                      // },
                    );
                  },
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildAndroid(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: _buildList(context),
    );
  }

  Widget _buildIos(BuildContext context) {
    return CupertinoPageScaffold(
      navigationBar: CupertinoNavigationBar(
        middle: Text('Settings'),
      ),
      child: _buildList(context),
    );
  }
}
