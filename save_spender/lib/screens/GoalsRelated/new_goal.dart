import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewGoal extends StatefulWidget {
  final Function addGoal;

  NewGoal(this.addGoal);

  @override
  _NewGoalState createState() => _NewGoalState();
}

class _NewGoalState extends State<NewGoal> {
  final _goalNameController = TextEditingController();
  final _goalMoneyController = TextEditingController();


  void _submitData() {
    if (_goalMoneyController.text.isEmpty) {
      return;
    }
    final enteredTitle = _goalNameController.text;
    final enteredAmount = double.parse(_goalMoneyController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return;
    }

    widget.addGoal(
      enteredTitle,
      enteredAmount,
    );

    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Goal'),
              controller: _goalNameController,
              onSubmitted: (_) => _submitData(),
              // onChanged: (val) {
              //   titleInput = val;
              // },
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: _goalMoneyController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _submitData(),
              // onChanged: (val) => amountInput = val,
            ),
            
            RaisedButton(
              child: Text('Add Goal'),
              color: Theme.of(context).primaryColor,
              textColor: Theme.of(context).textTheme.button.color,
              onPressed: _submitData,
            ),
          ],
        ),
      ),
    );
  }
}