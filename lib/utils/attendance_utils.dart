import 'dart:typed_data';
import 'package:excel/excel.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:intl/intl.dart';

Future<Map<DateTime, String>> loadAttendanceData() async {
  final ByteData data = await rootBundle.load('assets/attendance.xlsx');
  final List<int> bytes = data.buffer.asUint8List();
  final Excel excel = Excel.decodeBytes(bytes);

  Map<DateTime, String> attendanceRecords = {};

  for (var table in excel.tables.keys) {
    print("Table: $table"); // Print table name
    var rows = excel.tables[table]?.rows;
    if (rows != null) {
      for (var row in rows.skip(1)) {
        // Skip header row
        try {
          // Extract the status from each row
          String status = row[1]?.value.toString() ?? 'No Record';
          //print(status);

          // Optional: Filter out unwanted data if necessary
          if (status.isEmpty) status = 'No Record';

          DateTime date;
          // Assuming the date is in long date format
          try {
            date =
                DateFormat('yyyy-MM-dd').parse(row[0]?.value.toString() ?? "");
          } catch (e) {
            date = DateTime.now(); // Fallback if parsing fails
          }

          // Ensure only the date part is used, time set to midnight

          attendanceRecords[DateTime(date.year, date.month, date.day)] = status;
          print("Loaded: $date -> $status"); // Print loaded data
        } catch (e) {
          print("Error parsing row: $row, error: $e");
        }
      }
    }
  }
  return attendanceRecords;
}
