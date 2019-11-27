import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'custom_icon_button.dart';

class NumberOfSeatsButton extends StatefulWidget {
  final Color iconColor;

  NumberOfSeatsButton({Key key, this.iconColor}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _NumberOfSeatsButtonState();
}

class _NumberOfSeatsButtonState extends State<NumberOfSeatsButton> {
  TimeOfDay _selectedTime = TimeOfDay.now();

  @override
  Widget build(BuildContext context) {
    String _formattedTime = _selectedTime.format(context);

    // TODO: implement build
    return CustomIconButton(
      title: "Asientos disponibles",
      label: _formattedTime,
      iconColor: widget.iconColor,
      iconData: Icons.event_seat,
      onTap: () {
        showDialog(
          context: context,
          builder: (_) => FunkyOverlay(),
        );
      },
    );
  }
}

class FunkyOverlay extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => FunkyOverlayState();
}

class FunkyOverlayState extends State<FunkyOverlay>
    with SingleTickerProviderStateMixin {
  AnimationController controller;
  Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    scaleAnimation =
        CurvedAnimation(parent: controller, curve: Curves.ease);

    controller.forward();
    controller.addListener(() => setState(() {}));
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.transparent,
        child: ScaleTransition(
          scale: scaleAnimation,
          child: Container(
            decoration: ShapeDecoration(
                color: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0))),
            child: Padding(
              padding: const EdgeInsets.all(50.0),
              child: Text("Well hello there!"),
            ),
          ),
        ),
      ),
    );
  }
}
