import 'package:fitness/core/widgets/custom_text_field.dart';
import 'package:fitness/feature/auth/ui/widgets/custom_logo_in_auth.dart';
import 'package:fitness/feature/auth/ui/widgets/have_an_account.dart';
import 'package:fitness/feature/auth/ui/widgets/or_divider.dart';
import 'package:fitness/feature/auth/ui/widgets/password_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/widgets/custom_button.dart';
import '../cubits/signup_cubit/signup_cubit.dart';

class SignupViewBody extends StatefulWidget {
  const SignupViewBody({super.key});

  @override
  State<SignupViewBody> createState() => _SignupViewBodyState();
}

class _SignupViewBodyState extends State<SignupViewBody> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  late String email, password, userName;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: autovalidateMode,
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          30.verticalSpace,
          CustomLogoInAuth(),
          20.verticalSpace,
          CustomTextField(
            labelText: "Name",
            keyboardType: TextInputType.name,
            onSaved: (value) {
              userName = value!;
            },
          ),
          20.verticalSpace,
          CustomTextField(
            labelText: "Email",
            validator: (value) {
              if(value!.isEmpty || !value.contains("@gmail.com") ){
                return "Please Enter a valid email";
              }
              return null;  },
            keyboardType: TextInputType.emailAddress,
            onSaved: (value) {
              email = value!;
            },
          ),
          20.verticalSpace,
          PasswordField(
            onSaved: (value) {
              password = value!;
            },
          ),
          20.verticalSpace,
          OrDivider(),
          20.verticalSpace,
          CustomButton(
            text: "Sign Up",
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                context.read<SignupCubit>().createUserWithEmailAndPassword(
                  email,
                  password,
                  userName,
                );
              } else {
                setState(() {
                  autovalidateMode = AutovalidateMode.always;
                });
              }
            },
          ),
          20.verticalSpace,
          HaveAnAccount(),
        ],
      ),
    );
  }
}
