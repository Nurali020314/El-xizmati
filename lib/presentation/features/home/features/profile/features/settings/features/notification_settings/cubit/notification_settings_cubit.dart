import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/presentation/support/cubit/base_cubit.dart';
import 'package:url_launcher/url_launcher.dart';

part 'notification_settings_cubit.freezed.dart';
part 'notification_settings_state.dart';

@injectable
class PageCubit extends BaseCubit<PageState, PageEvent> {
  PageCubit() : super(const PageState());

  setSmsNotification() {
    updateState(
      (state) => state.copyWith(smsNotification: !state.smsNotification),
    );
  }

  setTelegramNotification() {
    updateState(
      (state) => state.copyWith(
        telegramNotification: !state.telegramNotification,
      ),
    );
  }

  setEmailNotification() {
    updateState(
      (state) => state.copyWith(emailNotification: !state.emailNotification),
    );
  }

  Future<void> openTelegram() async {
    try {
      var url = Uri.parse("https://t.me/online_bozor_rs_bot");
      await launchUrl(url);
    } catch (error) {
      logger.e(error.toString());
    }
  }
}