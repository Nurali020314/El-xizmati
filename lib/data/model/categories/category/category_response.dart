import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'category_response.freezed.dart';
part 'category_response.g.dart';

@freezed
class CategoryRootResponse with _$CategoryRootResponse {
  const factory CategoryRootResponse({
    dynamic error,
    dynamic message,
    String? timestamp,
    int? status,
    dynamic path,
    required List<CategoryResponse> data,
  }) = _CategoryRootResponse;

  factory CategoryRootResponse.fromJson(Map<String, dynamic> json) =>
      _$CategoryRootResponseFromJson(json);
}

@freezed
class CategoryResponse with _$CategoryResponse {
  @HiveType(typeId: 1)
  const factory CategoryResponse({
    @HiveField(1) int? id,
    @HiveField(2) dynamic name,
    @HiveField(3) String? key_word,
    @HiveField(4) int? parent_id,
    @HiveField(5) dynamic icon,
    @HiveField(6) dynamic icon_home,
    @HiveField(7) bool? is_home,
    @HiveField(8) String? type,
  }) = _CategoryResponse;

  factory CategoryResponse.fromJson(Map<String, dynamic> json) =>
      _$CategoryResponseFromJson(json);
}