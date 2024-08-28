import 'package:flutter/material.dart';
import '../utils/attendance_utils.dart'; // Path to your utility function
import 'package:intl/intl.dart';

// ignore: duplicate_import

class AttendancePage extends StatefulWidget {
  @override
  _AttendancePageState createState() => _AttendancePageState();
}

class _AttendancePageState extends State<AttendancePage> {
  String _attendanceStatus = 'Loading...'; // Default status while loading
  DateTime _today = DateTime.now();

  @override
  void initState() {
    super.initState();
    _loadAttendanceStatus();
  }

  Future<void> _loadAttendanceStatus() async {
    try {
      Map<DateTime, String> records = await loadAttendanceData();
      print("Loaded records: $records"); // Debug print
      setState(() {
        _attendanceStatus =
            records[DateTime(_today.year, _today.month, _today.day)] ??
                'No record'; // Default if no record found
      });
    } catch (e) {
      setState(() {
        _attendanceStatus = 'Error loading data';
      });
      print("Error loading data: $e"); // Log error for debugging
    }
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
          'Today\'s Attendance',
          style: TextStyle(
              color: Colors.white, fontFamily: 'Roboto', fontSize: 24.0),
        ),
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                padding: EdgeInsets.symmetric(vertical: 20.0),
                decoration: BoxDecoration(
                  color: Colors.greenAccent.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Column(
                  children: [
                    Icon(Icons.calendar_today,
                        size: 100.0, color: Colors.green),
                    SizedBox(height: 20.0),
                    Text(
                      'Attendance Status',
                      style: TextStyle(
                          fontSize: 24.0,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Roboto'),
                      textAlign: TextAlign.center,
                    ),
                    SizedBox(height: 20.0),
                    Text(
                      'Today: ${DateFormat('yyyy-MM-dd').format(_today)}',
                      style: TextStyle(fontSize: 18.0, fontFamily: 'Roboto'),
                    ),
                    SizedBox(height: 10.0),
                    Text(
                      _attendanceStatus,
                      style: TextStyle(
                        fontSize: 22.0,
                        fontWeight: FontWeight.bold,
                        color: _getStatusColor(_attendanceStatus),
                        fontFamily: 'Roboto',
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 40.0),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 15.0),
                  foregroundColor: Colors.white,
                  backgroundColor: Colors.green, // Text color
                  textStyle: TextStyle(
                      fontSize: 18.0,
                      fontFamily: 'Roboto',
                      fontWeight: FontWeight.bold),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                onPressed: () {
                  // Navigator.push(
                  //   context,
                  //   MaterialPageRoute(
                  //     builder: (context) => AttendanceCalendarPage(
                  //       selectedDate: _today,
                  //     ),
                  //   ) as Route<Object?>,
                  // );
                },
                child: Text('Details'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MaterialPageRoute {}
