import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'custom_icon_button.dart';

class DateButton extends StatefulWidget {
  final Color iconColor;

  DateButton({Key key, this.iconColor}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _DateButtonState();
}

class _DateButtonState extends State<DateButton> {
  DateTime _selectedDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    Future<Null> _selectDate(BuildContext context) async {
      final DateTime _pickedDate = await showDatePicker(
          context: context,
          initialDate: _selectedDate,
          firstDate: DateTime.now().add(Duration(days: -1)),
          // Up to 30 days in the future
          lastDate: DateTime.now().add(Duration(days: 30)),
          locale: Locale('es'),
      );
      if (_pickedDate != null && _pickedDate != _selectedDate)
        setState(() {
          _selectedDate = _pickedDate;
        });
    }

    String _unformattedWeekday = DateFormat.EEEE('es').format(_selectedDate);
    String _formattedWeekday = _unformattedWeekday[0].toUpperCase() +
        _unformattedWeekday.substring(1, 3);

    String _day = DateFormat.d('es').format(_selectedDate);

    String _unformattedMonth = DateFormat.MMM('es').format(_selectedDate);
    String _formattedMonth =
        _unformattedMonth[0].toUpperCase() + _unformattedMonth.substring(1, 3);

    String _formattedDate =
        _formattedWeekday + ', ' + _day + ' ' + _formattedMonth;

    // TODO: implement build
    return CustomIconButton(
      title: "Fecha",
      label: _formattedDate,
      iconColor: widget.iconColor,
      iconData: Icons.today,
      onTap: () {
        _selectDate(context);
      },
    );
  }
}
