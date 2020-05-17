import 'package:flutter/material.dart';
import 'package:save_spender/models/user_model.dart';
import '../screens/GoalsRelated/goal_list.dart';
import '../models/goal_model.dart';
import '../screens/GoalsRelated/goal_supplement.dart';
import '../screens/GoalsRelated/new_goal.dart';

class SavingsScreen extends StatefulWidget {
  @override
  ///double goalslist;
  //SavingsScreen

  // Goal goal;
  // SavingsScreen(this.goal);
  _SavingsScreenState createState() => _SavingsScreenState();
}

class _SavingsScreenState extends State<SavingsScreen> {
  Goal goalsList;
  User user = new User();

  //  void initState() {
  //           super.initState();
  //           widget.goal = goalsList;
  //      }


  void _startAddNewGoals(BuildContext ctx) {
    showModalBottomSheetApp(
        context: context,
        builder: (builder) {
          return GestureDetector(
            onTap: () {},
            child: NewGoal(_addNewGoals),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  void _addNewGoals(
    String txGoalName,
    double txGoalMoney,
  ) {
    final newGoal = Goal(
      goalName: txGoalName,
      goalMoney: txGoalMoney,
    );

    setState(() {
      goalsList = newGoal;
    });
  }

  @override
  Widget build(BuildContext context) {
    user.demoStart();
    return Scaffold(
        body: SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          SizedBox(
            height: 10,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              FutureBuilder<int>(
                future: user.savings.getBalance(),
                builder: (context, snapshot) {
                  if(snapshot.connectionState == ConnectionState.done)
                    return Text('Total Savings: \$${snapshot.data.toString()}',
                      style: TextStyle(fontSize: 30),);
                  else
                    return CircularProgressIndicator();
                },
              ),
            ],
          ),
          GoalsList(goalsList),
        ],
      ),
    ),
    floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () => _startAddNewGoals(context),
      ),
    );
  }
}


// import 'package:flutter/material.dart';

// void main() => runApp(new MainApp());

// // Mock up of an async backend service
// Future<Map<String, dynamic>> getData() async {
//   return Future.delayed(Duration(seconds: 1), () => {'prop1': 'value1'});
// }

// class PageOne extends StatelessWidget {
//   final Map<String, dynamic> data;

//   PageOne({Key key, this.data}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: RaisedButton(
//         child: const Text('update preferences'),
//         onPressed: () {
//           data['prop2'] = 'value2';
//         },
//       ),
//     );
//   }
// }

// class PageTwo extends StatelessWidget {

//   final Map<String, dynamic> data;

//   PageTwo({Key key, this.data}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: RaisedButton(
//         child: const Text('Got It!'),
//         onPressed: () {
//           print("data is now: [$data]");
//         },
//       ),
//     );
//   }
// }

// class MainApp extends StatefulWidget {
//   @override
//   _MainAppState createState() => _MainAppState();
// }

// class _MainAppState extends State<MainApp> {
//   //Map<String, dynamic> Data;
//   Map<String, dynamic> data;

//   /*
//   StartFunc() async {
//     Data = await getData();
//     setState(() {});
//   }
//   */

//   @override
//   void initState() {
//     //StartFunc();
//     super.initState();
//     getData().then((values) {
//       setState(() {
//         data = values;
//       });
//     });
//   }

//   /*
//   PageOne(data:data) is an invalid value for an initializer:
//    there is no way to access this at this point.
//     Initializers are executed before the constructor,
//     but this is only allowed to be accessed after the call
//     to the super constructor.

//   */
//   /*
//   var _pages = [
//     PageOne(data:data),
//     PageTwo(),
//   ];
//   */

//   Widget getPage(int index) {
//     if (index == 0) {
//       return PageOne(data:data);
//     }
//     if (index == 1) {
//       return PageTwo(data:data);
//     }
//     // A fallback, in this case just PageOne
//     return PageOne();
//   }

//   int _currentIndex = 0;

//   onTabTapped(int index) {
//     setState(() {
//       _currentIndex = index;
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     /*
//     return _currentIndex == 2
//         ? PageTwo()
//         : Scaffold(

//     I use a MaterialApp because of material widgets (RaisedButton)
//     It is not mandatory, but it is mainstream in flutter

//      */
//     return MaterialApp(
//         title: 'My App',
//         home: Scaffold(
//           appBar: AppBar(title: Text("My App Bar")),
//           body: getPage(_currentIndex),
//           bottomNavigationBar: BottomNavigationBar(
//             type: BottomNavigationBarType.fixed,
//             items: [
//               BottomNavigationBarItem(
//                   icon: Icon(Icons.first_page), title: Text('')),
//               BottomNavigationBarItem(
//                   icon: Icon(Icons.last_page), title: Text('')),
//             ],
//             onTap: onTabTapped,
//             currentIndex: _currentIndex,
//           ),
//         ));
//   }
// }
