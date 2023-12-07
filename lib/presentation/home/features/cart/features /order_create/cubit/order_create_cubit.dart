import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../../common/core/base_cubit.dart';
import '../../../../../../../domain/models/ad.dart';
import '../../../../../../../domain/models/ad_detail.dart';
import '../../../../../../../domain/repositories/ad_repository.dart';
import '../../../../../../../domain/repositories/cart_repository.dart';
import '../../../../../../../domain/repositories/favorite_repository.dart';
import '../../../../../../../domain/repositories/state_repository.dart';
import '../../../../../../../domain/repositories/user_repository.dart';
import '../../../../../../../domain/util.dart';

part 'order_create_cubit.freezed.dart';

part 'order_create_state.dart';

@Injectable()
class OrderCreateCubit
    extends BaseCubit<OrderCreateBuildable, OrderCreateListenable> {
  OrderCreateCubit(this._adRepository, this._cartRepository,
      this.favoriteRepository, this.stateRepository, this.userRepository)
      : super(const OrderCreateBuildable());

  final AdRepository _adRepository;
  final CartRepository _cartRepository;
  final FavoriteRepository favoriteRepository;
  final StateRepository stateRepository;
  final UserRepository userRepository;

  Future<void> setAdId(int adId) async {
    build((buildable) => buildable.copyWith(adId: adId));
    getDetailResponse();
  }

  void add() {
    build((buildable) => buildable.copyWith(count: buildable.count + 1));
  }

  void minus() {
    if (buildable.count > 1) {
      build((buildable) => buildable.copyWith(count: buildable.count - 1));
    }
  }

  Future<void> getDetailResponse() async {
    try {
      final response = await _adRepository.getAdDetail(buildable.adId!);
      final paymentList =
          response?.paymentTypes?.map((e) => e.id ?? -1).toList() ??
              List.empty();
      // display.success("list length ${paymentList.length}");
      build((buildable) => buildable.copyWith(
          adDetail: response,
          favorite: response?.favorite ?? false,
          paymentType: paymentList));
    } catch (e) {
      log.e(e.toString());
      display.error(e.toString());
    }
  }

  void setPaymentType(int typeId) {
    build((buildable) => buildable.copyWith(paymentId: typeId));
  }

  Future<void> removeCart() async {
    try {
      if (buildable.adId != null) {
        await _cartRepository.removeCart(buildable.adId!);
        invoke(OrderCreateListenable(OrderCreateEffect.delete));
      }
    } catch (e) {
      display.error(e.toString());
    }
  }

  Future<void> addFavorite(AdDetail adDetail) async {
    try {
      if (!adDetail.favorite) {
        await favoriteRepository.addFavorite(Ad(
            backendId: -1,
            id: adDetail.adId,
            name: adDetail.adName ?? "",
            price: adDetail.price,
            currency: adDetail.currency,
            region: adDetail.address?.region?.name ?? "",
            district: adDetail.address?.district?.name ?? "",
            adRouteType: adDetail.adRouteType,
            adPropertyStatus: adDetail.propertyStatus,
            adStatusType: adDetail.adStatusType ?? AdStatusType.standard,
            adTypeStatus: adDetail.adTypeStatus ?? AdTypeStatus.buy,
            fromPrice: adDetail.fromPrice ?? 0,
            toPrice: adDetail.toPrice ?? 0,
            categoryId: adDetail.categoryId ?? -1,
            categoryName: adDetail.categoryName ?? "",
            sellerName: adDetail.sellerFullName ?? "",
            sellerId: adDetail.sellerId ?? -1,
            photo: adDetail.photos?.first.image ?? 'xatolik ',
            isSort: -1,
            isSell: false,
            maxAmount: -1,
            favorite: true,
            isCheck: false));
        display.success("Success");
      } else {
        await favoriteRepository.removeFavorite(Ad(
            backendId: -1,
            id: adDetail.adId,
            name: adDetail.adName ?? "",
            price: adDetail.price,
            currency: adDetail.currency,
            region: adDetail.address?.region?.name ?? "",
            district: adDetail.address?.district?.name ?? "",
            adRouteType: adDetail.adRouteType,
            adPropertyStatus: adDetail.propertyStatus,
            adStatusType: adDetail.adStatusType ?? AdStatusType.standard,
            adTypeStatus: adDetail.adTypeStatus ?? AdTypeStatus.buy,
            fromPrice: adDetail.fromPrice ?? 0,
            toPrice: adDetail.toPrice ?? 0,
            categoryId: adDetail.categoryId ?? -1,
            categoryName: adDetail.categoryName ?? "",
            sellerName: adDetail.sellerFullName ?? "",
            sellerId: adDetail.sellerId ?? -1,
            photo: adDetail.photos?.first.image ?? 'xatolik ',
            isSort: -1,
            isSell: false,
            maxAmount: -1,
            favorite: true,
            isCheck: false));
      }
      final favorite = !buildable.favorite;
      build((buildable) => buildable.copyWith(favorite: favorite));
      display.success("succes");
    } catch (e) {
      display.error(e.toString());
    }
  }

  Future<void> orderCreate() async {
    try {
      final isLogin = await stateRepository.isLogin() ?? false;
      final isFullRegister = await userRepository.isFullRegister();
      if (isLogin) {
        if (isFullRegister) {
          if (buildable.paymentId > 0) {
            await _cartRepository.orderCreate(
                productId: buildable.adId ?? -1,
                amount: buildable.count,
                paymentTypeId: buildable.paymentId,
                tin: buildable.adDetail?.sellerTin ?? -1);
            display.success("success");
          } else {
            display.error("to'lov turi tanlanmagan");
          }
        } else {
          display.error("To'liq ro'yxatdan o'tilmagan");
        }
      } else {
        invoke(OrderCreateListenable(OrderCreateEffect.navigationAuthStart));
      }
    } catch (e) {
      display.error("error");
    }
  }
}
