import 'dart:io';

// import 'package:exp_app/Method/transaction.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import '../Method/transaction.dart';
// import 'package:intl/intl.dart';
import './transaction_list.dart';
import 'New_transaction.dart';
import '../Method/transaction.dart';
import 'chart.dart';

void main() {
  // WidgetsFlutterBinding
  //     .ensureInitialized(); //this use before SystemChrome.setPreferredOrientations, so it work on all devices otherwise sometime not work on some devices
  // SystemChrome.setPreferredOrientations(
  //     //used to crete application wise or system wise setting
  //     [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Personal Expenses',
      theme: ThemeData(
          // ThemeData.copyWith(
          // colorScheme: ThemeData.colorScheme.secondary()),),
          primarySwatch: Colors.purple,
          accentColor: Colors.pinkAccent,
          //colorScheme: ColorScheme.fromSwatch(primarySwatch: Colors.purple).copyWith(secondary: Colors.pinkAccent),  //accentColor after migrate(use as the place of accentColor)
          errorColor: Colors.red, //default color is also red
          //fontFamily: 'OpenSans',
          textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 18,
                  fontWeight: FontWeight.bold)),
          appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                    headline6: TextStyle(
                        fontFamily: 'QuickSans',
                        fontSize: 20,
                        fontWeight: FontWeight.bold),
                  ))),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  final List<Transaction> _userTransaction = [
    // Transaction(
    //   id: 't1',
    //   title: 'New Shoes',
    //   amount: 45.32,
    //   date: DateTime.now(),
    // ),
    // Transaction(
    //   id: 't2',
    //   title: 'New Shirt',
    //   amount: 65.89,
    //   date: DateTime.now(),
    // ),
  ];
  bool _showChart = false;

  @override
  void initstate() {
    //add a listener
    WidgetsBinding.instance.addObserver(
        this); //whenever lifecycle change go to certain observer and call the didchangeAppLifecycleState method
  }

  //this method will called whenever your lifecycle state change,whenever app reaches a new state in lifecycle
  @override
  void didchangeAppLifecycleState(AppLifecycleState state) {
    print(state);
  }

  @override
  void dispose() {
    //used to clear listener or observer to avoid memory leaks when this state object removed
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  List<Transaction> get _recentTransactions {
    return _userTransaction.where((txt) {
      return txt.date.isAfter(
        DateTime.now().subtract(
          Duration(days: 7),
        ),
      );
    }).toList();
  }

  void _addNewTransaction(
      String txTitle, double txAmount, DateTime chosenDate) {
    final newTex = Transaction(
        title: txTitle,
        amount: txAmount,
        date: chosenDate,
        id: DateTime.now().toString());
    setState(() {
      _userTransaction.add(newTex);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return GestureDetector(
            onTap: () => {},
            child: NewTransaction(_addNewTransaction),
            behavior: HitTestBehavior.opaque,
          );
        });
  }

  void _deleteTransaction(String id) {
    setState(() {
      _userTransaction.removeWhere(
        //manuplating transaction list and deleting transaction with id same as passing id
        (tx) {
          return tx.id == id;
        },
      );
    });
  }

  List<Widget> _buildLandsacpe(double appBarSize, Widget txListWidget) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            'Show Chart',
            style: Theme.of(context).textTheme.titleLarge,
          ),
          Switch.adaptive(
            //  .adaptive help to change according to device like android or ios(we can use switch without .adaptive,
            // switch help to behaive diff acc. to screen or acc. to different condition like landscope mode or portarate mode )
            activeColor: Theme.of(context).accentColor,
            value: _showChart,
            onChanged: (val) {
              setState(() {
                _showChart = val;
              });
            },
          ),
        ],
      ),
      _showChart
          ? Container(
              height: (MediaQuery.of(context).size.height -
                      appBarSize -
                      MediaQuery.of(context).padding.top) *
                  0.7,
              child: Chart(_recentTransactions))
          : txListWidget
    ];
  }

  List<Widget> _buildPortraitmode(double appBarSize, Widget txListWidget) {
    return [
      Container(
          height: (MediaQuery.of(context).size.height -
                  appBarSize -
                  MediaQuery.of(context).padding.top) *
              0.3,
          child: Chart(_recentTransactions)),
      txListWidget
    ];
  }

  @override
  Widget build(BuildContext context) {
    print('build() MyHomePageState');
    final isLandscape =
        MediaQuery.of(context).orientation == Orientation.landscape;
    //Assigning appBar info in variable so that info about appBar can asscess through vaiable
    //bcz sometime need that info somewhere like to calculate accurate height dynamically
    //bcz screen also include appBar height so we have to reduce that with other widget
    final PreferredSizeWidget appBar = Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text('Personal Expenses'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                GestureDetector(
                  child: Icon(CupertinoIcons.add),
                  onTap: () => _startAddNewTransaction(context),
                ),
              ],
            ),
          )
        : AppBar(
            title: Text(
              'Personal Expenses',
              //style: TextStyle(fontFamily: 'QuickSans'),  //indivitual styling a text or title
            ),
            actions: <Widget>[
              IconButton(
                //+ button on appbar
                icon: Icon(Icons.add),
                onPressed: () => _startAddNewTransaction(context),
              ),
            ],
          ) as PreferredSizeWidget;

    final txListWidget = Container(
        //we storing transaction list in variable so that we dont have to write code multiple time
        // when we need transaction list and change multiple place when we have to change someting.
        height: (MediaQuery.of(context).size.height -
                appBar.preferredSize.height -
                MediaQuery.of(context)
                    .padding
                    .top) * //subtractind scafold or padding height that is on the top
            0.7,
        child: TransactionList(_userTransaction, _deleteTransaction));

    //we wraped the singleChildScrollView with safe area so that
    //and this simply means that or make sure that everything is positioned within the boundaries
    //or moved down a bit, moved up a bit so that we respect these reserved areas on the screen
    //(reserved area means notch or curve area on top of screen or having space in bottom of device screen)
    final pageBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
          //mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            //Container(
            // width: double.infinity,
            // child: Card(
            //   color: Colors.blue,
            //   child: Text('chart'),
            //   elevation: 5,
            // ),
            //),
            if (isLandscape)
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.center,
              //   children: <Widget>[
              //     Text(
              //       'Show Chart',
              //       style: Theme.of(context).textTheme.titleLarge,
              //     ),
              //     Switch.adaptive(
              //       //  .adaptive help to change according to device like android or ios(we can use switch without .adaptive,
              //       // switch help to behaive diff acc. to screen or acc. to different condition like landscope mode or portarate mode )
              //       activeColor: Theme.of(context).accentColor,
              //       value: _showChart,
              //       onChanged: (val) {
              //         setState(() {
              //           _showChart = val;
              //         });
              //       },
              //     ),
              //   ],
              // ),

              //try to make more readable by making a diffirent method of same code or work

              //the children of our column, it wants a list of widgets, of single widgets, it does not
              //want a list of list of widgets but that's what we're creating here
              //three dot(...) is so- called sapread operator they tells dart that you want to pull all the element out of that list and merge them as single element
              //So now instead of adding a list to a list, we're adding all the elements of this list as single items
              // next to each other in this list,
              // we're flattening the list so to say. Instead of creating a nested list, we pull out the items and add
              // them as normal items to the outer list.

              ..._buildLandsacpe(appBar.preferredSize.height, txListWidget),
            if (!isLandscape)
              // Container(
              //     height: (MediaQuery.of(context).size.height -
              //             appBar.preferredSize.height -
              //             MediaQuery.of(context).padding.top) *
              //         0.3,
              //     child: Chart(_recentTransactions)),

              ..._buildPortraitmode(appBar.preferredSize.height, txListWidget),
            //if (!isLandscape) txListWidget,
            // if (isLandscape)
            //   _showChart
            //       ? Container(
            //           height: (MediaQuery.of(context).size.height -
            //                   appBar.preferredSize.height -
            //                   MediaQuery.of(context).padding.top) *
            //               0.7,
            //           child: Chart(_recentTransactions))
            //       : txListWidget
          ],
        ),
      ),
    );
    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: pageBody,
            navigationBar: appBar as ObstructingPreferredSizeWidget,
          )
        : Scaffold(
            appBar: appBar,
            body: pageBody,
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    hoverColor: Colors.blueAccent,
                    //backgroundColor: Colors.black,
                    child: Icon(Icons.add),
                    onPressed: () => _startAddNewTransaction(context),
                  ),
          );
  }
}

// Working with the "textScaleFactor"
// In this course, I mostly focus on the device sizes (height and width) when it comes to working with the MediaQuery class.

// As mentioned, it offers way more than that of course. On particularly interesting property is the textScaleFactor property:

// final curScaleFactor = MediaQuery.of(context).textScaleFactor;
// textScaleFactor tells you by how much text output in the app should be scaled. Users can change this in their mobile phone / device settings.

// Depending on your app, you might want to consider using this piece of information when setting font sizes.

// Consider this example:

// Text('Always the same size!', style: TextStyle(fontSize: 20));
// This text ALWAYS has a size of 20 device pixels, no matter what the user changed in his / her device settings.

// Text('This changes!', style: TextStyle(fontSize: 20 * curScaleFactor));
// This text on the other hand also has a size of 20 if the user didn't change anything in the settings
//(because textScaleFactor by default is 1). But if changes were made, the font size of this text respects the user settings.
