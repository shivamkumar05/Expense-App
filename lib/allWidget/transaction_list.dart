import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../allWidget/transaction_item.dart';

import '/Method/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final Function deletetx;

  TransactionList(this.transactions, this.deletetx);
  @override
  Widget build(BuildContext context) {
    print('build() TransactionList');

    //we are now calculateing weight at main.dart, at calling time then no need to calculate here
    // return Container(
    //   // height:
    //   //     450, //ListView have infinite height so we are wraps its height here
    //   height: MediaQuery.of(context).size.height *
    //       0.6, //dynamically calculating height of tree, 0 means 0 % of height and 1 means 100 % of height 0.6 means 60 % of screen
    //  child:
    return transactions.isEmpty
        ? LayoutBuilder(
            builder: (context, constraints) {
              return Column(
                children: <Widget>[
                  Text(
                    'No transactions added yet!',
                    style: Theme.of(context).textTheme.headline6,
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Container(
                    // height: 200,
                    height: constraints.maxHeight * 0.6,
                    child: Image.asset(
                      'assets/image/waiting.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                ],
              );
            },
          )
        : ListView.builder(
            //method one to build
            //itemBuilder: (context, index) {
            //   return Card(
            //     child: Row(
            //       children: <Widget>[
            //         Container(
            //           margin: EdgeInsets.symmetric(
            //             vertical: 10,
            //             horizontal: 15,
            //           ),
            //           decoration: BoxDecoration(
            //             border: Border.all(
            //               color: Theme.of(context).primaryColor,
            //               width: 2,
            //             ),
            //           ),
            //           padding: EdgeInsets.all(10),
            //           child: Text(
            //             //'\$ ' + txt.amount.toString(),
            //             '\$ ${transactions[index].amount.toStringAsFixed(2)}', //string interpolation   //here repleced txt.title with transactions[index] for accesing amount by index bcz there is no transaction mapped
            //             style: TextStyle(
            //               fontWeight: FontWeight.bold,
            //               fontSize: 15,
            //               color: Theme.of(context).primaryColor,
            //             ),
            //           ),
            //         ),
            //         Column(
            //           crossAxisAlignment: CrossAxisAlignment.start,
            //           children: <Widget>[
            //             Text(
            //               transactions[index].title,
            //               // style: TextStyle(
            //               //   fontWeight: FontWeight.w800,
            //               //   fontSize: 10,
            //               //   color: Colors.deepPurpleAccent,
            //               // ),
            //               style: Theme.of(context)
            //                   .textTheme
            //                   .headline6, //using textstyle dife globali in main.dart isted of own define style
            //             ),
            //             Text(
            //               //DateFormat().format(txt.date),
            //               DateFormat.yMMMd().format(transactions[index].date),
            //               // DateFormat('dd/MM/yyyy').format(txt
            //               //     .date), //Dateformat is a class in intl package which helps in formeting dates,language in local and some other things for more go to official docs
            //               style: TextStyle(
            //                 fontWeight: FontWeight.w400,
            //                 fontSize: 10,
            //                 color: Colors.grey,
            //               ),
            //             )
            //           ],
            //         )
            //       ],
            //     ),
            //   );
            //another method to build
            itemBuilder: (context, index) {
              // return Card(
              //   elevation: 5,
              //   margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
              //   child: ListTile(
              //     leading: CircleAvatar(
              //       radius: 30,
              //       child: Padding(
              //         padding: EdgeInsets.all(5.0),
              //         child: FittedBox(
              //           child: Text(
              //               '\$ ${transactions[index].amount.toStringAsFixed(2)}'),
              //         ),
              //       ),
              //     ),
              //     title: Text(
              //       transactions[index].title,
              //       style: Theme.of(context).textTheme.titleLarge,
              //     ),
              //     subtitle: Text(
              //       DateFormat.yMMMd().format(transactions[index].date),
              //     ),
              //     trailing: MediaQuery.of(context).size.width > 360
              //         ? FlatButton.icon(
              //             icon: Icon(Icons.delete),
              //             label: Text('Delete'),
              //             textColor: Theme.of(context).errorColor,
              //             onPressed: () => deletetx(transactions[index].id),
              //           )
              //         : IconButton(
              //             icon: Icon(Icons.delete),
              //             color: Theme.of(context).errorColor,
              //             onPressed: () => deletetx(transactions[index]
              //                 .id), //passing transaction id for delete that transaction
              //           ),
              //   ),
              // );

              return  TransactionItem( transaction:transactions[index],  deletetx:deletetx);
            },
            itemCount:
                transactions.length, // just number of item  not whole list
            //children: transactions.map((txt) {
            // return Card(
            //   child: Row(
            //     children: <Widget>[
            //       Container(
            //         margin: EdgeInsets.symmetric(
            //           vertical: 10,
            //           horizontal: 15,
            //         ),
            //         decoration: BoxDecoration(
            //           border: Border.all(
            //             color: Colors.purple,
            //             width: 2,
            //           ),
            //         ),
            //         padding: EdgeInsets.all(10),
            //         child: Text(
            //           //'\$ ' + txt.amount.toString(),
            //           '\$ ${txt.amount}', //string interpolation
            //           style: TextStyle(
            //             fontWeight: FontWeight.bold,
            //             fontSize: 15,
            //             color: Colors.purple,
            //           ),
            //         ),
            //       ),
            //       Column(
            //         crossAxisAlignment: CrossAxisAlignment.start,
            //         children: <Widget>[
            //           Text(
            //             txt.title,
            //             style: TextStyle(
            //               fontWeight: FontWeight.w800,
            //               fontSize: 10,
            //               color: Colors.deepPurpleAccent,
            //             ),
            //           ),
            //           Text(
            //             //DateFormat().format(txt.date),
            //             DateFormat.yMMMd().format(txt.date),
            //             // DateFormat('dd/MM/yyyy').format(txt
            //             //     .date), //Dateformat is a class in intl package which helps in formeting dates,language in local and some other things for more go to official docs
            //             style: TextStyle(
            //               fontWeight: FontWeight.w400,
            //               fontSize: 10,
            //               color: Colors.grey,
            //             ),
            //           )
            //         ],
            //       )
            //     ],
            //   ),
            // );
            //}).toList(),
            //),
          );
  }
}
