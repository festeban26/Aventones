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
    return InkWell(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(left: 4.0),
            child: Text(title,
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: Dimensions.paragraphBodyAndNormalText_TextSize)),
          ),
          SizedBox(height: 8),
          Container(
            alignment: Alignment.center,
            height: 48,
            width: double.infinity,
            decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(8))),
            child: Row(
              children: <Widget>[
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Container(
                    height: 32,
                    width: 32,
                    decoration: BoxDecoration(
                        color: iconColor,
                        borderRadius: BorderRadius.all(Radius.circular(16))),
                    child: Icon(iconData, color: Colors.white, size: 20),
                  ),
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
          )
        ],
      ),
    );
  }
}
