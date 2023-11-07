import 'package:exp_app/Method/transaction.dart';
import 'package:exp_app/allWidget/chart_bar.dart';
import 'package:flutter/material.dart';
// import 'transaction_list.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;
  Chart(this.recentTransactions);

  List<Map<String, Object>> get groupofTransaction {
    //Using for dynamically creating a day bar
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );
      var totalsum = 0.0;

      for (var i = 0; i < recentTransactions.length; i++) {
        if (recentTransactions[i].date.day == weekDay.day &&
            recentTransactions[i].date.month == weekDay.month &&
            recentTransactions[i].date.year == weekDay.year) {
          totalsum += recentTransactions[i].amount;
        }
      }
      return {
        'day': DateFormat.E().format(weekDay).substring(0,
            1), 
        'amount': totalsum
      }; 
    } 
        ).reversed.toList();
  }

  double get totalSpending {
    return groupofTransaction.fold(0.0, (sum, item) {
      return sum + (item['amount'] as double);
    });
  }

  @override
  Widget build(BuildContext context) {
        print('build() chart');
    return Card(
          elevation: 6,
          margin: EdgeInsets.all(20),
          child: Container(
            padding: EdgeInsets.all(10),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: groupofTransaction.map((data) {
                return Flexible(
                  fit: FlexFit.tight,
                  child: ChartBar(
                      data['day'].toString(),
                      (data['amount'] as double),
                      totalSpending == 0.0
                          ? 0.0
                          : (data['amount'] as double) / totalSpending),
                );
              }).toList(),
            )
          ),
    );
  }
}
