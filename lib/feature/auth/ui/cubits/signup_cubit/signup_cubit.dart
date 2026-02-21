import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/model/user_model.dart';
import '../../../domain/repos/auth_repo.dart';

part 'signup_state.dart';

class SignupCubit extends Cubit<SignupState> {
  SignupCubit(this.authRepo) : super(SignupInitial());

  final AuthRepo authRepo;

  Future<void> createUserWithEmailAndPassword(
      String email, String password, String name) async {
    emit(SignupLoading());
    var result =
        await authRepo.createUserWithEmailAndPassword(email, password, name);
    result.fold((failure) =>
        emit(SignupFailure(message: failure.message)),
            (userModel) => emit(SignupSuccess(userModel : userModel),),);
  }
}
