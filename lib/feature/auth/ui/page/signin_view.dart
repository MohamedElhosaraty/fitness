import 'package:fitness/core/theming/app_text_styles.dart';
import 'package:fitness/feature/auth/ui/widgets/signin_view_bloc_consumer.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/di/dependency_injection.dart';
import '../cubits/sign_in_cubit/signin_cubit.dart';


class SigninView extends StatelessWidget {
  const SigninView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<SignInCubit>(),
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            "SignIn", style: AppTextStyles.font26Bold(context),
          ),
          centerTitle: true,
        ),
        body: SignInViewBlocConsumer(),
      ),
    );
  }
}
