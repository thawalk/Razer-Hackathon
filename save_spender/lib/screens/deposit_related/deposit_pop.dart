import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DepositPop extends StatefulWidget {
  final Function deposit;
  DepositPop(this.deposit);

  @override
  _NewDepositPopState createState() => _NewDepositPopState();
}

class _NewDepositPopState extends State<DepositPop> {
  final _depositAmtController = TextEditingController();

  void _submitData() {
    if (_depositAmtController.text.isEmpty) {
      return;
    }
    final enteredAmount = int.parse(_depositAmtController.text);
    if (enteredAmount <= 0) {
      return;
    }
    widget.deposit(enteredAmount);
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
              decoration: InputDecoration(labelText: 'Amount to Wallet'),
              controller: _depositAmtController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _submitData(),
              // onChanged: (val) => amountInput = val,
            ),

            RaisedButton(
              child: Text('Deposit'),
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