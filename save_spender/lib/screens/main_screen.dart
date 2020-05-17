import 'package:flutter/material.dart';
import 'package:charts_flutter/flutter.dart' as charts;
import 'package:save_spender/models/user_model.dart';
import '../screens/login_screen.dart';
import '../screens/savings_screen.dart';
import '../screens/progress_screen.dart';
import '../screens/settings_screen.dart';
import 'package:intl/intl.dart';
import 'package:flutter/cupertino.dart';
import 'package:gradient_text/gradient_text.dart';
import 'package:flappy_search_bar/flappy_search_bar.dart';
import 'package:qrscan/qrscan.dart' as scanner;
import 'GoalsRelated/goal_supplement.dart';
import 'deposit_related/deposit_pop.dart';
import '../models/goal_model.dart';

class MainScreen extends StatefulWidget {
  //MainScreen({});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  GlobalKey globalKey = new GlobalKey(debugLabel: 'btm_app_bar');

  String _title = 'Pay';
  int _selectedIndex = 0;
  String barcode = '';
  User user = new User();

  TextEditingController customController = TextEditingController();

  createDepositDialog(BuildContext context){
    return showDialog(context: context,builder: (context){
      return AlertDialog(
        title: Text("How much would you like to deposit?"),
        content: TextField(
          controller: customController,
        ),
          actions: <Widget>[
            MaterialButton(
          elevation: 5.0,
           child:Text('Deposit'),
        onPressed: (){
            Navigator.of(context).pop(int.parse(customController.text.toString()));
        },
      )
        ],
      );
    });
  }

  createDepositDialogAfterQR(BuildContext context){
    return showDialog(context: context,builder: (context){
      return AlertDialog(
        title: Text("Would you like to set aside some funds into your savings?"),
        content: TextField(
          controller: customController,
        ),
        actions: <Widget>[
          MaterialButton(
            elevation: 5.0,
            child:Text('Deposit'),
            onPressed: (){
              Navigator.of(context).pop(int.parse(customController.text.toString()));
            },
          )
        ],
      );
    });
  }


  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    user.demoStart();
    final List<Widget> _children = [
      Column(

        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              FutureBuilder<int>(
                  future: user.wallet.getBalance(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.done) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            "Wallet Balance: \$${snapshot.data.toString()}",
                            style: TextStyle(fontSize: 30),
                          ),
                          IconButton(
                            icon: Icon(Icons.account_balance_wallet),
                            tooltip: 'Deposit Money',
                            onPressed: () => _startDepositMoney(context),
                          )
                        ],
                      );
                    } else {
                      return CircularProgressIndicator();
                    }
                  }
              ),
              Container(
                  height: MediaQuery.of(context).size.height/2,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.all(8.0),
                  child: RaisedButton.icon(      //Tharun
                    onPressed:_scan,
                    icon: Icon(
                        Icons.camera,
                      size: 35,

                    ),
                    label: Text('Pay by QR code',style: TextStyle(fontSize: 28)),


                    color: Colors.green,
                  )
              ),
              Container(
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height/5,
                  padding: EdgeInsets.all(8.0),
                  child: RaisedButton.icon(      //Tharun
                    onPressed: (){createDepositDialog(context);},

                    icon: Icon(
                        Icons.attach_money,
                      size: 35,
                    ),
                    label: Text('Deposit',style: TextStyle(fontSize: 28)),

                    color: Colors.green,
                  )

              )
            ],
          )
        ],
      ),
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

  Future _scan() async {
    String barcode = await scanner.scan();
    setState(() => this.barcode = barcode);
    createDepositDialogAfterQR(context);
  }

  Future _scanPhoto() async {
    String barcode = await scanner.scanPhoto();
    setState(() => this.barcode = barcode);
  }

  void _startDepositMoney(BuildContext ctx) {
    showModalBottomSheetApp(
        context: context,
        builder: (builder) {
          return GestureDetector(
            onTap: () {},
            child: DepositPop(_depositMoney),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  void _depositMoney(int amt) async {
    await user.wallet.deposit(amt);
    setState(() {
      user.wallet.getBalance();
    });
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


// import 'dart:async';
// import 'dart:typed_data';

// import 'package:flutter/services.dart';

// /// camera access denied const.
// const CameraAccessDenied = 'PERMISSION_NOT_GRANTED';

// /// method channel.
// const MethodChannel _channel = const MethodChannel('qr_scan');

// /// Scanning Bar Code or QR Code return content
// Future<String> scan() async => await _channel.invokeMethod('scan');

// /// Scanning Photo Bar Code or QR Code return content
// Future<String> scanPhoto() async => await _channel.invokeMethod('scan_photo');

// // Scanning the image of the specified path
// Future<String> scanPath(String path) async {
//   assert(path != null && path.isNotEmpty);
//   return await _channel.invokeMethod('scan_path', {"path": path});
// }

// // Parse to code string with uint8list
// Future<String> scanBytes(Uint8List uint8list) async {
//   assert(uint8list != null && uint8list.isNotEmpty);
//   return await _channel.invokeMethod('scan_bytes', {"bytes": uint8list});
// }

// /// Generating Bar Code Uint8List
// Future<Uint8List> generateBarCode(String code) async {
//   assert(code != null && code.isNotEmpty);
//   return await _channel.invokeMethod('generate_barcode', {"code": code});
// }