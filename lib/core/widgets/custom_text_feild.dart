import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
   CustomTextField({
    super.key,
    required this.hint,
    this.prefixIcon,
    this.suffixIcon,
    this.onSaved,
  });
  final String hint;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  // void Function(String)? onSaved;
  void Function(String?)? onSaved;
  @override
  Widget build(BuildContext context) {
    return Form(
      child: TextFormField(
        onChanged:onSaved ,
        decoration: InputDecoration(
          suffixIcon: suffixIcon,
          prefixIcon: prefixIcon,
          hintText: hint,
          hintStyle: TextStyle(color: Colors.white),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
          focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white),
          ),
        ),
      ),
    );
  }
}
