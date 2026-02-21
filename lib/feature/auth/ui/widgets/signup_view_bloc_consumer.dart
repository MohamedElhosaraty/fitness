import 'package:fitness/feature/auth/ui/widgets/signup_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/helpers/toast_helper.dart';
import '../../../../core/widgets/custom_progress_hud.dart';
import '../cubits/signup_cubit/signup_cubit.dart';

class SignupViewBlocConsumer extends StatelessWidget {
  const SignupViewBlocConsumer({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignupCubit, SignupState>(
      listener: (context, state) {
        if (state is SignupSuccess) {
          ToastHelper().showSuccessToast(context, "Signup successful");
        }
        if (state is SignupFailure) {
          ToastHelper().showErrorToast(context, state.message);
        }
      },
      builder: (context, state) {
        return CustomProgressHud(
            isLoading: state is SignupLoading,
            child: const SignupViewBody());
      },
    );
  }
}