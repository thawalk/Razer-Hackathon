import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import '../screens/login_screen.dart';
import '../screens/savings_screen.dart';
import '../screens/progress_screen.dart';
import '../screens/settings_screen.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';


class MainScreen extends StatefulWidget {
  //MainScreen({});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  GlobalKey globalKey = new GlobalKey(debugLabel: 'btm_app_bar');

  String _title = 'Pay';
  int _selectedIndex = 0;


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
   
    final List<Widget> _children = [

      FlatButton(
          onPressed: () => {},
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Pay With QR",
                    style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.w700,
                        color: Colors.green),
                    textAlign: TextAlign.center),
              ])),
      SavingsScreen(),
      ProgressScreen(),
      SettingsScreen(),
    ];

    //PageController pageController = PageController();

    return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.green[800],
              Colors.white,
            ],
          ),
        ),
        child: Scaffold(
            appBar: AppBar(
              elevation: 0.0,
              backgroundColor: Colors.green,
              title: Center(
                child: Text(_title,
                    style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                        color: Colors.white),
                    textAlign: TextAlign.center),
              ),
              automaticallyImplyLeading: false,
              actions: <Widget>[Container()],
            ),
            bottomNavigationBar: BottomNavigationBar(
              key: globalKey,
              unselectedItemColor: Colors.grey,
              type: BottomNavigationBarType.fixed,
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.payment),
                  title: Text('Payments'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.account_balance_wallet),
                  title: Text('Savings'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.trip_origin),
                  title: Text('Progress'),
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  title: Text('Settings'),
                ),
              ],
              currentIndex: _selectedIndex,
              selectedItemColor: Colors.green,
              onTap: _onItemTapped,
            ),
            backgroundColor: Colors.white,
            body: _children[_selectedIndex]));
  }

  void _onItemTapped(int index) {
  setState(() {
      _selectedIndex = index;
      switch (index) {
        case 0:
          {
            _title = 'Pay';
          }
          break;
        case 1:
          {
            _title = 'Savings';
          }
          break;
        case 2:
          {
            _title = 'Progress';
          }
          break;
        case 3:
          {
            _title = 'Settings';
          }
          break;
      }
    });
  }
}
