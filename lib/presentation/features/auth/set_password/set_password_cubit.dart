import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/presentation/support/cubit/base_cubit.dart';
import 'package:onlinebozor/data/repositories/auth_repository.dart';

part 'set_password_cubit.freezed.dart';
part 'set_password_state.dart';

@injectable
class SetPasswordCubit extends BaseCubit<SetPasswordState, SetPasswordEvent> {
  SetPasswordCubit(this._authRepository) : super(SetPasswordState());

  final AuthRepository _authRepository;

  void setPassword(String password) {
    updateState((state) => state.copyWith(password: password));
    enable();
  }

  void setRepeatPassword(String repeatPassword) {
    updateState((state) => state.copyWith(
          repeatPassword: repeatPassword,
        ));
    enable();
  }

  void enable() {
    logger
        .w("password= ${states.password}, repeatPass=${states.repeatPassword}");
    updateState(
      (state) => state.copyWith(
        enabled: ((state.password.length >= 8) &&
            (state.repeatPassword.length >= 8) &&
            (state.password == state.repeatPassword)),
      ),
    );
  }

  Future<void> createPassword() async {
    updateState((state) => state.copyWith(loading: true));
    try {
      await _authRepository.registerOrResetPassword(
        states.password,
        states.repeatPassword,
      );
      emitEvent(SetPasswordEvent(SetPasswordEventType.navigationToHome));
    } catch (e, stackTrace) {
      logger.e(e.toString(), error: e, stackTrace: stackTrace);
    } finally {
      updateState((state) => state.copyWith(loading: false));
    }
  }
}