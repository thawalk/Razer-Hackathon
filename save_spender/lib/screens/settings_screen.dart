import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'login_screen.dart';

class SettingsScreen extends StatefulWidget {
  @override
  _SettingsScreenState createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: Padding(
        padding: const EdgeInsets.all(8.0),

        child: FloatingActionButton.extended(
          onPressed: () {
            // Sign out, to LoginScreen()
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context) => LoginScreen()), (r) => false);
          },
          label: Text('SIGN OUT',
            style: TextStyle(color: Colors.black87),),
          icon: Icon(Icons.exit_to_app, color: Colors.black87,),
          backgroundColor: Colors.grey[200],
        ),
      )  ,
    );
  }



}