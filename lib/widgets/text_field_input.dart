import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class TextFieldInput extends StatelessWidget {
  final TextEditingController textEditingController;
  final String hintText;
  final bool isPass;
  final TextInputType textInputType;
  const TextFieldInput({
    Key? key,
    required this.textEditingController,
    required this.hintText,
    required this.textInputType,
    this.isPass = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      decoration: InputDecoration(
          hintText: hintText,
          border: OutlineInputBorder(
              borderSide: Divider.createBorderSide(context))),
      obscureText: isPass,
      keyboardType: textInputType,
      validator: (val) => isPass
          ? (val!.length < 8
              ? 'Password must be longer than 8 characters'
              : null)
          : (val!.isEmpty ? 'Enter a valid email' : null),
    );
  }
}
