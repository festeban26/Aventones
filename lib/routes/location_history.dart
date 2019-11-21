import 'package:aventones/res/company_colors.dart';
import 'package:flutter/material.dart';

class LocationHistoryRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CompanyColors.customBlack,
      appBar: AppBar(
        title: const Text("Historial"),
        elevation: 0.0,
      ),
      body: Container(
        child: SafeArea(
          child: Column(
            mainAxisSize:  MainAxisSize.max,
            children: <Widget>[
              Expanded(
                child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                      color: CompanyColors.customLightGray,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(32.0),
                          topRight: Radius.circular(32.0)),
                    ),
                    child: SingleChildScrollView(
                        child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: <Widget>[

                                ]
                            )
                        )
                    )
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
