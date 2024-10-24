import 'dart:async';

import 'package:floor/floor.dart';
import 'package:El_xizmati/data/datasource/floor/dao/ad_entity_dao.dart';
import 'package:El_xizmati/data/datasource/floor/dao/category_entity_dao.dart';
import 'package:El_xizmati/data/datasource/floor/dao/user_address_entity_dao.dart';
import 'package:El_xizmati/data/datasource/floor/dao/user_entity_dao.dart';
import 'package:El_xizmati/data/datasource/floor/database/callback.dart';
import 'package:El_xizmati/data/datasource/floor/database/migrations.dart';
import 'package:El_xizmati/data/datasource/floor/entities/ad_entity.dart';
import 'package:El_xizmati/data/datasource/floor/entities/category_entity.dart';
import 'package:El_xizmati/data/datasource/floor/entities/user_address_entity.dart';
import 'package:El_xizmati/data/datasource/floor/entities/user_entity.dart';
import 'package:sqflite/sqflite.dart' as sqflite;

part 'app_database.g.dart';

@Database(
  entities: [
    AdEntity,
    CategoryEntity,
    UserAddressEntity,
    UserEntity,
  ],
  version: 1,
)
abstract class AppDatabase extends FloorDatabase {
  AdEntityDao get adEntityDao;

  CategoryEntityDao get categoryEntityDao;

  UserAddressEntityDao get userAddressEntityDao;

  UserEntityDao get userEntityDao;

  static Future<AppDatabase> initializeDatabase() async {
    final migrations = [migration1to2];

    final database = await $FloorAppDatabase
        .databaseBuilder("app_database.db")
        .addCallback(databaseCallback)
        .addMigrations(migrations).build();

    return database;
  }
}
