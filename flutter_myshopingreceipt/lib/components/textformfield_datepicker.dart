import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class TextFormFieldDatePicker extends StatefulWidget {
  String title;
  TextEditingController controller;
  String? Function(String?)? validator;
  TextFormFieldDatePicker({
    Key? key,
    required this.title,
    required this.controller,
    this.validator,
  }) : super(key: key);

  @override
  State<TextFormFieldDatePicker> createState() =>
      _TextFormFieldDatePickerState();
}

class _TextFormFieldDatePickerState extends State<TextFormFieldDatePicker> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          this.widget.title,
          style: TextStyle(
            color: Colors.black87,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 6),
        Container(
          padding: EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.all(Radius.circular(8)),
            boxShadow: [
              BoxShadow(
                offset: Offset(0.0, 12.0),
                color: Colors.black.withOpacity(0.2),
                blurRadius: 8,
                spreadRadius: 1,
              ),
            ],
          ),
          child: TextFormField(
            controller: this.widget.controller,
            validator: this.widget.validator,
            readOnly: true,
            decoration: InputDecoration(
              icon: Icon(Icons.date_range_rounded),
              hintText: "Select Date",
              border: InputBorder.none,
            ),
            onTap: () async {
              DateTime? date = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(2000),
                lastDate: DateTime(2050),
              );
              if (date != null) {
                setState(() {
                  this.widget.controller.text =
                      DateFormat('dd-MM-yyyy').format(date);
                });
              }
            },
          ),
        ),
      ],
    );
  }
}
