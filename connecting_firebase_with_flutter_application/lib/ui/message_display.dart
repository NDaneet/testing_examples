import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class MessageDisplay extends StatelessWidget {
  const MessageDisplay({
    super.key,
    required this.text,
    required this.timeStamp,
    this.email,
  });


  final String text;
  final DateTime timeStamp;
  final String? email;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 1, top: 5, right: 1),
      child: Column(
        children: [
          if (email != null) ...[
            Padding(
              padding: const EdgeInsets.only(
                bottom: 2,
              ),
              child: Align(
                alignment: Alignment.topLeft,
                child: Text(
                  email!,
                ),
              ),
            ),
          ],
          Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.grey[400]!,
                  blurRadius: 2.0,
                  //TODO: Modify the offset and see how it works with the systems
                  offset: const Offset(0, 1),
                ),
              ],
              borderRadius: BorderRadius.circular(50.0),
              color: Colors.white,
            ),
            child: Text(
              text,
            )
            /*MaterialButton(
                disabledColor: Colors.black54,
                padding: EdgeInsets.only(left: 10)
                onPressed: null,
                child: Wrap(
                  children: [
                    Row(
                      children: [Text(text)],
                    )
                  ],
                ),
              )*/
            ,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 3),
            child: Align(
              alignment: Alignment.topRight,
              child: Text(
                DateFormat('dd-MM-yyyy, kk:mma').format(timeStamp).toString(),
                style: TextStyle(
                  color: Colors.grey[400],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
