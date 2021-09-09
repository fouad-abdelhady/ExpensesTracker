import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChartBar extends StatelessWidget {
  String _dayLable;
  double _dayTotalExpenses;
  double _dayExpensesPercentage;

  ChartBar(this._dayLable, this._dayTotalExpenses, this._dayExpensesPercentage);

  @override
  Widget build(BuildContext context) {
    Color barColor =
        DateFormat.E().format(DateTime.now()).toString() != this._dayLable
            ? Theme.of(context).primaryColor
            : Theme.of(context).accentColor;
    return Column(
      children: [
        SizedBox(
          height: 10,
        ),
        Container(
            height: 15,
            child: FittedBox(
                child: Text('${_dayTotalExpenses.toStringAsFixed(1)} \$'))),
        SizedBox(
          height: 10,
        ),
        Container(
          height: 100,
          width: 10,
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey, width: 1.0),
                    color: Color.fromRGBO(220, 220, 220, 1),
                    borderRadius: BorderRadius.circular(10)),
              ),
              FractionallySizedBox(
                heightFactor: _dayExpensesPercentage,
                child: Container(
                  decoration: BoxDecoration(
                      color: barColor, borderRadius: BorderRadius.circular(10)),
                ),
              )
            ],
          ),
        ),
        SizedBox(
          height: 10,
        ),
        Text(_dayLable),
        SizedBox(
          height: 10,
        )
      ],
    );
  }
}
