import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTransaction;

  NewTransaction(this.addTransaction);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime selectedDate = DateTime.now();

  void _submitTransaction() {
    final amount = double.parse(amountController.text);
    final title = titleController.text;

    if (amount <= 0 || title.isEmpty) return;

    widget.addTransaction(
        titleController.text, amountController.text, selectedDate);
    Navigator.of(context).pop();
  }

  void getDate() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime.now().subtract(Duration(days: 15)),
            lastDate: DateTime.now())
        .then((newDate) {
      if (newDate == null) return;
      setState(() {
        selectedDate = newDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(10),
      elevation: 6,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: titleController,
              keyboardType: TextInputType.text,
              onSubmitted: (_) => _submitTransaction(),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
              keyboardType: TextInputType.number,
              onSubmitted: (_) => _submitTransaction(),
            ),
            Container(
              height: 80,
              child: Row(
                children: [
                  Expanded(
                      child: Text(
                    DateFormat.yMMMd().format(selectedDate),
                    style: Theme.of(context).textTheme.headline5,
                  )),
                  TextButton(onPressed: getDate, child: Text('Select Date'))
                ],
              ),
            ),
            ElevatedButton(
              onPressed: () => _submitTransaction(),
              child: Text('Add Expenses'),
            )
          ],
        ),
      ),
    );
  }
}
