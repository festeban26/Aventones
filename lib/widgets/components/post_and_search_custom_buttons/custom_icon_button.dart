import 'package:aventones/res/dimensions.dart';
import 'package:flutter/material.dart';

class CustomIconButton extends StatelessWidget {
  final Function onTap;
  final String label;
  final String title;
  final Color iconColor;
  final IconData iconData;

  const CustomIconButton(
      {Key key,
      this.onTap,
      this.label,
      this.title,
      this.iconColor,
      this.iconData})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Text(title,
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: Dimensions.paragraphBodyAndNormalText_TextSize)),
        ),
        SizedBox(height: 4.0),
        Card(
          elevation: Dimensions.Elevation_CardUnselected,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
          child: InkWell(
            borderRadius: BorderRadius.circular(8.0),
            onTap: onTap,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                alignment: Alignment.center,
                child: Row(
                  children: <Widget>[
                    Container(
                      height: 32,
                      width: 32,
                      decoration: BoxDecoration(
                        color: iconColor,
                        borderRadius: BorderRadius.all(Radius.circular(16)),
                      ),
                      child: Icon(iconData, color: Colors.white, size: 20),
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.center,
                        child: Text(
                          label,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: Dimensions.input_TextSize),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}
