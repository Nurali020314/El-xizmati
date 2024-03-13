import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';
import 'package:onlinebozor/data/responses/address/user_address_response.dart';
import 'package:onlinebozor/domain/models/district/district.dart';

import '../../../../../../common/core/base_cubit.dart';
import '../../../../../../data/responses/category/category/category_response.dart';
import '../../../../data/responses/currencies/currency_response.dart';
import '../../../../data/responses/payment_type/payment_type_response.dart';
import '../../../../data/responses/region/region_root_response.dart';

part 'page_cubit.freezed.dart';

part 'page_state.dart';

@Injectable()
class PageCubit extends BaseCubit<PageState, PageEvent> {
  PageCubit() : super(const PageState());

  void setName(String name) {
    log.w(name);
    updateState((state) => state.copyWith(name: name));
  }

  void setNegative(bool isNegotiate) {
    updateState((state) => state.copyWith(isNegotiate: isNegotiate));
  }

  void setDescription(String description) {
    updateState((state) => state.copyWith(description: description));
  }

  void setCategory(CategoryResponse? categoryResponse) {
    display.success("set category ");
    updateState((state) => state.copyWith(categoryResponse: categoryResponse));
  }

  void setFromPrice(String fromPrice) {
    updateState((state) => state.copyWith(fromPrice: fromPrice));
  }

  void setToPrice(String toPrice) {
    updateState((state) => state.copyWith(toPrice: toPrice));
  }

  void setPhoneNumber(String phoneNumber) {
    updateState((state) => state.copyWith(
        phone: phoneNumber, validation: phoneNumber.length >= 9));
  }

  void setEmail(String email) {
    log.w("jwndndwflwn");
    updateState((state) => state.copyWith(
        email: email,
        validation:
            RegExp(r'^[\w-]+(\.[\w-]+)*@[\w-]+(\.[\w-]+)+$').hasMatch(email)));
  }

  void setSelectedCurrency(CurrencyResponse currency) {
    updateState((state) => state.copyWith(currenc: currency));
  }

  void setSelectedAddress(UserAddressResponse address) {
    updateState((state) => state.copyWith(address: address));
  }

  // void setUserAddress(UserAddressResponse address) {
  //   display.success("address set");
  //   updateState((state) => state.copyWith(userAddressResponse: address));
  // }

  bool validateFieldData() {
    var isNameValid = (state.state?.name?.isNotEmpty) ?? false;
    var isCategorySelected =
        (state.state?.categoryResponse?.name?.isNotEmpty) ?? false;
    var isDescValid = (state.state?.description?.isNotEmpty) ?? false;
    var isFromPriceValid = (state.state?.fromPrice?.isNotEmpty) ?? false;
    var isToPriceValid = (state.state?.toPrice?.isNotEmpty) ?? false;
    var isCurrencySelected = (state.state?.currenc?.name?.isNotEmpty) ?? false;
    var isEmailValid = (state.state?.email?.isNotEmpty) ?? false;
    var isPhoneValid = (state.state?.phone?.isNotEmpty) ?? false;

    return isNameValid &&
        isCategorySelected &&
        isDescValid &&
        isFromPriceValid &&
        isToPriceValid &&
        isCurrencySelected &&
        isEmailValid &&
        isPhoneValid;
  }

  void setSelectedPaymentTypes(
      List<PaymentTypeResponse>? selectedPaymentTypes) {
    try {
      if (selectedPaymentTypes != null) {
        var paymentTypes = List<PaymentTypeResponse>.from(states.paymentTypes);
        paymentTypes.clear();

        if (selectedPaymentTypes.isNotEmpty) {
          paymentTypes.addAll(selectedPaymentTypes);
          paymentTypes = paymentTypes.toSet().toList();
        }

        updateState((state) => state.copyWith(paymentTypes: paymentTypes));
      }
    } catch (e) {
      log.e(e.toString());
    }
  }

  void setSelectedFreeDelivery(List<District>? districts) {
    try {
      if (districts != null) {
        var selectedDistrict = List<District>.from(states.paymentType);
        selectedDistrict.clear();

        if (districts.isNotEmpty) {
          selectedDistrict.addAll(districts);
          selectedDistrict = selectedDistrict.toSet().toList();
        }
        updateState((state) => state.copyWith(paymentType: selectedDistrict));
      }
    } catch (e) {
      log.e(e.toString());
    }
  }

  void setAutoRenewal(bool isAutoRenewal) {
    updateState((state) => state.copyWith(isAutoRenewal: isAutoRenewal));
  }

  void removeSelectedPaymentType(PaymentTypeResponse paymentType) {
    try {
      var paymentTypes = List<PaymentTypeResponse>.from(states.paymentTypes);
      paymentTypes.remove(paymentType);
      updateState((state) => state.copyWith(paymentTypes: paymentTypes));
    } catch (e) {
      log.e(e.toString());
    }
  }

  Future<void> pickImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      final List<XFile> newImages = await picker.pickMultiImage();

      log.w("pickImageFromGallery result = ${newImages.length}");
      if (newImages.isNotEmpty) {
        List<XFile> addedImages = states.pickedImages != null
            ? List<XFile>.from(states.pickedImages!)
            : [];
        List<XFile> changedImages = [];

        var addedCount = addedImages.length;
        var newCount = newImages.length;
        var maxCount = state.state!.maxImageCount;

        if (addedCount >= maxCount) {
          emitEvent(
            PageEvent(
              PageEventType.onOverMaxCount,
              maxImageCount: states.maxImageCount,
            ),
          );
        }
        if ((addedCount + newCount) > maxCount) {
          emitEvent(
            PageEvent(
              PageEventType.onOverMaxCount,
              maxImageCount: states.maxImageCount,
            ),
          );

          addedImages.addAll(newImages.sublist(0, maxCount - addedCount));
          changedImages.addAll(addedImages);
          updateState((state) => state.copyWith(pickedImages: changedImages));
        } else {
          addedImages.addAll(newImages);
          changedImages.addAll(addedImages);
          updateState((state) => state.copyWith(pickedImages: changedImages));
        }
      }
    } catch (e) {
      log.e(e.toString());
    }
  }

  Future<void> takeImage() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: ImageSource.camera);

      log.w("pickImageFromGallery result = $image");
      if (image != null) {
        List<XFile> imageList = states.pickedImages != null
            ? List<XFile>.from(states.pickedImages!)
            : [];

        imageList.add(image);
        List<XFile> newImageList = [];
        newImageList.addAll(imageList);
        updateState((state) => state.copyWith(pickedImages: newImageList));
      }
    } catch (e) {
      log.e(e.toString());
    }
  }

  void removeImage(String imagePath) {
    try {
      List<XFile> imageList = states.pickedImages != null
          ? List<XFile>.from(states.pickedImages!)
          : [];

      imageList.removeWhere((element) => element.path == imagePath);
      List<XFile> newImageList = [];
      newImageList.addAll(imageList);
      updateState((state) => state.copyWith(pickedImages: newImageList));
    } catch (e) {
      log.e(e.toString());
    }
  }

  void onReorder(int oldIndex, int newIndex) {
    try {
      List<XFile> imageList = states.pickedImages != null
          ? List<XFile>.from(states.pickedImages!)
          : [];

      var item = imageList[oldIndex];
      imageList.removeAt(oldIndex);
      imageList.insert(newIndex, item);

      List<XFile> newImageList = [];
      newImageList.addAll(imageList);
      updateState((state) => state.copyWith(pickedImages: newImageList));
    } catch (e) {
      log.e(e.toString());
    }
  }
}