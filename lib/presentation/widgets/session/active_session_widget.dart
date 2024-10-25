import 'package:flutter/material.dart';
import 'package:El_xizmati/core/extensions/text_extensions.dart';
import 'package:El_xizmati/core/gen/assets/assets.gen.dart';
import 'package:El_xizmati/core/gen/localization/strings.dart';
import 'package:El_xizmati/data/datasource/network/constants/constants.dart';
import 'package:El_xizmati/domain/models/active_sessions/active_session.dart';
import 'package:El_xizmati/presentation/support/extensions/color_extension.dart';

import '../divider/custom_divider.dart';

class ActiveSessionWidget extends StatelessWidget {
  const ActiveSessionWidget({
    super.key,
    required this.session,
    required this.onTerminateClicked,
  });

  final Function(ActiveSession session) onTerminateClicked;
  final ActiveSession session;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 120,
      child: Column(
        children: [
          Expanded(
            child: Container(
              color: context.cardColor,
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  Column(
                    children: [
                      SizedBox(height: 6),
                      (session.isMobileBrowserOrApp()
                              ? Assets.images.icPhone
                              : Assets.images.icLaptop)
                          .svg(width: 24, height: 24),
                    ],
                  ),
                  SizedBox(width: 16),
                  Expanded(
                      child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (session.isMobileBrowserOrApp())
                        Strings.activeSessionsMobileApp.w(700).s(12),
                      if (!session.isMobileBrowserOrApp())
                        Strings.activeSessionsWebBrowser.w(700).s(12),
                      SizedBox(height: 6),
                      Flexible(
                        child: session.userAgent.w(400).s(12).copyWith(
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                      ),
                      SizedBox(height: 6),
                      Flexible(
                        child: (session.lastActivityAt ?? "")
                            .w(400)
                            .s(12)
                            .c(context.textSecondary)
                            .copyWith(overflow: TextOverflow.ellipsis),
                      ),
                      SizedBox(height: 8),
                      if (DeviceInfo.userAgent == session.userAgent)
                        Strings.activeSessionsCurrentSession
                            .w(400)
                            .c(Color(0xFF32B88B))
                            .s(12)
                      else
                        TextButton(
                          style: TextButton.styleFrom(
                            backgroundColor: Color(0x1EF66412),
                          ),
                          onPressed: () => onTerminateClicked(session),
                          child: Strings.activeSessionsTerminate
                              .w(600)
                              .c(Color(0xFFF66412))
                              .s(12),
                        )
                    ],
                  ))
                ],
              ),
            ),
          ),
          CustomDivider(height: 1),
          SizedBox(height: 2)
        ],
      ),
    );
  }
}
