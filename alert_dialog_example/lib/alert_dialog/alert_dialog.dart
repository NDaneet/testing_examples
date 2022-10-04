import 'package:flutter/material.dart';

class MyAlertDialog extends StatelessWidget {
  const MyAlertDialog({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  TextButton(
      child: const Text("Show Dialog"),
      onPressed: () => _showAlertDialogBuilder(context),
      
    );
  }
}

Future<void> _showAlertDialogBuilder(BuildContext context){
  return showDialog<void>(context: context, builder: (context){
    return const AlertDialog(
      title: Text("My Testing Alert"),
      content: Text("This is the content"),
      backgroundColor: Colors.blueGrey,

    );
  });
}