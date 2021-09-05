import 'package:expenses_app/widgets/new_transaction.dart';
import 'package:expenses_app/widgets/transactions_list.dart';
import 'package:flutter/material.dart';
import 'models/transaction.dart';
import 'widgets/chart.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        theme: ThemeData(
            primarySwatch: Colors.purple,
            accentColor: Colors.amber,
            fontFamily: 'Quicksand',
            // ThemeData.light is the default configs for the the themedata
            textTheme: ThemeData.light().textTheme.copyWith(
                headline6: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 18,
                    fontWeight: FontWeight.bold),
                headline5: TextStyle(
                    fontFamily: 'OpenSans',
                    fontSize: 15,
                    fontWeight: FontWeight.bold)),
            textButtonTheme: TextButtonThemeData(
                style: TextButton.styleFrom(
                    primary: Colors.purple,
                    textStyle: TextStyle(
                        fontFamily: 'OpenSans',
                        fontWeight: FontWeight.bold,
                        fontSize: 16))),
            elevatedButtonTheme: ElevatedButtonThemeData(
                style: ElevatedButton.styleFrom(
              primary: Colors.purple,
            )),
            appBarTheme: AppBarTheme(
                textTheme: ThemeData.light().textTheme.copyWith(
                      headline6:
                          TextStyle(fontFamily: 'OpenSans', fontSize: 20),
                    ))),
        home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Transaction> transactionsList = [
    Transaction(id: '1', amount: 23, title: 'Coffe', date: DateTime.now()),
    Transaction(id: '2', amount: 15, title: 'Botatos', date: DateTime.now()),
    Transaction(id: '3', amount: 10, title: 'Biper', date: DateTime.now()),
    Transaction(id: '4', amount: 50, title: 'Dinner', date: DateTime.now()),
    Transaction(
        id: '7',
        amount: 250,
        title: 'internet',
        date: DateTime.now().subtract(Duration(days: 7))),
    Transaction(
        id: '8',
        amount: 14,
        title: 'Bread',
        date: DateTime.now().subtract(Duration(days: 3))),
  ];

  List<Transaction> get _recentTrancsactions {
    return transactionsList
        .where((element) =>
            element.date.isAfter(DateTime.now().subtract(Duration(days: 7))))
        .toList();
  }

  void addTransaction(String title, String amount) {
    Transaction transaction = Transaction(
        id: DateTime.now().toString(),
        amount: double.parse(amount),
        title: title,
        date: DateTime.now());

    setState(() {
      transactionsList.add(transaction);
    });
  }

  void showAddTransactionSection(BuildContext context) {
    showModalBottomSheet(
        context: context,
        builder: (_) {
          return NewTransaction(addTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Expenses Tracer"),
        actions: [
          IconButton(
              onPressed: () => showAddTransactionSection(context),
              icon: Icon(Icons.add))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => showAddTransactionSection(context),
        child: Icon(Icons.add),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Chart(_recentTrancsactions),
            TransactionsList(transactionsList: transactionsList)
          ],
        ),
      ),
    );
  }
}
