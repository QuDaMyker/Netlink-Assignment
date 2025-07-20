import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DateTimeExt on DateTime {
  String get yyyyMMddHHmmss => DateFormat('yyyy-MM-dd HH:mm:ss').format(this);
  String get ddMMyyyyHHmmss => DateFormat('dd-MM-yyyy HH:mm:ss').format(this);
  String get ddMMyyyyHHmm => DateFormat('dd-MM-yyyy HH:mm').format(this);
  String get ddMMyyyy => DateFormat('dd-MM-yyyy').format(this);
  String get hhmm => DateFormat('HH:mm').format(this);
  String get yyyymmdd => DateFormat('yyyy-MM-dd').format(this);
  String eeeddmm({String? locale}) {
    return DateFormat('EEE, dd MMM', locale).format(this);
  }

  String eeeddmmyyyy({String? locale}) {
    return DateFormat('EEE, dd MMM yyyy', locale).format(this);
  }

  static DateTime? parseFormatEEEddMMMyyyyHHmmss(String formatedString) =>
      DateFormat("EEE, dd MMM yyyy HH:mm:ss 'GMT'").tryParse(formatedString);
  static DateTime? parseFormatyyyyMMddHHmmss(String formatedString) =>
      DateFormat("yyyy-MM-dd HH:mm:ss").tryParse(formatedString);
  static DateTime? parseFormatddMMyyyyHHmm(String formatedString) =>
      DateFormat('dd-MM-yyyy HH:mm').tryParse(formatedString);
  static DateTime? parseFormatddMMyyyy(String formatedString) =>
      DateFormat('dd-MM-yyyy').tryParse(formatedString);
  static DateTime? parseFormatyyyyMMdd(String formatedString) =>
      DateFormat('yyyy-MM-dd').tryParse(formatedString);
  DateTime get toDate => DateTime(year, month, day);
  DateTime get nextDate => add(const Duration(days: 1));

  bool isSameDay(DateTime? other) => DateUtils.isSameDay(this, other);
  bool get isToday => isSameDay(DateTime.now());
  bool get isTomorrow => isSameDay(DateTime.now().add(const Duration(days: 1)));
}
