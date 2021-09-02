import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function onPress;

  NewTransaction({this.onPress});

  @override
  _NewTransactionState createState() {
    return _NewTransactionState();
  }
}

class _NewTransactionState extends State<NewTransaction> {
  _NewTransactionState();

  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime _selectedDate;
  void _onSubmit() {
    final title = titleController.text;
    final amount = double.parse(amountController.text);

    if (title.isEmpty || amount <= 0 || _selectedDate == null) {
      return;
    }
    widget.onPress(title, amount, _selectedDate);
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2021),
      lastDate: DateTime.now(),
    ).then((datePicked) {
      if (datePicked == null)
        return;
      else {
        setState(() {
          _selectedDate = datePicked;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        height: 300,
        padding: EdgeInsets.only(top: 10, right: 10, left: 10, bottom: 10),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Title'),
              onSubmitted: (_) => _onSubmit(),
            ),
            TextField(
              keyboardType: TextInputType.numberWithOptions(decimal: true),
              controller: amountController,
              decoration: InputDecoration(labelText: 'Price'),
              onSubmitted: (_) => _onSubmit(),
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Expanded(
                  child: Text(
                    _selectedDate == null
                        ? 'No Date Chosen!'
                        : 'Date Chosen: ${DateFormat.yMd().format(_selectedDate)}',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
                Platform.isIOS
                    ? CupertinoButton(
                        onPressed: _presentDatePicker,
                        child: Text(
                          _selectedDate == null
                              ? 'Choose A Date'
                              : 'Edit The Date',
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      )
                    : TextButton(
                        onPressed: _presentDatePicker,
                        child: Text(
                          _selectedDate == null
                              ? 'Choose A Date'
                              : 'Edit The Date',
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        ),
                      )
              ],
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: ElevatedButton(
                  onPressed: _onSubmit,
                  child: Text(
                    'Add A Transaction',
                    style: TextStyle(
                        color: Theme.of(context).textTheme.button.color,
                        fontWeight: FontWeight.bold),
                  )),
            )
          ],
        ),
      ),
    );
  }
}
