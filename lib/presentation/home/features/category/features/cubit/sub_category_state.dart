part of 'sub_category_cubit.dart';

@freezed
class SubCategoryBuildable with _$SubCategoryBuildable {
  const factory SubCategoryBuildable(
          {@Default(<CategoryResponse>[]) List<CategoryResponse> categories,
          @Default(AppLoadingState.loading) AppLoadingState categoriesState}) =
      _SubCategoryBuildable;
}

@freezed
class SubCategoryListenable with _$SubCategoryListenable {
  const factory SubCategoryListenable() = _SubCategoryListenable;
}