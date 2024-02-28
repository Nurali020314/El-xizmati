import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/core/base_page.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/router/app_router.dart';
import 'package:onlinebozor/presentation/auth/set_password/cubit/page_cubit.dart';

import '../../../common/gen/localization/strings.dart';
import '../../../common/widgets/app_bar/common_app_bar.dart';
import '../../../common/widgets/common/common_button.dart';
import '../../../common/widgets/common/common_text_field.dart';

@RoutePage()
class SetPasswordPage extends BasePage<PageCubit, PageState, PageEvent> {
  const SetPasswordPage({super.key});

  @override
  void onEventEmitted(BuildContext context, PageEvent event) {
    switch (event.type) {
      case PageEventType.navigationToHome:
        context.router.replace(HomeRoute());
    }
  }

  @override
  Widget onWidgetBuild(BuildContext context, PageState state) {
    return Scaffold(
      backgroundColor: context.colors.colorBackgroundPrimary,
      resizeToAvoidBottomInset: false,
      appBar: CommonAppBar("", () => context.router.pop()),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: AutofillGroup(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 42),
              Strings.authRegisterRegister
                  .w(500)
                  .s(24)
                  .c(context.colors.textPrimary),
              SizedBox(height: 42),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Strings.authCommonPassword
                      .w(500)
                      .s(14)
                      .c(context.colors.textPrimary)),
              SizedBox(height: 10),
              CommonTextField(
                autofillHints: const [AutofillHints.password],
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.next,
                obscureText: true,
                inputType: TextInputType.visiblePassword,
                maxLines: 1,
                onChanged: (value) {
                  context.read<PageCubit>().setPassword(value);
                },
                // controller: textController,
              ),
              SizedBox(height: 24),
              Align(
                  alignment: Alignment.centerLeft,
                  child: Strings.authRegisterRepeatPassword
                      .w(500)
                      .s(14)
                      .c(context.colors.textPrimary)),
              SizedBox(height: 10),
              CommonTextField(
                autofillHints: const [AutofillHints.password],
                keyboardType: TextInputType.visiblePassword,
                textInputAction: TextInputAction.done,
                readOnly: false,
                maxLines: 1,
                obscureText: true,
                onChanged: (value) {
                  context.read<PageCubit>().setRepeatPassword(value);
                },
              ),
              Align(
                alignment: Alignment.centerLeft,
                child: CommonButton(
                  onPressed: () {},
                  type: ButtonType.text,
                  child:
                      Text(Strings.authRegisterPasswordContainLeastCharacters),
                ),
              ),
              Spacer(),
              CommonButton(
                onPressed: () {
                  TextInput.finishAutofillContext(shouldSave: true);
                  context.read<PageCubit>().createPassword();
                },
                enabled: state.enabled,
                loading: state.loading,
                child: Container(
                  height: 52,
                  alignment: Alignment.center,
                  width: double.infinity,
                  child: Strings.commonContinueTitle
                      .w(500)
                      .s(14)
                      .c(context.colors.textPrimaryInverse),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}