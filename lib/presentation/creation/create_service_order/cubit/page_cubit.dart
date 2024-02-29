import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../common/core/base_cubit.dart';
import '../../../../data/responses/address/user_address_response.dart';
import '../../../../data/responses/category/category/category_response.dart';
import '../../../../data/responses/currencies/currency_response.dart';
import '../../../../data/responses/payment_type/payment_type_response.dart';

part 'page_cubit.freezed.dart';

part 'page_state.dart';

@Injectable()
class PageCubit extends BaseCubit<PageState, PageEvent> {
  PageCubit() : super(const PageState());

  void setName(String name) {
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
    updateState((state) => state.copyWith(phone: phoneNumber));
  }

  void setEmail(String email) {
    updateState((state) => state.copyWith(email: email));
  }

  void setSelectedCurrency(CurrencyResponse currency) {
    updateState((state) => state.copyWith(currenc: currency));
  }

  void setSelectedAddress(UserAddressResponse address) {
    updateState((state) => state.copyWith(address: address));
  }

  void setSelectedPaymentTypes(
      List<PaymentTypeResponse>? selectedPaymentTypes,
      ) {
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

  void removeSelectedPaymentType(PaymentTypeResponse paymentType) {
    try {
      var paymentTypes = List<PaymentTypeResponse>.from(states.paymentTypes);
      paymentTypes.remove(paymentType);
      updateState((state) => state.copyWith(paymentTypes: paymentTypes));
    } catch (e) {
      log.e(e.toString());
    }
  }

  void setAutoRenewal(bool isAutoRenewal) {
    updateState((state) => state.copyWith(isAutoRenewal: isAutoRenewal));
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
              PageEventType.success,
              maxImageCount: states.maxImageCount,
            ),
          );
        }
        if ((addedCount + newCount) > maxCount) {
          emitEvent(
            PageEvent(
              PageEventType.success,
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
