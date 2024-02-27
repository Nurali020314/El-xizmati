import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:injectable/injectable.dart';

import '../../../common/core/base_cubit.dart';

part 'home_cubit.freezed.dart';
part 'home_state.dart';

@Injectable()
class HomeCubit extends BaseCubit<HomeBuildable, HomeListenable> {
  HomeCubit() : super(HomeBuildable()) {
    init();
  }

  Future<void> init() async {
    Hive.box("favorites_storage")
        .listenable(keys: ["key_favorites_storage"]).addListener(() {
      int favoriteNumber = Hive.box("favorites_storage").length;
      updateState((buildable) => buildable.copyWith(favoriteAmount: favoriteNumber));
      display.success("favorite change $favoriteNumber");
    });

    Hive.box("cart_storage")
        .listenable(keys: ["key_cart_storage"]).addListener(() {
      int cartNumber = Hive.box("cart_storage").length;
      updateState((buildable) => buildable.copyWith(cartAmount: cartNumber));
      display.success("cart change $cartNumber");
    });
  }
}
