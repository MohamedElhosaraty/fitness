import 'package:fitness/core/theming/app_text_styles.dart';
import 'package:fitness/feature/auth/ui/cubits/signup_cubit/signup_cubit.dart';
import 'package:fitness/feature/auth/ui/widgets/signup_view_body.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/dependency_injection.dart';
import '../widgets/signup_view_bloc_consumer.dart';


class SignupView extends StatelessWidget {
  const SignupView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SignupCubit>(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "SignUp", style: AppTextStyles.font26Bold(context),
          ),
          centerTitle: true,
        ),
        body: SignupViewBlocConsumer(),
      ),
    );
  }
}
