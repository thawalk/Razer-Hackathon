import 'package:flutter/material.dart';
import '../screens/GoalsRelated/goal_list.dart';
import '../models/goal_model.dart';
import '../screens/GoalsRelated/goal_supplement.dart';
import '../screens/GoalsRelated/new_goal.dart';

class SavingsScreen extends StatefulWidget {
  @override
  _SavingsScreenState createState() => _SavingsScreenState();
}

class _SavingsScreenState extends State<SavingsScreen> {
  List<Goal> _goalsList = [];

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
      _goalsList.add(newGoal);
    });
  }

  @override
  Widget build(BuildContext context) {
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
              Text('Total Savings: \$1000',
              style: TextStyle(fontSize: 30),),
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
