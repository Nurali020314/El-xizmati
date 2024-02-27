import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/gen/localization/strings.dart';

import '../../../../../../../../common/core/base_page.dart';
import '../../../../../../../../common/gen/assets/assets.gen.dart';
import 'cubit/user_social_network_cubit.dart';

@RoutePage()
class UserSocialNetworkPage extends BasePage<UserSocialNetworkCubit,
    UserSocialNetworkBuildable, UserSocialNetworkListenable> {
  const UserSocialNetworkPage({super.key});

  @override
  Widget onWidgetBuild(BuildContext context, UserSocialNetworkBuildable state) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Strings.settingsSocialNetwork
            .w(500)
            .s(14)
            .c(context.colors.textPrimary),
        centerTitle: true,
        elevation: 0.5,
        leading: IconButton(
          icon: Assets.images.icArrowLeft.svg(),
          onPressed: () => context.router.pop(),
        ),
      ),
      body: Center(
        child: Text("User Social Network page"),
      ),
    );
  }
}
