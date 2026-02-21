import 'package:fitness/core/widgets/custom_text_field.dart';
import 'package:fitness/feature/auth/ui/widgets/custom_logo_in_auth.dart';
import 'package:fitness/feature/auth/ui/widgets/don_have_an_account.dart';
import 'package:fitness/feature/auth/ui/widgets/or_divider.dart';
import 'package:fitness/feature/auth/ui/widgets/password_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/widgets/custom_button.dart';
import '../cubits/sign_in_cubit/signin_cubit.dart';

class SigninViewBody extends StatefulWidget {
  const SigninViewBody({super.key});

  @override
  State<SigninViewBody> createState() => _SigninViewBodyState();
}

class _SigninViewBodyState extends State<SigninViewBody> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  AutovalidateMode autovalidateMode = AutovalidateMode.disabled;
  late String email , password ;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: autovalidateMode,
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        children: [
          50.verticalSpace,
          CustomLogoInAuth(),
          30.verticalSpace,
          CustomTextField(
            validator: (value) {
              if(value!.isEmpty || !value.contains("@gmail.com") ){
                return "Please Enter a valid email";
              }
              return null;  },
            labelText: "Email",
            keyboardType: TextInputType.emailAddress,
            onSaved: (value) {
            email = value!;
          },
          ),
          20.verticalSpace,
          PasswordField(
            onSaved: (value) {
            password = value!;
          },),
          20.verticalSpace,
          OrDivider(),
          20.verticalSpace,
          CustomButton(
            text: "Sign In", onPressed: () {
            if(_formKey.currentState!.validate()){
              _formKey.currentState!.save();
              context.read<SignInCubit>().signInWithEmailAndPassword(email, password);
            }else{
              autovalidateMode = AutovalidateMode.always;
              setState(() {});
            }
          },),
          20.verticalSpace,
          DontHaveAnAccount(),
        ],
      ),
    );
  }
}
