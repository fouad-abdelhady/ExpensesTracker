import 'package:expenses_app/widgets/new_transaction.dart';
import 'package:expenses_app/widgets/transactions_list.dart';
import 'package:flutter/material.dart';
import 'models/transaction.dart';
import 'widgets/chart.dart';
//import 'package:flutter/services.dart';

void main() {
  // WidgetsFlutterBinding.ensureInitialized();
  // SystemChrome.setPreferredOrientations(
  //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
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
  bool showChart = false;
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
    final mediaQuery = MediaQuery.of(context);
    double chartHeight = 0.32;
    double transactionsHeight = 0.68;
    final isLandscape = mediaQuery.orientation == Orientation.landscape;
    final appBar = AppBar(
      title: Text("Expenses Tracer"),
      actions: [
        IconButton(
            onPressed: () => showAddTransactionSection(context),
            icon: Icon(Icons.add))
      ],
    );
    final avaliableScreenHeight = mediaQuery.size.height -
        appBar.preferredSize.height -
        mediaQuery.padding.top;

    var screenWidth = mediaQuery.size.width;
    Widget _chart(double height) {
      return Container(
          height: avaliableScreenHeight * height,
          child: Chart(_recentTrancsactions));
    }

    Widget _transactionsList(double height) {
      return Container(
        height: avaliableScreenHeight * height,
        child: TransactionsList(
            transactionsList: transactionsList,
            deleteElement: deleteTransaction),
      );
    }

    return Scaffold(
      appBar: appBar,
      floatingActionButton: FloatingActionButton(
        onPressed: () => showAddTransactionSection(context),
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (isLandscape)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Show Chart'),
                Switch(
                    value: showChart,
                    onChanged: (value) {
                      setState(() {
                        showChart = value;
                      });
                    }),
              ],
            ),
          if (isLandscape) showChart ? _chart(0.825) : _transactionsList(0.825),
          if (!isLandscape) _chart(chartHeight),
          if (!isLandscape) _transactionsList(transactionsHeight)
        ],
      ),
    );
  }
}
