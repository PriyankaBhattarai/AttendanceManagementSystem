import 'package:flutter/material.dart';
import '../utils/attendance_utils.dart'; // Ensure this is the correct path
import 'package:intl/intl.dart'; // For date formatting

class AttendanceCalendarPage extends StatefulWidget {
  final DateTime selectedDate;

  AttendanceCalendarPage({required this.selectedDate});

  @override
  _AttendanceCalendarPageState createState() => _AttendanceCalendarPageState();
}

class _AttendanceCalendarPageState extends State<AttendanceCalendarPage> {
  Map<String, Map<String, String>> _attendanceRecordsByMonth = {};
  String _dateRangeMessage = '';

  @override
  void initState() {
    super.initState();
    _loadAttendanceRecords();
  }

  Future<void> _loadAttendanceRecords() async {
    try {
      Map<DateTime, String> records = await loadAttendanceData();
      setState(() {
        _attendanceRecordsByMonth = _groupRecordsByMonth(records);
        _dateRangeMessage = _getDateRangeMessage(records);
      });
    } catch (e) {
      print('Error loading attendance data: $e');
    }
  }

  Map<String, Map<String, String>> _groupRecordsByMonth(
      Map<DateTime, String> records) {
    Map<String, Map<String, String>> groupedRecords = {};

    records.forEach((date, status) {
      String monthYear = DateFormat('yyyy-MM').format(date);
      String day = DateFormat('d').format(date);
      String truncatedStatus = _extractFirstParameter(status);

      if (groupedRecords.containsKey(monthYear)) {
        groupedRecords[monthYear]![day] = truncatedStatus;
      } else {
        groupedRecords[monthYear] = {day: truncatedStatus};
      }
    });

    return groupedRecords;
  }

  String _extractFirstParameter(String dataString) {
    String trimmedString =
        dataString.replaceFirst('Data(', '').replaceFirst(')', '');
    List<String> parts = trimmedString.split(',');
    return parts.isNotEmpty ? parts[0].trim() : '';
  }

  String _getDateRangeMessage(Map<DateTime, String> records) {
    if (records.isEmpty) {
      return 'No records available for this month.';
    }

    DateTime minDate = records.keys.reduce((a, b) => a.isBefore(b) ? a : b);
    DateTime maxDate = records.keys.reduce((a, b) => a.isAfter(b) ? a : b);

    String startDate = DateFormat('d MMM yyyy').format(minDate);
    String endDate = DateFormat('d MMM yyyy').format(maxDate);

    return 'Records available from $startDate to $endDate.';
  }

  int getDaysInMonth(int year, int month) {
    return DateTime(year, month + 1, 0).day;
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Present':
        return Colors.green;
      case 'Absent':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          'Attendance Records',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.all(16.0),
        children: [
          Text(
            _dateRangeMessage,
            style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 16.0),
          ..._attendanceRecordsByMonth.keys.map((monthYear) {
            return ExpansionTile(
              title: Text(
                'Month: $monthYear',
                style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.bold),
              ),
              children: List.generate(
                getDaysInMonth(
                  DateFormat('yyyy').parse(monthYear).year,
                  DateFormat('MM').parse(monthYear).month,
                ),
                (index) {
                  String day = (index + 1).toString();
                  String status =
                      _attendanceRecordsByMonth[monthYear]?[day] ?? 'No Record';

                  return ListTile(
                    title: Text('Day: $day - Status: $status',
                        style: TextStyle(fontSize: 16.0)),
                    trailing: Icon(
                      status == 'Present'
                          ? Icons.check_circle
                          : (status == 'Absent'
                              ? Icons.cancel
                              : (status == 'Half Day'
                                  ? Icons.access_time
                                  : Icons.beach_access)),
                      color: _getStatusColor(status),
                    ),
                  );
                },
              ),
            );
          }).toList(),
        ],
      ),
    );
  }
}
