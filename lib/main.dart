import 'dart:io';

import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:dicoding_news_app/cummon/navigation.dart';
import 'package:dicoding_news_app/data/api/api_service.dart';
import 'package:dicoding_news_app/data/db/database_helper.dart';
import 'package:dicoding_news_app/data/model/article.dart';
import 'package:dicoding_news_app/data/preferences/preferences_helper.dart';
import 'package:dicoding_news_app/provider/database_provider.dart';
import 'package:dicoding_news_app/provider/news_provider.dart';
import 'package:dicoding_news_app/provider/preferences_provider.dart';
import 'package:dicoding_news_app/provider/scheduling_provider.dart';
import 'package:dicoding_news_app/ui/article_web_view.dart';
import 'package:dicoding_news_app/ui/article_detail_page.dart';
import 'package:dicoding_news_app/ui/home_page.dart';
import 'package:dicoding_news_app/utils/backround_service.dart';
import 'package:dicoding_news_app/utils/notification_helper.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:dicoding_news_app/cummon/styles.dart';

// Tambahkan konfigurasi Notification flutter installation
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final NotificationHelper _notificationHelper = NotificationHelper();
  final BackgroundService _service = BackgroundService();
  _service.initializeIsolate();
  if (Platform.isAndroid) {
    await AndroidAlarmManager.initialize();
  }
  await _notificationHelper.initNotifications(flutterLocalNotificationsPlugin);

  runApp(const MyApp());
}
// dimaktikan karna akan di define konfigurasi notifikation di atas
// void main() {
//   runApp(const MyApp());
// }

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => NewsProvider(apiService: ApiService()),
        ),
        ChangeNotifierProvider(create: (_) => SchedulingProvider()),
        ChangeNotifierProvider(
          create: (_) => PreferencesProvider(
            preferencesHelper: PreferencesHelper(
              sharedPreferences: SharedPreferences.getInstance(),
            ),
          ),
        ),
        // ChangeNotifierProvider(
        //   // implementasi database provider
        //   create: (_) => DatabaseProvider(databaseHelper: DatabaseHelper()),
        // ),
      ],
      child: Consumer<PreferencesProvider>(
        builder: (context, provider, child) {
          return MaterialApp(
            title: 'News App',
            // Daftarkan Theme Data Shared Preferance Provider
            theme: provider.themeData,
            // widget CupertinoThemeuntuk digunakan pada komponen Cupertino.
            builder: (context, child) {
              return CupertinoTheme(
                data: CupertinoThemeData(
                  // gunakan brigness untuk mengatur kecerahan brignest
                  brightness:
                      provider.isDarkTheme ? Brightness.dark : Brightness.light,
                ),
                child: Material(
                  child: child,
                ),
              );
            },
            // add global navigation
            navigatorKey: navigatorKey,
            // Di matikan Karna sudah pakai Shared Preference Provider untuk thema, dark mode, nyimpen key value dll
            // theme: ThemeData(
            //   // primarySwatch: Colors.blue,
            //   // visualDensity: VisualDensity.adaptivePlatformDensity,
            //   // add Thema import
            //   colorScheme: Theme.of(context).colorScheme.copyWith(
            //         primary: primaryColor,
            //         onPrimary: Colors.black,
            //         secondary: secondaryColor,
            //       ),
            //   textTheme: myTextTheme,
            //   // warna appbar
            //   appBarTheme: AppBarTheme(elevation: 0),
            //   // ubah tampilan button
            //   elevatedButtonTheme: ElevatedButtonThemeData(
            //     style: ElevatedButton.styleFrom(
            //       backgroundColor: secondaryColor,
            //       foregroundColor: Colors.white,
            //       textStyle: const TextStyle(),
            //       // ubah bentuk button
            //       shape: const RoundedRectangleBorder(
            //         borderRadius: BorderRadius.all(
            //           Radius.circular(0),
            //         ),
            //       ),
            //     ),
            //   ),
            // ),
            initialRoute: HomePage.routeName,
            routes: {
              HomePage.routeName: (context) => const HomePage(),
              ArticleDetailPage.routeName: (context) => ArticleDetailPage(
                    // article: ModalRoute.of(context)?.settings.arguments as Article,
                    article:
                        ModalRoute.of(context)?.settings.arguments as Article,
                  ),
              ArticleWebView.routeName: (context) => ArticleWebView(
                    url: ModalRoute.of(context)?.settings.arguments as String,
                  ),
            },
          );
        },
      ),
    );
  }
}
