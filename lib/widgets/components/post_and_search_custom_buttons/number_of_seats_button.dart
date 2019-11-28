import 'package:aventones/res/company_colors.dart';
import 'package:aventones/res/dimensions.dart';
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
  int _selectedNumberOfAvailableSeats = 1;

  @override
  Widget build(BuildContext context) {
    return CustomIconButton(
      title: "Asientos disponibles",
      label: _selectedNumberOfAvailableSeats.toString(),
      iconColor: widget.iconColor,
      iconData: Icons.event_seat,
      onTap: () {
        showDialog(
          context: context,
          builder: (_) => SelectNumberOfSeatsDialog(
            onValueSelected: (int value){
              setState(() {
                _selectedNumberOfAvailableSeats = value;
              });
            },
          ),
        );
      },
    );
  }
}

class SelectNumberOfSeatsDialog extends StatefulWidget {
  SelectNumberOfSeatsDialog({this.onValueSelected});

  final _DialogCallback onValueSelected;

  @override
  State<StatefulWidget> createState() =>
      SelectNumberOfSeatsDialogState(onValueSelect: onValueSelected);
}

typedef _DialogCallback = void Function(int selectedValue);

class SelectNumberOfSeatsDialogState extends State<SelectNumberOfSeatsDialog>
    with SingleTickerProviderStateMixin {
  SelectNumberOfSeatsDialogState({this.onValueSelect});

  final _DialogCallback onValueSelect;

  AnimationController controller;
  Animation<double> scaleAnimation;

  @override
  void initState() {
    super.initState();

    controller =
        AnimationController(vsync: this, duration: Duration(milliseconds: 300));
    scaleAnimation = CurvedAnimation(parent: controller, curve: Curves.ease);

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
                      borderRadius: BorderRadius.circular(8.0))),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text("¿Cuántos asientos disponibles tienes?",
                        style: TextStyle(
                            fontSize: Dimensions.modalText_TextSize,
                            fontWeight: FontWeight.bold)),
                    SizedBox(height: 8.0),
                    Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Container(
                          color: CompanyColors.customLightGray,
                          child: FlatButton(
                            child: Text("1"),
                            onPressed: () {
                              onValueSelect(1);
                              Navigator.pop(context, 1);
                            },
                          ),
                        ),
                        SizedBox(width: 8.0),
                        Container(
                          color: CompanyColors.customLightGray,
                          child: FlatButton(
                            child: Text("2"),
                            onPressed: () {
                              onValueSelect(2);
                              Navigator.pop(context, 2);
                            },
                          ),
                        ),
                        SizedBox(width: 8.0),
                        Container(
                          color: CompanyColors.customLightGray,
                          child: FlatButton(
                            child: Text("3"),
                            onPressed: () {
                              Navigator.pop(context, 3);
                              onValueSelect(3);
                            },
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
