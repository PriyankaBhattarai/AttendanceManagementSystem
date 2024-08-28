import 'package:flutter/material.dart';
import 'package:image_picker_web/image_picker_web.dart';
import 'dart:html' as html;

class Userinfo extends StatefulWidget {
  final Function(String name, String email, html.File? profileImage) onUpdate;

  Userinfo({required this.onUpdate});

  @override
  _UserInfoPageState createState() => _UserInfoPageState();
}

class _UserInfoPageState extends State<Userinfo> {
  final _formKey = GlobalKey<FormState>();
  String _name = 'Pragyan Borthakur';
  String _email = 'xyz@email.com';
  html.File? _profileImage;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('User Information'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Center(
                child: GestureDetector(
                  onTap: _pickImage,
                  child: CircleAvatar(
                    radius: 50,
                    backgroundImage: _profileImage == null
                        ? AssetImage('assets/images/hey.png') as ImageProvider
                        : NetworkImage(html.Url.createObjectUrl(_profileImage!)) as ImageProvider,
                    child: _profileImage == null
                        ? Icon(Icons.add_a_photo, size: 50)
                        : null,
                  ),
                ),
              ),
              SizedBox(height: 20),
              TextFormField(
                initialValue: _name,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your name';
                  }
                  return null;
                },
                onSaved: (value) {
                  _name = value!;
                },
              ),
              TextFormField(
                initialValue: _email,
                decoration: InputDecoration(labelText: 'Email'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  return null;
                },
                onSaved: (value) {
                  _email = value!;
                },
              ),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveForm,
                child: Text('Update Information'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    final html.File? image = await ImagePickerWeb.getImageAsFile();

    setState(() {
      _profileImage = image;
    });
  }

  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      widget.onUpdate(_name, _email, _profileImage); // Call the callback with updated data
      Navigator.pop(context); // Go back to the previous screen
    }
  }
}
