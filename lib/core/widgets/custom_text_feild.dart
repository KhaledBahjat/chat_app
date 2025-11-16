import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  CustomTextField({
    super.key,
    required this.hint,
    this.prefixIcon,
    this.suffixIcon,
    this.onSaved,
    this.obscureText,
    this.keyboardType,
  });
  final String hint;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool? obscureText;
  final TextInputType? keyboardType;
  void Function(String?)? onSaved;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      keyboardType: keyboardType,
      validator: (value) {
        if(value!.isEmpty){
          return 'Field is required';
        }
        return null;
      },
      obscureText: obscureText ?? false,
      onChanged: onSaved,
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
    );
  }
}
