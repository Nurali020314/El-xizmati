part of 'cart_cubit.dart';

@freezed
class CartBuildable with _$CartBuildable {
  const factory CartBuildable({
    @Default(false) bool checkBox,
    @Default(<Ad>[]) List<Ad> cartItems,
    PagingController<int, Ad>? adsPagingController,
  }) = _CartBuildable;
}

@freezed
class CartListenable with _$CartListenable {
  const factory CartListenable(CartEffect effect, {String? message}) =
  _CartListenable;
}

enum CartEffect { success }