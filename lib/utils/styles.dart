import 'package:flutter/material.dart';

class Styling {

  static const appBarBackgroundColor = Color(0xff009eb3);

  static TextFormField textFormField(TextEditingController controller, String hintText) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
          border: const OutlineInputBorder(borderSide: BorderSide(color: Colors.black26)),
        labelText: hintText
      ),
    );
  }

  static SizedBox columnSpacingWidget() {
    return const SizedBox(height: 10);
  }

  static TextButton textButton(VoidCallback callback, String text) {
    return TextButton(onPressed: callback, child: Text(text));
  }

  static text(String s) {
    return Text(s, style:  const TextStyle(color: Colors.black));
  }

  static textCenter(String s){
    return Text(s, textAlign: TextAlign.center, style: const TextStyle(color: Colors.black));
  }

}