import 'package:android_alarm_manager_plus/android_alarm_manager_plus.dart';
import 'package:dicoding_news_app/utils/backround_service.dart';
import 'package:dicoding_news_app/utils/date_time_helper.dart';
import 'package:flutter/material.dart';

// Kelas di bawah berfungsi untuk memicu proses scheduling dengan memanggil fungsi scheduledNews.
// Fungsi tersebut mengecek nilai dari variabel value. Jika bernilai true maka akan menjalankan proses scheduling,
// sedangkan jika bernilai false akan membatalkan proses scheduling
class SchedulingProvider extends ChangeNotifier {
  bool _isScheduled = false;

  bool get isScheduled => _isScheduled;

  Future<bool> scheduledNews(bool value) async {
    _isScheduled = value;
    if (_isScheduled) {
      print('Scheduling News Activated');
      notifyListeners();
      return await AndroidAlarmManager.periodic(
        const Duration(hours: 24),
        1,
        BackgroundService.callback,
        startAt: DateTimeHelper.format(),
        exact: true,
        wakeup: true,
      );
    } else {
      print('Scheduling News Canceled');
      notifyListeners();
      return await AndroidAlarmManager.cancel(1);
    }
  }
}
