import 'package:app_kms/model/dailyRecordWorkorderform.dart';
import 'package:flutter/material.dart';

typedef OnDelete();

class DailyRecordWorkorderForm extends StatefulWidget {
  final DailyRecordWorkorderform dailyRecordWorkorderform;
  final state = _DailyRecordWorkorderFormState();
  final OnDelete onDelete;

  DailyRecordWorkorderForm(
      {Key? key,
      required this.dailyRecordWorkorderform,
      required this.onDelete})
      : super(key: key);

  @override
  State<DailyRecordWorkorderForm> createState() => state;
  // bool isValid() => state.validate();
}

class _DailyRecordWorkorderFormState extends State<DailyRecordWorkorderForm> {
  final form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16),
      child: Material(
        elevation: 1,
        clipBehavior: Clip.antiAlias,
        borderRadius: BorderRadius.circular(8),
        child: Form(
          key: form,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              AppBar(
                leading: Icon(Icons.verified_user),
                elevation: 0,
                title: Text('User Details'),
                backgroundColor: Theme.of(context).accentColor,
                centerTitle: true,
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: widget.onDelete,
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, right: 16, top: 16),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Full Name',
                    hintText: 'Enter your full name',
                    icon: Icon(Icons.person),
                    isDense: true,
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(left: 16, right: 16, bottom: 24),
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: 'Email Address',
                    hintText: 'Enter your email',
                    icon: Icon(Icons.email),
                    isDense: true,
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  ///form validator
  // bool validate() {
  //   var valid = form.currentState.validate();
  //   if (valid) form.currentState.save();
  //   return valid;
  // }
}
