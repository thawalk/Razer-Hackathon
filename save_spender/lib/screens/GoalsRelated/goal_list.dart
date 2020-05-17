import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/goal_model.dart';

class GoalsList extends StatelessWidget {
  Goal goals;
  //final Function deleteTx;
  //final Function showEditModal;

  GoalsList(this.goals); //this.deleteTx, this.showEditModal);

@override
Widget build(BuildContext context) {
  return Container(
    height: MediaQuery.of(context).size.height,
    child: goals == null
        ? Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(
                'No goals added yet',
                style: TextStyle(
                    fontSize: 20, color: Theme.of(context).primaryColor),
              ),
             
            ],
          )
        :
                   Card(
                      elevation: 5,
                      margin: EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 5,
                      ),
                      child:
                          // ListTile(
                          // leading:
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              Text(goals.goalName,
                              style: TextStyle(fontSize: 30),),
                              Text('${goals.goalMoney}',
                              style: TextStyle(fontSize: 30)),
                            ],  
                          )




                    )
      



  );




}
}