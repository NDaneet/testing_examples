import 'package:flutter/material.dart';

class CustomPopUpMenuItem<T> extends PopupMenuEntry<T> {
  const CustomPopUpMenuItem(
      {super.key, required this.value, required this.text, this.callback});

  final T value;
  final String text;
  final Function()? callback;

  @override
  State<CustomPopUpMenuItem<T>> createState() =>
      _CustomDropdownMenuItemState<T>();

//check
  @override
  double get height => 20.0;

  @override
  bool represents(T? value) => this.value == value;
}

class _CustomDropdownMenuItemState<T> extends State<CustomPopUpMenuItem<T>> {
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(minWidth: 130),
      child: InkWell(
        onTap: () => Navigator.of(context).pop<T>(widget.value),
        child: Container(
          constraints: const BoxConstraints(
            minWidth: 30.0,
          ),
          child: Padding(
            padding: const EdgeInsets.all(7.0),
            child: ListTile(
              title: Text(
                widget.text,
                style: TextStyle(
                  fontSize: 15.0,
                  color: Colors.grey[600],
                ),
              ),
              trailing: GestureDetector(
                onTap: () {
                  if (widget.callback != null) {
                    widget.callback!();
                  }
                },
                child: const Icon(
                  Icons.cancel_outlined,
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
