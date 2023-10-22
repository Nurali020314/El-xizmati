import 'package:auto_route/annotations.dart';
import 'package:flutter/cupertino.dart';
import 'package:onlinebozor/common/base/base_page.dart';
import 'package:onlinebozor/presentation/home/favorites/favorites/service/cubit/service_favorites_cubit.dart';

@RoutePage()
class ServiceFavoritesPage extends BasePage<ServiceFavoritesCubit,
    ServiceFavoritesBuildable, ServiceFavoritesListenable> {
  const ServiceFavoritesPage({super.key});

  @override
  Widget builder(BuildContext context, ServiceFavoritesBuildable state) {
    return Center(
      child: Text('Service Favorites page'),
    );
  }
}