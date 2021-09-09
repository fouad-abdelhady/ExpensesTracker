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
            primarySwatch: Colors.deepPurple,
            accentColor: Colors.orange,
            errorColor: Colors.orange[900],
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
  List<Transaction> transactionsList = [];

  List<Transaction> get _recentTrancsactions {
    return transactionsList
        .where((element) =>
            element.date.isAfter(DateTime.now().subtract(Duration(days: 7))))
        .toList();
  }

  void addTransaction(String title, String amount, DateTime date) {
    Transaction transaction = Transaction(
        id: DateTime.now().toString(),
        amount: double.parse(amount),
        title: title,
        date: date);

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

  void deleteTransaction(int index) {
    setState(() {
      transactionsList.removeAt(index);
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Chart(_recentTrancsactions),
            TransactionsList(
                transactionsList: transactionsList,
                deleteElement: deleteTransaction)
          ],
        ),
      ),
    );
  }
}
