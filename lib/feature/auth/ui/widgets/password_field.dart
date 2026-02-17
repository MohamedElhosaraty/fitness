import 'package:flutter/material.dart';

import '../../../../core/widgets/custom_text_field.dart';

class PasswordField extends StatefulWidget {
  const PasswordField({super.key,required this.onSaved});

  final void Function(String?)? onSaved;

  @override
  State<PasswordField> createState() => _PasswordFieldState();
}

class _PasswordFieldState extends State<PasswordField> {

  bool  isObscure = true;
  @override
  Widget build(BuildContext context) {
    return CustomTextField(
      onSaved: widget.onSaved,
      labelText: "Password",
      isObscure: isObscure,
      keyboardType: TextInputType.visiblePassword,
      suffixIcon: GestureDetector(
        onTap: (){
          isObscure = !isObscure;
          setState(() {});
        },
        child: isObscure ? Icon(
          Icons.remove_red_eye,
          color: Color(0xffC9CECF),
        ) : Icon(
          Icons.visibility_off,
          color: Color(0xffC9CECF),
        ),
      ),
    );
  }
}