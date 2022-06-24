import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

// 값을 변환해서 반환해주는 메소드 (ex. dateTime -> 한국어로 변환)

//post에서 쓴다(mypage_post포함). 1분전 ~59분전 -> 1시간전 ~ 23시간전 -> 10/26 2:05 PM
String dateToElapsedTime(DateTime _date) {
  var duration = DateTime.now().difference(_date).inMinutes;
  String value = '';
  if (duration < 1) {
    value = '방금 전';
  } else if (duration < 60) {
    for (int i = 1; i < 60; i++) {
      if (duration < i) {
        value = '$i분 전';
        break;
      }
    }
  } else {
    value = _dateToElapsedTimeByHours(_date);
  }
  return value;
}

String _dateToElapsedTimeByHours(DateTime _date) {
  var duration = DateTime.now().difference(_date).inHours;
  String value = '';
  if (duration < 24) {
    for (int i = 1; i < 24; i++) {
      if (duration < i) {
        value = '$i시간 전';
        break;
      }
    }
  } else {
    value = _dateWithTime(_date);
  }
  return value;
}

// 날짜와 시간 ex. 10/26 2:05 PM
String _dateWithTime(DateTime time) {
  String formDate = DateFormat('MM/dd').add_jm().format(time);
  return formDate;
}

// time ex. 오후 2:05
//chat_detail, voice_detail_text_chat 에서 씀
String dateToTime(DateTime time) {
  String minute =
      time.minute < 10 ? "0" + time.minute.toString() : time.minute.toString();

  if (time.hour < 12) {
    return "오전 " + (time.hour).toString() + ":" + minute;
  } else if (time.hour == 12) {
    return "오후 " + time.hour.toString() + ":" + minute;
  } else {
    return "오후 " + (time.hour - 12).toString() + ":" + minute;
  }
}

// time ex. 2:05 PM
String dateToTimeEng(DateTime time) {
  String formDate = DateFormat('jm').format(time);
  return formDate;
}

//Chat Main에서 사용 1분전 ~ 59분전 -> 1시간전 ~ 23시간전 -> 6월 23일
//알림에서도 사용
String dateToElapsedTimeOnChatMain(DateTime _date) {
  var duration = DateTime.now().difference(_date).inMinutes;
  String value = '';
  if (duration < 1 || _date == DateTime(2021, 05, 05)) {
    value = '방금 전';
  } else if (duration < 60) {
    for (int i = 1; i < 60; i++) {
      if (duration < i) {
        value = '$i분 전';
        break;
      }
    }
  } else {
    value = _dateToElapsedTimeByHoursOnChatMain(_date);
  }
  return value;
}

String _dateToElapsedTimeByHoursOnChatMain(DateTime _date) {
  var duration = DateTime.now().difference(_date).inHours;
  String value = '';
  if (duration < 24) {
    for (int i = 1; i < 24; i++) {
      if (duration < i) {
        value = '$i시간 전';
        break;
      }
    }
  } else {
    value = dateToDay(_date);
  }
  return value;
}

// day ex. 10/26
String dateToDay(DateTime time) {
  String formDate = DateFormat('MM월 dd일').format(time);
  return formDate;
}


// String dateToYearMonthDay(DateTime time) {
//   String formDate = DateFormat('yyyy.MM.dd').format(time);
//   return formDate;
// }


// 날짜, 요일, 시간 ex. 10/26 (화) 2:05 PM
// String dateWeekdayTime(DateTime time) {
//   String date = DateFormat('MM/dd').format(time) +
//       "(" +
//       convertWeekday(weekday: time.weekday) +
//       ") " +
//       DateFormat.jm().format(time);
//   return date;
// }

// 요일(index) -> 요일(한글) 반환 ex. 월
// String convertWeekday({required int weekday}) {
//   switch (weekday) {
//     case 1:
//       return '월';
//     case 2:
//       return '화';
//     case 3:
//       return '수';
//     case 4:
//       return '목';
//     case 5:
//       return '금';
//     case 6:
//       return '토';
//     case 7:
//       return '일';
//   }
//   return "error";
// }

// 날짜, 시간 따로된 값을 합친 값으로 변경
// DateTime updateDate(DateTime _date, TimeOfDay _time) {
//   return new DateTime(_date.year, _date.month, _date.day, _time.hour,
//       _time.minute, _date.second);
// }

// d-day ex. D-1 or D-Day
// String dateToDday(DateTime _date) {
//   var duration = DateTime.now().difference(_date).inDays;
//   return duration >= 0
//       ? (duration == 0 ? "D-Day" : "종료")
//       : "D" + duration.toString();
// }

// 지나간 시간 ex. 4:37 PM
// String dateToPastTime(DateTime time) {
//   String formDate = DateFormat('jm').format(DateTime.now());
//   return formDate;
// }