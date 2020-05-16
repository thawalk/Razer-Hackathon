import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../models/goal_model.dart';

class GoalsList extends StatelessWidget {
  List<Goal> goals = [];
  //final Function deleteTx;
  //final Function showEditModal;

  GoalsList(this.goals); //this.deleteTx, this.showEditModal);

@override
Widget build(BuildContext context) {
  return SingleChildScrollView(
    child: Container(
      height: MediaQuery.of(context).size.height,
      child: goals.isEmpty
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
          : ListView.builder(
                    itemBuilder: (ctx, index) {
                      return Card(
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
                                Text(goals[index].goalName),
                                Text('${goals[index].goalMoney}'),
                              ],  
                            )




                      );
                    },
                    itemCount: goals.length,
                  ),



    )
  );




}
}