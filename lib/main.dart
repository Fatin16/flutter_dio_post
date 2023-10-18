import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: DioPost(),
    );
  }
}

class User {
  final int id;
  final String name;
  final String email;

  User({required this.id, required this.name, required this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
    );
  }
}

class DioPost extends StatefulWidget {
  @override
  _DioPostState createState() => _DioPostState();
}

class _DioPostState extends State<DioPost>{
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  void addUser() async {
    String name = nameController.text;
    String email = emailController.text;

    if (name.isEmpty || email.isEmpty) return;

    // to send data to server
    try {
      Response response = await Dio().post('https://jsonplaceholder.typicode.com/users',
        data: {'name': name, 'email': email},
      );

      User newUser = User.fromJson(response.data);

      print('New user added with ID: ${newUser.id}');

      // Clear the text fields after successful submission
      nameController.clear();
      emailController.clear();
    } catch (e) {
      print('Error adding user: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Dio POST HTTP Testing')),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: addUser,
              child: Text('Add User'),
            ),
          ],
        ),
      ),
    );
  }
}

