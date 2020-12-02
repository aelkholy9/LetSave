import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransactionForm extends StatefulWidget {
  final Function addTransaction;
  NewTransactionForm({this.addTransaction});

  @override
  _NewTransactionFormState createState() => _NewTransactionFormState();
}

class _NewTransactionFormState extends State<NewTransactionForm> {
  void submitTransaction() {
    if (titleController.text.isEmpty ||
        priceController.text.isEmpty ||
        selectedDate == null) {
      Navigator.of(context).pop();
      return;
    }
    widget.addTransaction(
        titleController.text,
        double.parse(priceController.text),
        selectedDate == null ? DateTime.now() : selectedDate);
    Navigator.of(context).pop();
  }

  final titleController = TextEditingController();

  final priceController = TextEditingController();

  DateTime selectedDate;
  void viewDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2019),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate != null) {
        setState(() {
          selectedDate = pickedDate;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 8,
        child: Container(
          padding: EdgeInsets.only(
              top: 10,
              left: 10,
              right: 10,
              bottom: MediaQuery.of(context).viewInsets.bottom + 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(hintText: 'Title'),
                controller: titleController,
              ),
              TextField(
                decoration: InputDecoration(
                  hintText: 'Amount',
                ),
                controller: priceController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                textInputAction: TextInputAction.done,
                onSubmitted: (_) {
                  submitTransaction();
                },
              ),
              Container(
                height: 50,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(selectedDate == null
                          ? 'No date chosen!'
                          : 'Picked date: ${DateFormat.yMd().format(selectedDate)}'),
                    ),
                    FlatButton(
                      onPressed: viewDatePicker,
                      child: Text(
                        'Choose date',
                        style: Theme.of(context).textTheme.button,
                      ),
                    )
                  ],
                ),
              ),
              RaisedButton(
                color: Theme.of(context).primaryColor,
                onPressed: () => submitTransaction(),
                child: Text(
                  'Add Transaction',
                  style: TextStyle(color: Colors.white),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
