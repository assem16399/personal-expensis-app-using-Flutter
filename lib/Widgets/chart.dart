import 'package:flutter/material.dart';
import 'package:personal_expenses_app/Widgets/chart_bar.dart';
import 'package:personal_expenses_app/model/transaction.dart';
import 'package:intl/intl.dart';

class Chart extends StatelessWidget {
  Chart(this.recentTransaction);
  final List<Transaction> recentTransaction;

  List<Map<String, Object>> get groupedTransactionValue {
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(Duration(days: index));
      double totalSum = 0;
      for (var i = 0; i < recentTransaction.length; i++) {
        if (recentTransaction[i].date.day == weekDay.day &&
            recentTransaction[i].date.month == weekDay.month &&
            recentTransaction[i].date.year == weekDay.year)
          totalSum += recentTransaction[i].amount;
      }
      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum.roundToDouble(),
      };
    }).reversed.toList();
  }

  double get totalSpendingOfTheWeek {
    return groupedTransactionValue.fold(
        0.0, (sum, element) => sum + element['amount']);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: groupedTransactionValue.map((value) {
          return Flexible(
            fit: FlexFit.tight,
            child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: ChartBar(
                  pctOfTotal: totalSpendingOfTheWeek == 0
                      ? 0.0
                      : (value['amount'] as double) / totalSpendingOfTheWeek,
                  amount: value['amount'],
                  label: value['day'],
                )),
          );
        }).toList(),
      ),
    );
  }
}
