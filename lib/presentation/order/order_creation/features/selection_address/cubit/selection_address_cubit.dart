import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/common/core/base_cubit.dart';

part 'selection_address_cubit.freezed.dart';

part 'selection_address_state.dart';

@Injectable()
class SelectionAddressCubit
    extends BaseCubit<SelectionAddressBuildable, SelectionAddressListenable> {
  SelectionAddressCubit() : super(const SelectionAddressBuildable());
}
