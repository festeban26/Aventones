import 'package:aventones/widgets/components/post_and_search_custom_buttons/custom_icon_button.dart';
import 'package:flutter/material.dart';
import 'package:aventones/res/company_colors.dart';

class PostPreferences extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            Expanded(
              flex: 1,
              child: CustomIconButton(
                title: "Fecha",
                label: "11 Nov, 2019",
                iconColor: CompanyColors.customBlack,
                iconData: Icons.today,
              ),
            ),
            SizedBox(width: 16),
            Expanded(
              flex: 1,
              child: CustomIconButton(
                title: "Hora",
                label: "15:00",
                iconColor: CompanyColors.customBlack,
                iconData: Icons.access_time,
              ),
            )
          ],
        ),
        SizedBox(height: 16),
        Row(
          children: <Widget>[
            Expanded(
                flex: 1,
                child: CustomIconButton(
                  title: "Número de asientos",
                  label: "3",
                  iconColor: CompanyColors.customBlack,
                  iconData: Icons.event_seat,
                )),
            SizedBox(width: 16),
            Expanded(
              flex: 1,
              child: CustomIconButton(
                title: "Precio por asiento",
                label: "5.00",
                iconColor: CompanyColors.customBlack,
                iconData: Icons.attach_money,
              ),
            )
          ],
        )
      ],
    );
  }
}
