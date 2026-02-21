import 'package:fitness/core/widgets/custom_progress_hud.dart';
import 'package:fitness/feature/auth/ui/widgets/signin_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/helpers/toast_helper.dart';
import '../cubits/sign_in_cubit/signin_cubit.dart';

class SignInViewBlocConsumer extends StatelessWidget {
  const SignInViewBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignInCubit, SignInState>(listener: (context, state) {
      if (state is SignInSuccess) {
        ToastHelper().showSuccessToast(context, "Login successful");
      }
      if (state is SignInFailure) {
        ToastHelper().showErrorToast(context, state.message);

      }
    }, builder: (context, state) {
      return CustomProgressHud(
          isLoading: state is SignInLoading ? true : false,
          child: const SigninViewBody());
    });
  }
}