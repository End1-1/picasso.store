import 'package:flutter/material.dart';

class Styling {
  static const appBarBackgroundColor = Color(0xff009eb3);

  static TextFormField textFormField(
      TextEditingController controller, String hintText) {
    return TextFormField(
      controller: controller,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black26)),
          labelText: hintText),
    );
  }

  static TextFormField textFormFieldPassword(
      TextEditingController controller, String hintText) {
    return TextFormField(
      obscureText: true,
      controller: controller,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
          border: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.black26)),
          labelText: hintText),
    );
  }

  static SizedBox columnSpacingWidget() {
    return const SizedBox(height: 10);
  }

  static TextButton textButton(VoidCallback callback, String text) {
    return TextButton(onPressed: callback, child: Text(text));
  }

  static text(String s) {
    return Text(s, style: const TextStyle(color: Colors.black));
  }

  static textError(String s) {
    return Text(s, maxLines: 10, textAlign: TextAlign.center, overflow: TextOverflow.clip, style: const TextStyle(color: Colors.red));
  }

  static textCenter(String s) {
    return Text(s,
        maxLines: 10,
        textAlign: TextAlign.center,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(color: Colors.black));
  }
}

class WMCheckbox extends StatefulWidget {
  final String text;
  final Function(bool?) onChange;
  var value = false;

  WMCheckbox(this.text, this.onChange, this.value, {super.key});

  @override
  State<StatefulWidget> createState() => _WMCheckbox();
}

class _WMCheckbox extends State<WMCheckbox> {
  @override
  Widget build(BuildContext context) {
    return Row(children: [
      Checkbox(
          value: widget.value,
          onChanged: (b) {
            setState(() {
              widget.value = b ?? false;
            });
            widget.onChange(b);
          }),
      Styling.text(widget.text)
    ]);
  }
}
