import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:save_spender/models/user_model.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:flutter_thermometer/label.dart';
import 'package:flutter_thermometer/scale.dart';
import 'package:flutter_thermometer/setpoint.dart';
import 'package:flutter_thermometer/thermometer.dart';
import 'package:flutter_thermometer/thermometer_paint.dart';
import 'package:flutter_thermometer/thermometer_widget.dart';

class ProgressScreen extends StatefulWidget {
  @override
  _ProgressScreenState createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  double maxValue = 10000;
  //bool isPressed = false;
  User user = new User();
  int savings;


  // bool _isallowed1(){
  //   if(savings >= 2500){
    
  //     return false;
  //   }
  //   else{
  //     return true;
  //   }
  // }

  // bool _isButtonDisabled;

  // @override
  // void initState() {
  //   _isButtonDisabled = false;
  // }

  // void _isallowed1() {
  //   setState(() {
  //     _isButtonDisabled = true;
  //     //_counter++;
  //   });
  // }

  
    _openPERXwebpage(BuildContext context) async {
//    final url = 'https://light.microsite.perxtech.io/game/3?token=6bead735994ceb98d99b022293423c05f3358dd659a00a08d0243b4ce8c8b77d';
//    //Fires up PINATA Game
//    final response = await http.get(url);
////    dynamic body = jsonDecode(response.body);
//
//    // If server returns an OK response, parse the JSON.
//    if (response.statusCode == 200) {
//      print(response.body);
//
//    }
//    // If that response was not OK, throw an error.
//    else {
//      // throw Exception('Failed to load post');
//      print('Failed to load post');
//    }
//  }
      const url =
          'https://light.microsite.perxtech.io/game/3?token=6bead735994ceb98d99b022293423c05f3358dd659a00a08d0243b4ce8c8b77d';
      if (await canLaunch(url))
        launch(url);
      else {
        print("Error in launching url");
      }
    }

  @override
  Widget build(BuildContext context) {
      user.demoStart();
//    return Scaffold(
//      body: Center(
//        child: RaisedButton.icon(      //Tharun
//            onPressed: () => _openPERXwebpage(context),
//
//            icon: Icon(
//              Icons.card_giftcard
//            ),
//            label: Text('Random Prize'),
//            color: Colors.green
//        )
//      )
//
//      );

    ScaleTick(300);

    return Scaffold(
        //Tharun
        body: FutureBuilder<int>(
          future: user.savings.getBalance(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.done) {
              savings = snapshot.data;
              return Row(
                children: <Widget>[
                  SizedBox(
                    height: MediaQuery.of(context).size.height,
                    width: 10,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: <Widget>[
                      savings >= 7500 ?
                      RaisedButton.icon(
                        //Tharun
                          onPressed: () => _openPERXwebpage(context),
                          icon: Icon(Icons.card_giftcard),
                          label: Text('Random Prize'),
                          color: Colors.green)
                          :
                      RaisedButton.icon(
                        //Tharun
                          onPressed: () => null,
                          icon: Icon(Icons.card_giftcard),
                          label: Text('No Prize Yet'),
                          color: Colors.grey),
                      SizedBox(
                        height: (MediaQuery.of(context).size.height/11),
                      ),

                      savings >= 10000 ?
                      RaisedButton.icon(
                        //Tharun
                          onPressed: () => _openPERXwebpage(context),
                          icon: Icon(Icons.card_giftcard),
                          label: Text('Random Prize'),
                          color: Colors.green)
                          :
                      RaisedButton.icon(
                        //Tharun
                          onPressed: () => null,
                          icon: Icon(Icons.card_giftcard),
                          label: Text('No Prize Yet'),
                          color: Colors.grey),
                      SizedBox(
                        height: (MediaQuery.of(context).size.height/11),
                      ),

                      savings >= 5000 ?
                      RaisedButton.icon(
                        //Tharun
                          onPressed: () => _openPERXwebpage(context),
                          icon: Icon(Icons.card_giftcard),
                          label: Text('Random Prize'),
                          color: Colors.green):
                      RaisedButton.icon(
                        //Tharun
                          onPressed: () => null,
                          icon: Icon(Icons.card_giftcard),
                          label: Text('No Prize Yet'),
                          color: Colors.grey),
                      SizedBox(
                        height: (MediaQuery.of(context).size.height/11),
                      ),

                      savings >= 2500 ?
                      RaisedButton.icon(
                        //Tharun
                          onPressed: () => _openPERXwebpage(context),
                          icon: Icon(Icons.card_giftcard),
                          label: Text('Random Prize'),
                          color: Colors.green):
                      RaisedButton.icon(
                        //Tharun
                          onPressed: () => null,
                          icon: Icon(Icons.card_giftcard),
                          label: Text('No Prize Yet'),
                          color: Colors.grey)
                    ],
                  ),

                  Expanded(
                    child: Thermometer(
                      value: savings.toDouble(),
                      //Current savings here
                      mercuryColor: Colors.green,
                      minValue: 0,
                      maxValue: maxValue,
                      //Highest target
                      setpoint: (Setpoint(7500,
                          size: 12, color: Colors.blue, side: SetpointSide.right)),
                      // label: ThermometerLabel(
                      //   "Total Savings (\$)",
                      // ),
                      scale: IntervalScaleProvider(2500,
                          thickness: 5.0, fractionDigits: 0, length: 50.0),
                    ),
                  ),
                ],
              );
            } else {
              return Center(
                child: CircularProgressIndicator()
              );
            }
          },
        )
    );
  }
}
