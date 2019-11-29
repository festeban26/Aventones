import 'package:aventones/helpers/currency_input_formatter.dart';
import 'package:aventones/res/company_colors.dart';
import 'package:aventones/res/dimensions.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class PriceButton extends StatefulWidget {
  final Color iconColor;

  PriceButton({Key key, this.iconColor}) : super(key: key);

  @override
  State<StatefulWidget> createState() => _PriceButtonState();
}

class _PriceButtonState extends State<PriceButton> {
  double _selectedPricePerSeat = 4.00;
  final FocusNode _focusNode = FocusNode();
  TextEditingController _textEditingController;

  getFormattedCurrencyString(double value) {
    final _formatter =
        NumberFormat.currency(locale: 'en_US', decimalDigits: 2, name: '');
    return _formatter.format(value);
  }

  @override
  void initState() {
    _textEditingController =
        TextEditingController(text: getFormattedCurrencyString(_selectedPricePerSeat));

    _focusNode.addListener(() {
      if (_focusNode.hasFocus) _textEditingController.clear();
      if (!_focusNode.hasFocus) {
        double value = double.parse(_textEditingController.text);
        _selectedPricePerSeat = value;
        _textEditingController.text = getFormattedCurrencyString(value);
      }
    });

    super.initState();
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Text("Precio por asiento",
              style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: Dimensions.paragraphBodyAndNormalText_TextSize)),
        ),
        SizedBox(height: 4.0),
        Card(
            elevation: Dimensions.Elevation_CardUnselected,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.0)),
            child: InkWell(
                borderRadius: BorderRadius.circular(8.0),
                onTap: () {},
                child: Container(
                  alignment: Alignment.center,
                  child: Row(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Container(
                          height: 32,
                          width: 32,
                          decoration: BoxDecoration(
                              color: CompanyColors.customBlack,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(16))),
                          child: Icon(Icons.attach_money,
                              color: Colors.white, size: 20),
                        ),
                      ),
                      Expanded(
                          child: Center(
                              child: TextFormField(
                                  textAlign: TextAlign.center,
                                  decoration:
                                      InputDecoration(border: InputBorder.none),
                                  keyboardType: TextInputType.numberWithOptions(
                                      decimal: true),
                                  inputFormatters: [
                                    CurrencyValidatorInputFormatter(
                                        editingValidator:
                                            DecimalNumberEditingRegexValidator())
                                  ],
                                  focusNode: _focusNode,
                                  controller: _textEditingController))),
                    ],
                  ),
                )))
      ],
    );
  }
}

class DecimalNumberEditingRegexValidator extends RegexValidator {
  DecimalNumberEditingRegexValidator()
      : super(regexSource: "^\$|^(0|([1-9][0-9]{0,1}))(\\.[0-9]{0,2})?\$");
}

class DecimalNumberSubmitValidator implements StringValidator {
  @override
  bool isValid(String value) {
    try {
      final number = double.parse(value);
      return number > 0.0;
    } catch (e) {
      return false;
    }
  }
}
