import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

class RegionPreferences {
  final SharedPreferences _preferences;

  RegionPreferences(this._preferences);

  static const String _regionId = 'region_id';
  static const String _regionName = 'region_name';
  static const String _districtId = 'district_id';
  static const String _districtName = 'district_name';

  @factoryMethod
  static Future<RegionPreferences> create() async {
    final prefs = await SharedPreferences.getInstance();
    return RegionPreferences(prefs);
  }

  int? get regionId => _preferences.getInt(_regionId);

  String? get regionName => _preferences.getString(_regionName);

  int? get districtId => _preferences.getInt(_districtId);

  String? get districtName => _preferences.getString(_districtName);

  bool get isRegionSelected => regionId != null && districtId != null;

  String get selectedRegionName =>
      isRegionSelected ? "${regionName!}, ${districtName!}" : "";

  Future<void> setSelectedRegion({
    required int regionId,
    required String regionName,
    required int districtId,
    required String districtName,
  }) async {
    await _preferences.setInt(_regionId, regionId);
    await _preferences.setString(_regionName, regionName);
    await _preferences.setInt(_districtId, districtId);
    await _preferences.setString(_districtName, districtName);
  }

  Future<void> clear() async {
    await _preferences.remove(_regionId);
    await _preferences.remove(_regionName);
    await _preferences.remove(_districtId);
    await _preferences.remove(_districtName);
  }
}