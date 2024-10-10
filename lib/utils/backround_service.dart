import 'dart:ui';
import 'dart:isolate';
import 'package:dicoding_news_app/main.dart';
import 'package:dicoding_news_app/data/api/api_service.dart';
import 'package:dicoding_news_app/utils/notification_helper.dart';

// membuat beberapa fungsi seperti initializeIsolate, callback, dan juga someTask.
// Fungsi initializeIsolate adalah mendaftarkan SendPort isolate UI untuk memungkinkan komunikasi dari isolate background
final ReceivePort port = ReceivePort();

// Fungsi class ini untuk menjalankan proses background.
// jadi setelah data berhasil di dapatkan, akan di kirimkan ke showNotification
class BackgroundService {
  static BackgroundService? _instance;
  static const String _isolateName = 'isolate';
  static SendPort? _uiSendPort;

  BackgroundService._internal() {
    _instance = this;
  }

  factory BackgroundService() => _instance ?? BackgroundService._internal();

  void initializeIsolate() {
    IsolateNameServer.registerPortWithName(
      port.sendPort,
      _isolateName,
    );
  }

  static Future<void> callback() async {
    print('Alarm fired!');
    final NotificationHelper notificationHelper = NotificationHelper();
    var result = await ApiService().topHeadlines();
    // sebagai result data di kirimkan ke showNotification(notification_helper.dart)
    await notificationHelper.showNotification(
        flutterLocalNotificationsPlugin, result);

    _uiSendPort ??= IsolateNameServer.lookupPortByName(_isolateName);
    _uiSendPort?.send(null);
  }
}
