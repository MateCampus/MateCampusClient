import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// 값을 변환해서 반환해주는 메소드 (ex. dateTime -> 한국어로 변환)

// 지나간 시간 ex. 4:37 PM
String dateToPastTime(DateTime time) {
  String formDate = DateFormat('jm').format(DateTime.now());
  return formDate;
}

// 날짜와 시간 ex. 10/26 2:05 PM
String dateWithTime(DateTime time) {
  String formDate = DateFormat('MM/dd').add_jm().format(time);
  return formDate;
}

// 날짜, 요일, 시간 ex. 10/26 (화) 2:05 PM
String dateWeekdayTime(DateTime time) {
  String date = DateFormat('MM/dd').format(time) +
      "(" +
      convertWeekday(weekday: time.weekday) +
      ") " +
      DateFormat.jm().format(time);
  return date;
}

// 요일(index) -> 요일(한글) 반환 ex. 월
String convertWeekday({required int weekday}) {
  switch (weekday) {
    case 1:
      return '월';
    case 2:
      return '화';
    case 3:
      return '수';
    case 4:
      return '목';
    case 5:
      return '금';
    case 6:
      return '토';
    case 7:
      return '일';
  }
  return "error";
}

// 날짜, 시간 따로된 값을 합친 값으로 변경
DateTime updateDate(DateTime _date, TimeOfDay _time) {
  return new DateTime(_date.year, _date.month, _date.day, _time.hour,
      _time.minute, _date.second);
}

// d-day ex. D-1 or D-Day
String dateToDday(DateTime _date) {
  var duration = DateTime.now().difference(_date).inDays;
  return duration >= 0
      ? (duration == 0 ? "D-Day" : "종료")
      : "D" + duration.toString();
}

// day ex. 10/26
String dateToDay(DateTime time) {
  String formDate = DateFormat('MM/dd').format(time);
  return formDate;
}

// time ex. 오후 2:05
String dateToTime(DateTime time) {
  String minute =
      time.minute < 10 ? "0" + time.minute.toString() : time.minute.toString();
  if (time.hour > 13) {
    return "오후 " + (time.hour - 12).toString() + ":" + minute;
  } else {
    return "오전 " + (time.hour).toString() + ":" + minute;
  }
}

String dateToYearMonthDay(DateTime time) {
  String formDate = DateFormat('yyyy.MM.dd').format(time);
  return formDate;
}
