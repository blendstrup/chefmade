import 'dart:io' show File, Platform;

import 'package:csv/csv.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:path_provider/path_provider.dart';

import '../data/models/dining_model.dart';

class FileUtilities {
  static String formatDate(DateTime date) => DateFormat.yMMMEd().format(date);
  static String formatTime(DateTime date) => DateFormat.Hm().format(date);
  static String formatAbrMonth(DateTime date) => DateFormat.MMM().format(date);
  static String formatDay(DateTime date) => DateFormat.d().format(date);
  static String formatMonthYear(DateTime date) =>
      DateFormat.yMMMM().format(date);

  static Future<File> writeDiningCsvFile({
    required String fileName,
    required Dining dining,
  }) async {
    List<List<dynamic>> rows = [];

    //TODO Update exported data to include all relevant fields
    //Date requested, status, event date, time, arrival time, amount of guests, menu, name, address, phone number, email, customer comments, booked through chefmade, restaurants notes?
    List<dynamic> header = ['Requested', 'Status', 'Name', 'Event Date'];
    rows.add(header);

    rows.add([
      '${formatDate(dining.creationDate)}, ${formatTime(dining.creationDate)}',
      dining.status,
      '${dining.customerFirstName} ${dining.customerLastName}',
      '${formatDate(dining.eventDate)}, ${formatTime(dining.eventDate)}',
    ]);

    String csv = const ListToCsvConverter().convert(rows);

    final directory = (Platform.isIOS)
        ? await getApplicationSupportDirectory()
        : await getApplicationDocumentsDirectory();

    return File('${directory.path}/$fileName.csv').writeAsString(csv);
  }

  static Future<File> writeCsvFile({
    required String fileName,
    required Map<String, dynamic> map,
  }) async {
    List<List<dynamic>> rows = [];

    List<dynamic> header = map.keys.toList();
    rows.add(header);

    for (final element in map.entries) {
      List<String> row = [];

      for (final e in element.value) {
        row.add(e);
      }

      rows.add(row);
    }

    String csv = const ListToCsvConverter().convert(rows);

    final directory = (Platform.isIOS)
        ? await getApplicationSupportDirectory()
        : await getApplicationDocumentsDirectory();

    return File('${directory.path}/$fileName.csv').writeAsString(csv);
  }

  static Future<File> writeDiningTxtFile({
    required Dining dining,
    required String fileName,
  }) async {
    final directory = (Platform.isIOS)
        ? await getApplicationSupportDirectory()
        : await getApplicationDocumentsDirectory();

    //TODO Update exported data to include all relevant fields
    //Date requested, status, event date, time, arrival time, amount of guests, menu, name, address, phone number, email, customer comments, booked through chefmade, restaurants notes?
    //Text should just be a capitalised title (key) followed by the content on the next line (value), and then an empty line as seperator
    final String text =
        'Requested at:\n${'${formatDate(dining.creationDate)}, ${formatTime(dining.creationDate)}'}\n\nStatus:\n${dining.status}\n\nName:\n${dining.customerFirstName} ${dining.customerLastName}\n\nEvent date:\n${formatDate(dining.eventDate)}, ${formatTime(dining.eventDate)}\n\n';

    return File('${directory.path}/$fileName.txt').writeAsString(text);
  }

  static Future<File> writeTxtFile({
    required String text,
    required String fileName,
  }) async {
    final directory = (Platform.isIOS)
        ? await getApplicationSupportDirectory()
        : await getApplicationDocumentsDirectory();

    return File('${directory.path}/$fileName.txt').writeAsString(text);
  }
}
