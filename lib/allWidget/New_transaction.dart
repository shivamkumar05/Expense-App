import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../allWidget/adaptive_flat_button.dart';

class NewTransaction extends StatefulWidget {
  final Function addtxe;
  NewTransaction(this.addtxe) {
    print('Constructor NewTransaction Widget');
  }

  @override
  State<NewTransaction> createState() {
    print('CreateState NewTransaction Widget');
    return _NewTransactionState();
  }
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime _selectedDate = DateTime.now();

  _NewTransactionState() {
    print('Constructor NewTransaction State');
  }

  @override
  void initState() {
    print('initState()');
    super.initState();
  }

  @override
  void didUpdateWidget(NewTransaction oldWidget) {
    print('didUpdateWidget');
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    print('dispose');
    super.dispose();
  }

  void _submitData() {
    if (amountController.text.isEmpty) {
      //return if try to submit empty form
      return;
    }
    final enteredTitle = titleController.text;
    final enteredAmount =
        double.parse(amountController.text); 

    if (enteredTitle.isEmpty || enteredAmount < 0 || _selectedDate == null) {
      return;
    }
    widget.addtxe(
      
      enteredTitle,
      enteredAmount,
      _selectedDate,
    );
    Navigator.of(context)
        .pop(); 
  }

  void _presentDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now())
        .then(
      (pickedDate) {
        if (pickedDate == null) {
          return;
        }
        setState(() {});
        _selectedDate = pickedDate;
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            right: 10,
            left: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                //onChanged: (value) => titleInput = value,
                controller: titleController,
                onSubmitted: (_) => _submitData(),
              ), //used for user input
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                //onChanged: (val) => amountInput = val,
                controller: amountController,
                keyboardType: TextInputType
                    .number, //only number keypad will be on option on mobile device
                onSubmitted: (value) =>
                    _submitData(), //isted of value any thing can be written it is just bcz have to accept it but dont wana use it any name will be fine
              ),
              Container(
                height: 70,
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: Text(_selectedDate == null
                          ? 'No Date Chosen'
                          : DateFormat.yMd().format(_selectedDate)),
                    ),
                    // Platform.isIOS
                    //     ? CupertinoButton(
                    //         child: Text(
                    //           'Choose Date',
                    //           style: TextStyle(fontWeight: FontWeight.bold),
                    //         ),
                    //         onPressed: _presentDatePicker,
                    //       )
                    //     : FlatButton(
                    //         textColor: Theme.of(context).primaryColor,
                    //         child: Text(
                    //           'Choose Date',
                    //           style: TextStyle(fontWeight: FontWeight.bold),
                    //         ),
                    //         onPressed: _presentDatePicker),

                    AdaptiveFlatButton('Choose Date', _presentDatePicker),
                  ],
                ),
              ),
              ElevatedButton(
                child: const Text('Add Transaction'),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.purple,
                    foregroundColor: Colors.white),
                onPressed: _submitData,

              ),
            ],
          ),
        ),
      ),
    );
  }
}
