import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:picassostore/utils/prefs.dart';

class DateFilterDialog extends StatefulWidget {
  DateTime startDate;
  DateTime endDate;
  DateFilterDialog(this.startDate, this.endDate, {super.key});
  @override
  _DateFilterDialogState createState() => _DateFilterDialogState();

  static Future<Map<String, DateTime?>?> showDateFilterDialog(DateTime d1, DateTime d2) async {
    return showDialog<Map<String, DateTime?>>(
      context: prefs.context(),
      builder: (context) => DateFilterDialog(d1, d2),
    );
  }
}

class _DateFilterDialogState extends State<DateFilterDialog> {


  Future<void> _selectDate(BuildContext context, bool isStart) async {
    DateTime initialDate = isStart ? (widget.startDate ?? DateTime.now()) : (widget.endDate ?? DateTime.now());
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      setState(() {
        if (isStart) {
          widget.startDate = pickedDate;
        } else {
          widget.endDate = pickedDate;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(locale().selectRange),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ListTile(
            title: Text(locale().dateStart),
            subtitle: Text( DateFormat('dd.MM.yyyy').format(widget.startDate)),
            onTap: () => _selectDate(context, true),
          ),
          ListTile(
            title: Text(locale().dateEnd),
            subtitle: Text(DateFormat('dd.MM.yyyy').format(widget.endDate)),
            onTap: () => _selectDate(context, false),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(locale().cancel),
        ),
        TextButton(
          onPressed: () => Navigator.pop(context, {'start': widget.startDate, 'end': widget.endDate}),
          child: Text(locale().save),
        ),
      ],
    );
  }
}