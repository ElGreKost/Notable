// todo is it somewhere useful??

// // Changes the time format from MM/dd/yyyy to dd/MM/yyyy as needed in app.
// import 'package:intl/date_symbol_data_local.dart';
// import 'package:intl/intl.dart';
//
// const String dateTimeFormatPattern = 'dd/MM/yyyy';
//
// extension DateTimeExtension on DateTime {
//   /// Return a string representing [date] formatted according to our locale
//   String format([
//     String pattern = dateTimeFormatPattern,
//     String? locale,
//   ]) {
//     if (locale != null && locale.isNotEmpty) {
//       initializeDateFormatting(locale);
//     }
//     return DateFormat(pattern, locale).format(this);
//   }
// }
