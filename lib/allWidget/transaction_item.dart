import '../Method/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TransactionItem extends StatelessWidget {
  final Transaction transaction;
  final Function deletetx;

  const TransactionItem({required this.transaction, required this.deletetx});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 5),
      child: ListTile(
        leading: CircleAvatar(
          radius: 30,
          child: Padding(
            padding: EdgeInsets.all(5.0),
            child: FittedBox(
              child: Text('\$ ${transaction.amount.toStringAsFixed(2)}'),
            ),
          ),
        ),
        title: Text(
          transaction.title,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        subtitle: Text(
          DateFormat.yMMMd().format(transaction.date),
        ),
        trailing: MediaQuery.of(context).size.width > 360
            ? TextButton.icon(
                label: Text('Delete'),
                style: TextButton.styleFrom(
                   // backgroundColor: Colors.purple,
                    foregroundColor: Theme.of(context).colorScheme.error),
                icon: Icon(Icons.delete),
                //textColor: Theme.of(context).errorColor,
                onPressed: () => deletetx(transaction.id),
              )
            : IconButton(
                icon: Icon(Icons.delete),
                color: Theme.of(context).errorColor,
                onPressed: () => deletetx(transaction
                    .id), //passing transaction id for delete that transaction
              ),
      ),
    );
  }
}
