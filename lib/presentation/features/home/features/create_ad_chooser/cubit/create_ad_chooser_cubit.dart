import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/presentation/support/cubit/base_cubit.dart';
import 'package:onlinebozor/data/repositories/state_repository.dart';

part 'create_ad_chooser_cubit.freezed.dart';
part 'create_ad_chooser_state.dart';

@Injectable()
class PageCubit extends BaseCubit<PageState, PageEvent> {
  PageCubit(this.repository) : super(PageState()) {
    isUserLoggedIn();
  }

  final StateRepository repository;

  Future<void> isUserLoggedIn() async {
    final isUserLoggedIn = repository.isUserLoggedIn();
    updateState((state) => state.copyWith(isLogin: isUserLoggedIn));
  }
}