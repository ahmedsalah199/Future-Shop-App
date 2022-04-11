import 'package:flutter/material.dart';

Widget defaultTextForm({
  required TextEditingController controller,
  required TextInputType keyboardType,
  required String label,
  required IconData prefixIcon,
  IconData? suffixIcon,
  required String? Function (String?) validate,
  Function (String?) ? onChanged,
  Function (String) ? onFieldSubmitted,
  bool obscureText = false ,
  InputBorder border = const OutlineInputBorder() ,
  bool autofocus = false ,
  bool readOnly = false ,
  VoidCallback? suffixPressed ,
}) {
  return TextFormField(
    controller: controller,
    keyboardType: keyboardType,
    maxLines: 1,
    readOnly: readOnly,
    obscureText: obscureText,
    onFieldSubmitted: onFieldSubmitted,
    validator: validate,
    onChanged: onChanged,
    autofocus: autofocus,
    decoration: InputDecoration(
      label: Text(label),
      border: border ,
      prefixIcon: Icon(prefixIcon),
      suffixIcon: suffixIcon == null ? null : IconButton(
        onPressed: suffixPressed,
          icon: Icon(suffixIcon)
      ),
    ),
  );
}

Widget defaultButton({required String text, required VoidCallback function , Color background = Colors.pinkAccent, Color colorText = Colors.white,}) {
  return Container(
    height: 50,
    width: double.infinity,
    decoration:  BoxDecoration(
      color: background ,
      borderRadius: BorderRadius.circular(25),
      border: Border.all(
        color: Colors.black
      )
    ),
    child: TextButton(
      onPressed: function,
      child: Center(child: Text(text, style:  TextStyle(
          fontSize: 20,
          color: colorText,
          fontWeight: FontWeight.bold),
      ),),
    ),
  );
}

 navigatorTo({required Widget screen , required BuildContext context}) {
  return Navigator.of(context).pushReplacement(
      MaterialPageRoute(builder: (_) => screen)) ;
}
