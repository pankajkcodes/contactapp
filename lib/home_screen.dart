import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  var users = [];

  @override
  void initState() {
    getUserData();
    super.initState();
  }

  Future<void> getUserData() async {
    try {
      http.Response resp = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
      setState(() {
        users = jsonDecode(resp.body);
      });
    } catch (err) {
      log(err.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Contact App'),
        ),
        body: users.isNotEmpty
            ? ListView.builder(
                itemBuilder: (context, index) {
                  return Card(
                    child: ListTile(
                      onTap: () {
                        Navigator.pushNamed(context, '/about',
                            arguments: users[index]);
                      },
                      leading: const Icon(Icons.person),
                      title: Text(users[index]['name']),
                    ),
                    elevation: 2,
                  );
                },
                itemCount: users.length,
              )
            : const Center(
                child: CircularProgressIndicator(),
              ));
  }
}
