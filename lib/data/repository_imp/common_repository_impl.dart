import 'package:injectable/injectable.dart';
import 'package:onlinebozor/data/api/common_api.dart';
import '../../domain/repository/common_repository.dart';
import '../model/banner/banner_response.dart';
import '../model/categories/category/category_response.dart';
import '../model/categories/popular_category/popular_category_response.dart';
import '../model/search/search_response.dart';
import '../storage/categories_storage.dart';

@LazySingleton(as: CommonRepository)
class CommonRepositoryImpl extends CommonRepository {
  final CommonApi _api;
  final CategoriesStorage _categoriesStorage;

  CommonRepositoryImpl(this._api, this._categoriesStorage);

  @override
  Future<List<BannerResponse>> getBanner() async {
    final response = await _api.getBanners();
    final banners = BannerRootResponse.fromJson(response.data).data;
    return banners ?? List.empty();
  }

  @override
  Future<List<CategoryResponse>> getCategories() async {
    final localCategories = _categoriesStorage.categoriesStorage
        .callList()
        .cast<CategoryResponse>();
    if (localCategories.isEmpty) {
      final response = await _api.getCategories();
      final categories = CategoryRootResponse.fromJson(response.data).data;
      await _categoriesStorage.categoriesStorage.set(categories);
      return categories;
    } else {
      return localCategories;
    }
  }

  @override
  Future<List<PopularCategoryResponse>> getPopularCategories(
      int pageIndex, int pageSize) async {
    final response = await _api.getPopularCategories(pageIndex, pageSize);
    final popularCategories =
        PopularRootCategoryResponse.fromJson(response.data).data;
    return popularCategories ?? List.empty();
  }

  @override
  Future<List<Ad>> getSearch(String query) async {
    final response = await _api.getSearchAd(query);
    final searchAd = SearchResponse.fromJson(response.data).data;
    return searchAd?.ads ?? List.empty();
  }

  @override
  Future<void> getCurrency() async {
    final  response =await _api.getCurrency();
    
  }
}