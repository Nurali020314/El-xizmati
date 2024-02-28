part of 'page_cubit.dart';

@freezed
class PageState with _$PageState {
  const factory PageState({
    @Default("") String keyWord,
    @Default(UserAdStatus.all) UserAdStatus userAdStatus,
    @Default(LoadingState.loading) LoadingState loadState,
    PagingController<int, UserAdResponse>? controller,
  }) = _PageState;
}

@freezed
class PageEvent with _$PageEvent {
  const factory PageEvent() = _PageEvent;
}