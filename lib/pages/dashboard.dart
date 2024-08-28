import 'package:flutter/material.dart';
// import 'dart:html' as html;

class DashboardPage extends StatefulWidget {
  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  String _name = 'Pragyan Borthakur';
  String _email = 'xyz@email.com';
  ImageProvider _profileImage = AssetImage('assets/images/hey.png');

  // void _updateUserInfo(String name, String email, html.File? profileImage) {
  //   setState(() {
  //     _name = name;
  //     _email = email;
  //     if (profileImage != null) {
  //       _profileImage = NetworkImage(html.Url.createObjectUrl(profileImage));
  //     } else {
  //       _profileImage = AssetImage('assets/images/hey.png');
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text('Dashboard', style: TextStyle(color: Colors.white)),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Attendance Records - Wrap with GestureDetector for navigation
            GestureDetector(
              onTap: () {
                // Navigator.push(context, MaterialPageRoute(builder: builder))
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(builder: (context) => AttendancePage()),
                // );
              },
              child: Card(
                elevation: 3.0,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Attendance Records',
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10.0),
                      // Example attendance records
                      ListTile(
                        title: Text('Attendance on 2024-07-22'),
                        subtitle: Text('Present'),
                        trailing: Icon(Icons.check_circle, color: Colors.green),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            // Upcoming Events and Notifications
            Card(
              elevation: 3.0,
              child: Padding(
                padding: EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Upcoming Events and Notifications',
                      style: TextStyle(
                          fontSize: 20.0, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10.0),
                    // Example events and notifications
                    ListTile(
                      title: Text('Webinar on Flutter Development'),
                      subtitle: Text('July 20, 2024 at 10:00 AM'),
                      trailing: Icon(Icons.event, color: Colors.blue),
                    ),
                    ListTile(
                      title: Text('New Notification'),
                      subtitle: Text('You have a new message'),
                      trailing: Icon(Icons.notifications, color: Colors.orange),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 20.0),
            // User Information and Profile Updates - Wrap with GestureDetector for navigation
            GestureDetector(
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) => Userinfo(onUpdate: _updateUserInfo),
                //   ),
                // );
              },
              child: Card(
                elevation: 3.0,
                child: Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'User Information and Profile Updates',
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 10.0),
                      // Example user information and profile update
                      ListTile(
                        leading: CircleAvatar(
                          backgroundImage: _profileImage,
                        ),
                        title: Text(_name),
                        subtitle: Text(_email),
                        trailing: Icon(Icons.edit),
                        onTap: () {
                          // Navigator.push(
                          //     context,
                          //     MaterialPageRoute(
                          //         builder: (_) =>
                          //             Userinfo(onUpdate: _updateUserInfo)));
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //     builder: (context) => Userinfo(onUpdate: _updateUserInfo),
                          //   ),
                          // );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
