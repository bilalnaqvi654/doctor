import 'package:flutter/material.dart';

class textField extends StatelessWidget {
  Function onChangedValue;
  String title;
  String placeHolder;
  Icon icon;
  Icon SuffixIcon;
  TextInputType keyboradtype;
  int maxLines;
  bool obsecure;
  textField(
      {this.onChangedValue,
      this.title,
      this.placeHolder,
      this.icon,
      this.SuffixIcon,
      this.obsecure,
      this.keyboradtype,
      this.maxLines});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        maxLines: maxLines,
        keyboardType: keyboradtype,
        obscureText: obsecure,
        onChanged: onChangedValue,
        decoration: new InputDecoration(
            border: new OutlineInputBorder(
                borderSide: new BorderSide(color: Colors.black)),
            hintText: placeHolder,
            labelText: title,
            prefixIcon: icon,
            suffixStyle: const TextStyle(color: Colors.lightGreen)),
      ),
    );
  }
}
