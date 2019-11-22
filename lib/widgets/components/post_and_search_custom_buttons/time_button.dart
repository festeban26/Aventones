import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'custom_icon_button.dart';

class TimeButton extends StatefulWidget {
  final Color iconColor;

  TimeButton({Key key, this.iconColor}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _TimeButtonState();
}

class _TimeButtonState extends State<TimeButton> {
  TimeOfDay _selectedTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    Future<Null> _selectTime(BuildContext context) async {
      final TimeOfDay _pickedTime = await showTimePicker(
          context: context,
          initialTime: _selectedTime);
      if (_pickedTime != null && _pickedTime != _selectedTime)
        setState(() {
          _selectedTime = _pickedTime;
        });
    }

    String _formattedTime = _selectedTime.format(context);

    // TODO: implement build
    return CustomIconButton(
      title: "Hora",
      label: _formattedTime,
      iconColor: widget.iconColor,
      iconData: Icons.access_time,
      onTap: () {
        _selectTime(context);
      },
    );
  }
}
