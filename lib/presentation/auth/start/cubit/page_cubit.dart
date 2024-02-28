import 'package:dio/dio.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/core/base_cubit.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';

import '../../../../data/repositories/auth_repository.dart';

part 'page_cubit.freezed.dart';

part 'page_state.dart';

@injectable
class PageCubit extends BaseCubit<PageState, PageEvent> {
  PageCubit(this._repository) : super(PageState());

  final AuthRepository _repository;

  void setPhone(String phone) {
    log.i(phone);
    updateState(
      (state) => state.copyWith(
        phone: phone,
        validation: phone.length >= 9,
      ),
    );
  }

  void validation() async {
    updateState((state) => state.copyWith(loading: true));
    try {
      var res = await _repository.authStart(states.phone.clearSpaceInPhone());
      if (res.data.is_registered == true) {
        emitEvent(
          PageEvent(PageEventType.verification, phone: states.phone),
        );
      } else {
        emitEvent(
          PageEvent(PageEventType.confirmation, phone: states.phone),
        );
      }
    } on DioException catch (e) {
      display.error(e.toString());
    } finally {
      updateState((state) => state.copyWith(loading: false));
    }
  }
}