import 'dart:math';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_expenses_app/model/transaction.dart';

class TransactionItem extends StatefulWidget {
  final Transaction transaction;
  final Function onPress;
  final Key key;
  TransactionItem({this.key, this.transaction, this.onPress}) : super(key: key);

  @override
  _TransactionItemState createState() => _TransactionItemState();
}

class _TransactionItemState extends State<TransactionItem> {
  Color _bgColor;
  @override
  void initState() {
    const _availableColors = [
      Colors.red,
      Colors.black,
      Colors.purple,
      Colors.blue,
    ];
    _bgColor = _availableColors[Random().nextInt(3)];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5, bottom: 5),
      child: Card(
        elevation: 5,
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: _bgColor,
            radius: 35,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: FittedBox(
                child: Text('\$${widget.transaction.amount}'),
              ),
            ),
          ),
          title: Text(
            widget.transaction.title,
            style: Theme.of(context).textTheme.headline6,
          ),
          subtitle: (Text(
            DateFormat.yMMMd().format(widget.transaction.date).toString(),
          )),
          trailing: MediaQuery.of(context).size.width > 450
              ? TextButton.icon(
                  onPressed: () {
                    widget.onPress(widget.transaction.id);
                  },
                  icon: Icon(Icons.delete),
                  label: const Text(
                    'Delete',
                    style: TextStyle(color: Colors.red),
                  ),
                )
              : IconButton(
                  onPressed: () => widget.onPress(widget.transaction.id),
                  icon: const Icon(Icons.delete),
                ),
        ),
      ),
    );
  }
}
