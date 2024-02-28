part of 'profile_cubit.dart';

@freezed
class PageState with _$PageState {
  const factory PageState({
    @Default(false) bool isLogin,
    Language? language,
  }) = _PageState;
}

@freezed
class PageEvent with _$PageEvent {
  const factory PageEvent(PageEventType type) = _PageEvent;
}

enum PageEventType { onLogOut }
