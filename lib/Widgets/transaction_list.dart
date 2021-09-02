import 'package:flutter/material.dart';
import 'package:personal_expenses_app/Widgets/transaction_item.dart';
import 'package:personal_expenses_app/model/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactionsList;
  final Function onPress;
  TransactionList({this.transactionsList, this.onPress});

  @override
  Widget build(BuildContext context) {
    return (transactionsList.isEmpty)
        ? LayoutBuilder(builder: (ctx, constraints) {
            return Column(
              children: [
                Text(
                  'No transactions added yet!',
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                  width: 200,
                  height: constraints.maxHeight * 0.8,
                  child: Image(
                    fit: BoxFit.contain,
                    image: AssetImage('assets/images/waiting.png'),
                  ),
                ),
              ],
            );
          })
        : ListView(
            children: transactionsList
                .map((tx) => TransactionItem(
                      key: ValueKey(tx.id),
                      onPress: onPress,
                      transaction: tx,
                    ))
                .toList(),
          );
  }
}
