import 'dart:io';

import 'package:auto_route/auto_route.dart';
import 'package:external_app_launcher/external_app_launcher.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/core/gen/assets/assets.gen.dart';
import 'package:onlinebozor/core/gen/localization/strings.dart';
import 'package:onlinebozor/presentation/features/auth/confirm/auth_confirm_page.dart';
import 'package:onlinebozor/presentation/features/auth/eds/request/crc32.dart';
import 'package:onlinebozor/presentation/features/auth/eds/request/gost_hash.dart';
import 'package:onlinebozor/presentation/router/app_router.dart';
import 'package:onlinebozor/presentation/support/extensions/color_extension.dart';
import 'package:onlinebozor/presentation/support/cubit/base_page.dart';
import 'package:onlinebozor/presentation/support/extensions/controller_exts.dart';
import 'package:onlinebozor/presentation/support/extensions/mask_formatters.dart';
import 'package:onlinebozor/presentation/widgets/app_bar/default_app_bar.dart';
import 'package:onlinebozor/presentation/widgets/button/custom_elevated_button.dart';
import 'package:onlinebozor/presentation/widgets/button/custom_outlined_button.dart';
import 'package:onlinebozor/presentation/widgets/form_field/custom_text_form_field.dart';
import 'package:onlinebozor/presentation/widgets/form_field/label_text_field.dart';
import 'package:url_launcher/url_launcher.dart';

import 'cubit/auth_start_cubit.dart';

@RoutePage()
class AuthStartPage extends BasePage<PageCubit, PageState, PageEvent> {
  AuthStartPage({super.key, this.phone});

  final String? phone;

  final TextEditingController _phoneController = TextEditingController();

  @override
  void onWidgetCreated(BuildContext context) {
    cubit(context).setPhone(phone ?? "");
  }

  @override
  void onEventEmitted(BuildContext context, PageEvent event) {
    switch (event.type) {
      case PageEventType.onOpenLogin:
        context.router.push(AuthLoginRoute(phone: event.phone!));
      case PageEventType.onOpenConfirm:
        context.router.push(
          AuthConfirmRoute(phone: event.phone!, confirmType: ConfirmType.confirm),
        );
      case PageEventType.onEdsLoginFailed:
        showErrorBottomSheet(context, Strings.authStartLoginWithEImzoError);
      case PageEventType.onOpenHome:
        context.router.replace(HomeRoute());
    }
  }

  @override
  Widget onWidgetBuild(BuildContext context, PageState state) {
    _phoneController.updateOnRestore(state.phone);

    return Scaffold(
      backgroundColor: context.colors.backgroundColor,
      resizeToAvoidBottomInset: false,
      appBar: DefaultAppBar(
        titleText: Strings.authStartSingin,
        backgroundColor: context.backgroundColor,
        onBackPressed: () => context.router.pop(),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: AutofillGroup(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Spacer(),
              LabelTextField(Strings.commonPhoneNumber, isRequired: false),
              SizedBox(height: 8),
              CustomTextFormField(
                autofillHints: const [AutofillHints.telephoneNumber],
                inputType: TextInputType.phone,
                keyboardType: TextInputType.phone,
                maxLines: 1,
                prefixText: "+998 ",
                textInputAction: TextInputAction.done,
                controller: _phoneController,
                inputFormatters: phoneMaskFormatter,
                onChanged: (value) {
                  cubit(context).setPhone(value);
                },
              ),
              SizedBox(height: 16),
              CustomElevatedButton(
                text: Strings.commonContinue,
                onPressed: () => cubit(context).validation(),
                backgroundColor: context.colors.buttonPrimary,
                isEnabled: state.validation,
                isLoading: state.loading,
              ),
              SizedBox(height: 16),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: Strings.authPricePoliceStart,
                      style: TextStyle(
                          color: context.textSecondary,
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                    ),
                    TextSpan(text: " "),
                    TextSpan(
                      text: Strings.authPricePoliceAction,
                      style: TextStyle(
                          color: Color(0xFF5C6AC4),
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                      recognizer: TapGestureRecognizer()
                        ..onTap = _handleTextClick,
                    ),
                    TextSpan(text: " "),
                    TextSpan(
                      text: Strings.authPricePoliceEnd,
                      style: TextStyle(
                          color: context.textSecondary,
                          fontSize: 12,
                          fontWeight: FontWeight.w400),
                    ),
                  ],
                ),
              ),
              Spacer(),
              CustomOutlinedButton(
                text: Strings.authStartLoginWithOneId,
                onPressed: () => context.router.push(AuthWithOneIdRoute()),
                strokeColor: context.colors.borderColor,
                rightIcon: Assets.images.icOneId.svg(),
              ),
              SizedBox(height: 10),
              CustomOutlinedButton(
                text: Strings.authStartLoginWithEImzo,
                onPressed: () {
                  cubit(context).edsAuth().then((value) {
                    generateQrCode(
                      context,
                      value?.challange ?? "",
                      value?.siteId ?? "",
                      value?.documentId ?? "",
                    );
                  });
                },
                strokeColor: context.colors.borderColor,
                rightIcon: Assets.images.pngImages.eImzo.image(),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  void _handleTextClick() async {
    try {
      var url = Uri.parse("https://online-bozor.uz/uz/page/privacy");
      await launchUrl(url);
    } catch (error) {}
  }

  void openEdsAppWithQrCode(String code) async {
    await LaunchApp.openApp(
      iosUrlScheme: 'eimzo://sign?qc=$code',
      appStoreLink:
          'itms-apps://itunes.apple.com/us/app/e-imzo-id-карта/id1563416406',
      // openStore: false
    );
  }

  void openEdsAppInfoInPlayMarket() async {
    await LaunchApp.openApp(
      androidPackageName: 'uz.yt.idcard.eimzo',
      iosUrlScheme: 'eimzo://',
      appStoreLink:
          'itms-apps://itunes.apple.com/us/app/e-imzo-id-карта/id1563416406',
      // openStore: false
    );
  }

  void generateQrCode(
    BuildContext context,
    String challenge,
    String siteId,
    String documentId,
  ) {
    var docHash = GostHash.hashGost(challenge);
    var code = siteId + documentId + docHash;
    var crc32 = Crc32.calcHex(code);
    code += crc32;
    if (Platform.isAndroid) {
      var _deepLink = 'eimzo://sign?qc=$code';
      _launchURL(_deepLink);
      cubit(context).edsCheckStatus(documentId);
    } else {
      openEdsAppWithQrCode(code);
    }
  }

  void _launchURL(String url) async {
    if (await canLaunchUrl(
      Uri.parse(url),
    )) {
      await launchUrl(
        Uri.parse(url),
        mode: LaunchMode.externalApplication,
      );
    } else {
      openEdsAppInfoInPlayMarket();
      throw 'Ишга туширилмади $url';
    }
  }
}