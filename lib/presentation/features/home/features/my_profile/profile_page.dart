import 'package:auto_route/auto_route.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:onlinebozor/core/extensions/text_extensions.dart';
import 'package:onlinebozor/presentation/features/home/features/my_profile/profile_cubit.dart';
import 'package:onlinebozor/presentation/support/cubit/base_page.dart';
import 'package:onlinebozor/presentation/support/extensions/color_extension.dart';

import '../../../../../core/gen/assets/assets.gen.dart';
import '../../../../../core/gen/localization/strings.dart';
import '../../../../widgets/app_bar/empty_app_bar.dart';
import '../../../../widgets/elevation/elevation_widget.dart';
import '../../../../widgets/profile/profile_item_widget.dart';

@RoutePage()
class ProfilePage extends BasePage<ProfileCubit, ProfileState, ProfileEvent> {
  @override
  Widget onWidgetBuild(BuildContext context, ProfileState state) {
    return Scaffold(
      appBar: EmptyAppBar(
        titleText: Strings.profileViewTitlle,
        backgroundColor: context.appBarColor,
        textColor: context.textPrimary,
      ),
      backgroundColor: context.backgroundGreyColor,
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildUserData(context, state),
            _buildSettingsBlock(context, state),
          ],
        ),
      ),
    );
  }

  Widget _buildUserData(
    BuildContext context,
    ProfileState state,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(height: 20),
        SizedBox(
          height: 72,
          width: 72,
          child: Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border:
                        Border.all(color: context.colors.primary, width: 1.5)),
                clipBehavior: Clip.hardEdge,
                child: Container(
                  height: 72,
                  width: 72,
                  clipBehavior: Clip.hardEdge,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(color: Colors.white, width: 1.5),
                  ),
                  child: ClipRRect(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(right: 4.0, bottom: 3),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: Assets.spImages.icProfileEdit.svg(),
                ),
              )
            ],
          ),
        ),
        SizedBox(height: 18),
        Text('Shodlik Yagmurov').w(700).s(16).c(context.colors.primary),
        SizedBox(height: 6),
        Text('Ish oluvchi').w(700).s(10).c(context.colors.textPrimary),
        SizedBox(height: 50)
      ],
    );
  }

  Widget _buildSettingsBlock(
    BuildContext context,
    ProfileState state,
  ) {
    return ElevationWidget(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
      topLeftRadius: 16,
      topRightRadius: 16,
      bottomLeftRadius: 16,
      bottomRightRadius: 16,
      leftMargin: 16,
      topMargin: 8,
      rightMargin: 16,
      bottomMargin: 8,
      child: Column(
        children: [
          ProfileItemWidget(
            name: Strings.profilePersonalData,
            icon: Assets.spImages.icProfileInfo,
            topRadius: 16,
            bottomRadius: 0,
            onClicked: () => {},
          ),
          ProfileItemWidget(
            name: Strings.settingsChangePassword,
            icon: Assets.spImages.icProfileChangePassword,
            topRadius: 0,
            bottomRadius: 0,
            onClicked: () => {},
          ),
          ProfileItemWidget(
            name: Strings.profileMyBalans,
            icon: Assets.spImages.icProfileBalance,
            topRadius: 0,
            bottomRadius: 0,
            onClicked: () => {},
          ),
          ProfileItemWidget(
            name: Strings.profileNotification,
            icon: Assets.spImages.icProfileNotification,
            topRadius: 0,
            bottomRadius: 0,
            onClicked: () => {},
          ),
          ProfileItemWidget(
            name: Strings.profileChangeLanguage,
            icon: Assets.spImages.icProfileLanguage,
            topRadius: 0,
            bottomRadius: 0,
            onClicked: () => {},
          ),
          Divider(
            height: 16,
            indent: 16,
            endIndent: 16,
          ),
          ProfileItemWidget(
            name: 'Yordam so’rash',
            icon: Assets.spImages.icProfileSupport,
            topRadius: 0,
            bottomRadius: 0,
            onClicked: () => {},
          ),
          ProfileItemWidget(
            name: 'Ilova haqida',
            icon: Assets.spImages.icProfileIcon,
            topRadius: 0,
            bottomRadius: state.isAuthorized ? 0 : 16,
            onClicked: () => {},
          ),
          ProfileItemWidget(
            name: 'Chiqish',
            icon: Assets.spImages.icProfileLogout,
            topRadius: 0,
            bottomRadius: state.isAuthorized ? 0 : 16,
            onClicked: () => {},
          ),
        ],
      ),
    );
  }
}
