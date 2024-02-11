import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/core/base_page.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';

import '../../../../../common/gen/assets/assets.gen.dart';
import '../../../../../common/widgets/category/category_widget.dart';
import '../../../../../common/widgets/loading/loader_state_widget.dart';
import '../../../../../data/responses/category/category/category_response.dart';
import 'cubit/selection_category_cubit.dart';

@RoutePage()
class SelectionCategoryPage extends BasePage<SelectionCategoryCubit,
    SelectionCategoryBuildable, SelectionCategoryListenable> {
  const SelectionCategoryPage(this.onResult, {super.key});

  final void Function(CategoryResponse categoryResponse) onResult;

  @override
  void listener(BuildContext context, SelectionCategoryListenable event) {
    switch (event.selectionCategoryEffect) {
      case SelectionCategoryEffect.back:
        {
          onResult.call(event.categoryResponse!);
          context.router.pop(true);
        }
    }
  }

  @override
  Widget builder(BuildContext context, SelectionCategoryBuildable state) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            icon: Assets.images.icArrowLeft.svg(),
            onPressed: () {
              context.read<SelectionCategoryCubit>().backCategory();
            }),
        elevation: 0.5,
        backgroundColor: Colors.white,
        centerTitle: true,
        bottomOpacity: 1,
        title: (state.selectedCategoryResponse?.name ?? "")
            .w(500)
            .s(16)
            .c(context.colors.textPrimary),
      ),
      body: LoaderStateWidget(
        isFullScreen: true,
        loadingState: state.categoriesState,
        child: ListView.separated(
          physics: BouncingScrollPhysics(),
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemCount: state.selectCategories.length,
          itemBuilder: (context, index) {
            return AppCategoryWidget(
                invoke: (CategoryResponse categoryResponse) {
                  context
                      .read<SelectionCategoryCubit>()
                      .selectCategory(categoryResponse);
                },
                category: state.selectCategories[index]);
          },
          separatorBuilder: (BuildContext context, int index) {
            return Divider(height: 1, indent: 54, color: Color(0xFFE5E9F3));
          },
        ),
      ),
    );
  }
}