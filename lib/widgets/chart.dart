import 'package:expenses_app/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../widgets/chart_bar.dart';

class Chart extends StatelessWidget {
  List<Transaction> _recentTransactions;
  Chart(this._recentTransactions);

  var totalTransaction = 0.0;
  List<Map<String, Object>> get getPerdayTransactions {
    return List.generate(7, (index) {
      final day = DateTime.now().subtract(Duration(days: index));
      var sum = 0.0;
      for (Transaction t in _recentTransactions) {
        if (t.date.day == day.day &&
            t.date.month == day.month &&
            t.date.year == day.year) {
          sum += t.amount;
          totalTransaction += t.amount;
        }
      }
      print("${DateFormat.E().format(day)} : $sum \$");
      return {'Day': DateFormat.E().format(day), 'Amount': sum};
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.all(10),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: getPerdayTransactions.map((daytrnsaction) {
            return Flexible(
              fit: FlexFit.tight,
              child: ChartBar(
                  daytrnsaction['Day'].toString(),
                  daytrnsaction['Amount'] as double,
                  totalTransaction == 0.0
                      ? 0
                      : ((daytrnsaction['Amount'] as double) /
                          totalTransaction)),
            );
          }).toList(),
        ),
      ),
    );
  }
}
