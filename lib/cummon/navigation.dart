import 'package:flutter/material.dart';

// Karena kita perlu menggunakan navigasi yang tidak membutuhkan sebuah context.
// Kita akan memanggil fungsi tersebut di dalam kelas NotificationHelper yang di dalamnya tidak menyediakan sebuah context.
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class Navigation {
  static intentWithData(String routeName, Object arguments) {
    navigatorKey.currentState?.pushNamed(routeName, arguments: arguments);
  }

  static back() => navigatorKey.currentState?.pop();
}
