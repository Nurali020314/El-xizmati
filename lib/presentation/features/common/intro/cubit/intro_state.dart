part of 'intro_cubit.dart';

@freezed
class PageState with _$PageState {
  const factory PageState({
    @Default(false) bool onLastPage,
  }) = _PageState;
}

@freezed
class PageEvent with _$PageEvent {
  const factory PageEvent() = _PageEvent;
}