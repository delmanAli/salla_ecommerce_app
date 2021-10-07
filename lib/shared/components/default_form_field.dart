import 'package:flutter/material.dart';

Widget defaultFormField({
  @required TextEditingController controller,
  @required TextInputType type,
  Function onSubmit,
  Function onChange,
  Function onTap,
  bool isPassword = false,
  @required String validate,
  @required String label,
  @required IconData prefix,
  IconData suffix,
  Function suffixPressed,
  bool isClickable = true,
}) =>
    TextFormField(
      controller: controller,
      keyboardType: type,
      obscureText: isPassword,
      enabled: isClickable,
      onFieldSubmitted: onSubmit,
      onChanged: onChange,
      onTap: onTap,
      validator: (String val) {
        if (val.isEmpty) {
          return validate;
        }
        return null;
      },
      decoration: InputDecoration(
        labelText: label,
        prefixIcon: Icon(
          prefix,
        ),
        suffixIcon: suffix != null
            ? IconButton(
                onPressed: suffixPressed,
                icon: Icon(
                  suffix,
                ),
              )
            : null,
        border: OutlineInputBorder(),
      ),
    );

// Widget defaultFormField({
//   @required TextEditingController controller,
//   @required TextInputType type,
//   @required String label,
//   String validate,
//   @required IconData icon,
//   @required Function onChange,
// }) =>
//     TextFormField(
//       controller: controller,
//       keyboardType: type,
//       onChanged: onChange,
//       validator: (String value) {
//         if (value.isEmpty) return validate;

//         return null;
//       },
//       decoration: InputDecoration(
//         border: OutlineInputBorder(),
//         labelText: label,
//         prefixIcon: Icon(
//           icon,
//         ),
//       ),
//     );
