import 'package:aventones/res/company_colors.dart';
import 'package:flutter/material.dart';

class SecondRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Second Route"),
      ),
      body: Center(
        child: RaisedButton(
          onPressed: () {
            // Navigate back to first route when tapped.
          },
          child: Text('Go back!'),
        ),
      ),
    );
  }
}

class TestRoute extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CompanyColors.customBlack,
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          AppBar(title: Text("Test Route"), elevation: 0.0),
          Expanded(
            child: Container(
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(
                    color: CompanyColors.customLightGray,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(32),
                        topRight: Radius.circular(32)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black,
                        blurRadius: 12.0,
                        spreadRadius: 8.0,
                      )
                    ])),
          ),
        ],
      ),
    );
  }
}
