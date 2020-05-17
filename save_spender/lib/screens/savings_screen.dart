import 'package:flutter/material.dart';
import 'package:save_spender/models/user_model.dart';
import '../screens/GoalsRelated/goal_list.dart';
import '../models/goal_model.dart';
import '../screens/GoalsRelated/goal_supplement.dart';
import '../screens/GoalsRelated/new_goal.dart';

class SavingsScreen extends StatefulWidget {
  @override
  _SavingsScreenState createState() => _SavingsScreenState();
}

class _SavingsScreenState extends State<SavingsScreen> {
  Goal _goalsList;
  User user = new User();

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
      _goalsList = newGoal;
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
          GoalsList(_goalsList),
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
