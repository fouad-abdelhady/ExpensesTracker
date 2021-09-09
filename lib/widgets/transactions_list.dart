import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class TransactionsList extends StatelessWidget {
  final List<Transaction> transactionsList;
  Function deleteElement;
  TransactionsList(
      {required this.transactionsList, required this.deleteElement});

  get noTransactionsImage =>
      Image.asset('assets/images/searching-error.png', fit: BoxFit.cover);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 400,
      child: transactionsList.isEmpty
          ? noTransactionsImage
          : ListView.builder(
              itemBuilder: (context, index) {
                return Card(
                  elevation: 1,
                  child: ListTile(
                    leading: CircleAvatar(
                      child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: FittedBox(
                            child: Text(
                                '\$ ${transactionsList[index].amount.toStringAsFixed(1)} ')),
                      ),
                      radius: 40,
                    ),
                    title: Text(
                      transactionsList[index].title,
                      style: Theme.of(context).textTheme.headline6,
                    ),
                    subtitle: (Text(DateFormat.yMMMMEEEEd()
                        .format(transactionsList[index].date))),
                    trailing: IconButton(
                      icon: Icon(
                        Icons.delete_rounded,
                        color: Theme.of(context).errorColor,
                        size: 35,
                      ),
                      onPressed: () {
                        deleteElement(index);
                      },
                    ),
                  ),
                );
              },
              itemCount: transactionsList.length,
            ),
    );
  }
}
/**
 * 
 * Card(
                  child: Row(
                    children: [
                      Container(
                        margin:
                            EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                        padding: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            border:
                                Border.all(width: 1, color: Colors.black87)),
                        child: Text(
                          '\$ ${transactionsList[index].amount.toStringAsFixed(2)}',
                          style: TextStyle(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            transactionsList[index].title,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          Text(
                            DateFormat.yMMMMEEEEd()
                                .format(transactionsList[index].date),
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.grey,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                )
*/
