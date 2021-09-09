import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChartBar extends StatelessWidget {
  static const _TEXT_HEIGHT_FACTOR = 0.1,
      _BAR_HEIGHT_FACTOR = 0.7,
      _SIZED_BOX_HEIGHT_FACTOR = 0.05;

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
    return LayoutBuilder(builder: (context, constrains) {
      final maxHeight = constrains.maxHeight;
      return Column(
        children: [
          Container(
              height: maxHeight * _TEXT_HEIGHT_FACTOR,
              child: FittedBox(
                  child: Text('${_dayTotalExpenses.toStringAsFixed(1)} \$'))),
          SizedBox(
            height: maxHeight * _SIZED_BOX_HEIGHT_FACTOR,
          ),
          Container(
            height: maxHeight * _BAR_HEIGHT_FACTOR,
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
                        color: barColor,
                        borderRadius: BorderRadius.circular(10)),
                  ),
                )
              ],
            ),
          ),
          SizedBox(
            height: maxHeight * _SIZED_BOX_HEIGHT_FACTOR,
          ),
          SizedBox(
              height: maxHeight * _TEXT_HEIGHT_FACTOR,
              child: FittedBox(child: Text(_dayLable))),
        ],
      );
    });
  }
}
