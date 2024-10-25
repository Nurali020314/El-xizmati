import 'package:El_xizmati/data/datasource/network/responses/region/district_response.dart';
import 'package:El_xizmati/data/datasource/network/responses/region/region_and_district_response.dart';
import 'package:El_xizmati/data/datasource/network/responses/region/region_response.dart';
import 'package:El_xizmati/domain/models/district/district.dart';
import 'package:El_xizmati/domain/models/list/expandable_list_item.dart';
import 'package:El_xizmati/domain/models/region/region.dart';
import 'package:El_xizmati/domain/models/region/region_and_district.dart';
import 'package:El_xizmati/domain/models/street/street.dart';

extension RegionResponseExts on RegionResponse {
  Region toRegion() {
    return Region(id: id, name: name);
  }

  District toDistrict(int regionId) {
    return District(id: id, name: name, regionId: id);
  }

  Neighborhood toNeighborhood() {
    return Neighborhood(id: id, name: name);
  }
}

extension DistrictResponseExts on DistrictResponse {
  District toDistrict() {
    return District(id: id, name: name, regionId: reg_id);
  }
}

extension RegionItemExts on ExpandableListItem {
  District toDistrict() {
    return District(
      id: id,
      regionId: parentId,
      name: name,
    );
  }
}

extension RegionAndDistrictExts on RegionAndDistrictResponse {
  RegionAndDistrict toRegionAndDistrict() {
    return RegionAndDistrict(
      regions: regions.map((e) => e.toRegion()).toList(),
      districts: districts.map((e) => e.toDistrict()).toList(),
    );
  }
}
