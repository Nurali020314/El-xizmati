import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/presentation/support/extensions/color_extension.dart';
import 'package:onlinebozor/presentation/support/cubit/base_page.dart';
import 'package:onlinebozor/core/extensions/text_extensions.dart';
import 'package:onlinebozor/core/gen/localization/strings.dart';
import 'package:onlinebozor/presentation/router/app_router.dart';
import 'package:onlinebozor/presentation/widgets/app_bar/default_app_bar.dart';
import 'package:onlinebozor/presentation/widgets/button/custom_elevated_button.dart';
import 'package:onlinebozor/presentation/widgets/button/custom_text_button.dart';
import 'package:onlinebozor/presentation/widgets/form_field/custom_text_form_field.dart';

import 'cubit/auth_confirm_cubit.dart';

@RoutePage()
class AuthConfirmPage extends BasePage<PageCubit, PageState, PageEvent> {
  AuthConfirmPage({
    super.key,
    this.phone,
    required this.confirmType,
  });

  final phone;
  final ConfirmType confirmType;
  final textEditingController = TextEditingController();
  final format = DateFormat("mm:ss");

  @override
  void onWidgetCreated(BuildContext context) {
    cubit(context).setInitialParams(phone, confirmType);
    cubit(context).startTimer();
    textEditingController.text = phone;
  }

  @override
  void onEventEmitted(BuildContext context, PageEvent event) {
    switch (event.type) {
      case PageEventType.setPassword:
        context.router.replace(SetPasswordRoute());
    }
  }

  @override
  Widget onWidgetBuild(BuildContext context, PageState state) {
    return Scaffold(
      backgroundColor: context.colors.backgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: DefaultAppBar(
        titleText: "",
        backgroundColor: context.backgroundColor,
        onBackPressed: () => context.router.pop(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 42),
            Strings.authConfirmCorfimationCode
                .w(500)
                .s(24)
                .c(context.textPrimary),
            SizedBox(height: 42),
            Align(
              alignment: Alignment.centerLeft,
              child: Strings.commonPhoneNumber
                  .w(500)
                  .s(14)
                  .c(context.textPrimary),
            ),
            SizedBox(height: 10),
            Container(
              height: 56,
              width: double.infinity,
              decoration: ShapeDecoration(
                color: Color(0xFFFAF9FF),
                shape: RoundedRectangleBorder(
                  side: BorderSide(width: 1, color: Color(0xFFDFE2E9)),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: "+998 ${state.phone}".w(500).s(14),
                  ),
                ],
              ),
            ),
            SizedBox(height: 24),
            Align(
              alignment: Alignment.centerLeft,
              child: Strings.authConfirmSentSmsYourPhone(phone: phone)
                  .w(500)
                  .s(14)
                  .c(context.textPrimary)
                  .copyWith(overflow: TextOverflow.ellipsis),
            ),
            SizedBox(height: 10),
            CustomTextFormField(
              inputType: TextInputType.number,
              maxLines: 1,
              textInputAction: TextInputAction.done,
              onChanged: (value) {
                cubit(context).setCode(value);
              },
            ),
            Row(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: CustomTextButton(
                    text: Strings.authConfirmAgainSentSmsYourPhone,
                    isEnabled: state.isResentButtonEnabled,
                    isLoading: state.isResendLoading,
                    onPressed: () => cubit(context).resendCode(),
                  ),
                ),
                format
                    .format(
                      DateTime.fromMillisecondsSinceEpoch(
                        state.timerTime * 1000,
                      ),
                    )
                    .w(500)
                    .s(14)
                    .c(Colors.black)
              ],
            ),
            Spacer(),
            CustomElevatedButton(
              text: Strings.commonContinue,
              onPressed: () {
                cubit(context).confirmCode();
              },
              isEnabled: state.isConfirmButtonEnabled,
              isLoading: state.isConfirmLoading,
            ),
            SizedBox(height: 20),
            Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: Strings.authPolicyAgree,
                    style: TextStyle(
                      color: context.textSecondary,
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        cubit(context).launchURLApp();
                      },
                    text: Strings.authPersonPolicy,
                    style: TextStyle(
                      color: Color(0xFF5C6AC3),
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

enum ConfirmType { confirm, recovery }