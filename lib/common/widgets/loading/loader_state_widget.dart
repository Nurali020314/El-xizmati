import 'package:flutter/material.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/enum/enums.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/widgets/button/custom_elevated_button.dart';

class LoaderStateWidget extends StatelessWidget {
  const LoaderStateWidget({
    super.key,
    required this.isFullScreen,
    required this.loadingState,
    required this.successBody,
    this.initialBody,
    this.loadingBody,
    this.emptyBody,
    this.onRetryClicked,
  });

  final bool isFullScreen;
  final LoadingState loadingState;
  final Widget successBody;
  final Widget? initialBody;
  final Widget? loadingBody;
  final Widget? emptyBody;
  final VoidCallback? onRetryClicked;

  @override
  Widget build(BuildContext context) {
    return switch (loadingState) {
      LoadingState.loading =>
        loadingBody ?? LoadingWidget(isFullScreen: isFullScreen),
      LoadingState.error => ErrorWidget(isFullScreen: isFullScreen),
      LoadingState.success => successBody,
      LoadingState.onStart => initialBody ?? Center(),
      LoadingState.empty => emptyBody ?? Center(),
    };
  }
}

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key, required this.isFullScreen});

  final bool isFullScreen;

  @override
  Widget build(BuildContext context) {
    return isFullScreen
        ? Center(
            child: CircularProgressIndicator(
              color: Colors.blue,
            ),
          )
        : SizedBox(
            height: 160,
            child: Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            ),
          );
  }
}

class ErrorWidget extends StatelessWidget {
  const ErrorWidget({
    super.key,
    required this.isFullScreen,
    this.onErrorToAgainRequest,
  });

  final bool isFullScreen;
  final VoidCallback? onErrorToAgainRequest;

  @override
  Widget build(BuildContext context) {
    return isFullScreen
        ? Center(
            child: Column(
              children: [
                "Xatolik yuz berdi?".w(400).s(14).c(context.colors.textPrimary),
                SizedBox(height: 12),
                CustomElevatedButton(
                  text: "Qayta urinish",
                  onPressed: () => onErrorToAgainRequest,
                  buttonWidth: 180,
                )
              ],
            ),
          )
        : Center(
            child: SizedBox(
              height: 160,
              child: Column(
                children: [
                  "Xatolik yuz berdi?"
                      .w(400)
                      .s(14)
                      .c(context.colors.textPrimary),
                  SizedBox(height: 12),
                  CustomElevatedButton(
                    text: "Qayta urinish",
                    onPressed: () => onErrorToAgainRequest,
                    buttonWidth: 180,
                  )
                ],
              ),
            ),
          );
  }
}
