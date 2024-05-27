import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:onlinebozor/core/extensions/text_extensions.dart';
import 'package:onlinebozor/core/gen/assets/assets.gen.dart';
import 'package:onlinebozor/core/gen/localization/strings.dart';
import 'package:onlinebozor/domain/models/ad/ad_transaction_type.dart';
import 'package:onlinebozor/domain/models/image/uploadable_file.dart';
import 'package:onlinebozor/presentation/features/common/currency_selection/currency_selection_page.dart';
import 'package:onlinebozor/presentation/features/common/payment_type_selection/payment_type_selection_page.dart';
import 'package:onlinebozor/presentation/features/common/region_and_district_selection/region_and_district_selection_page.dart';
import 'package:onlinebozor/presentation/features/common/user_address_selection/user_address_selection_page.dart';
import 'package:onlinebozor/presentation/router/app_router.dart';
import 'package:onlinebozor/presentation/support/extensions/color_extension.dart';
import 'package:onlinebozor/presentation/support/cubit/base_page.dart';
import 'package:onlinebozor/presentation/support/extensions/controller_exts.dart';
import 'package:onlinebozor/presentation/support/extensions/mask_formatters.dart';
import 'package:onlinebozor/presentation/support/vibrator/vibrator_extension.dart';
import 'package:onlinebozor/presentation/widgets/ad/image_list/ad_image_list_widget.dart';
import 'package:onlinebozor/presentation/widgets/app_bar/default_app_bar.dart';
import 'package:onlinebozor/presentation/widgets/button/custom_elevated_button.dart';
import 'package:onlinebozor/presentation/widgets/chips/chip_item.dart';
import 'package:onlinebozor/presentation/widgets/chips/chip_list.dart';
import 'package:onlinebozor/presentation/widgets/form_field/custom_dropdown_form_field.dart';
import 'package:onlinebozor/presentation/widgets/form_field/custom_text_form_field.dart';
import 'package:onlinebozor/presentation/widgets/form_field/label_text_field.dart';
import 'package:onlinebozor/presentation/widgets/form_field/validator/count_validator.dart';
import 'package:onlinebozor/presentation/widgets/form_field/validator/default_validator.dart';
import 'package:onlinebozor/presentation/widgets/form_field/validator/phone_number_validator.dart';
import 'package:onlinebozor/presentation/widgets/form_field/validator/price_validator.dart';
import 'package:onlinebozor/presentation/widgets/loading/default_error_widget.dart';
import 'package:onlinebozor/presentation/widgets/loading/default_loading_widget.dart';
import 'package:onlinebozor/presentation/widgets/switch/custom_switch.dart';

import 'cubit/create_request_ad_cubit.dart';

@RoutePage()
class CreateRequestAdPage extends BasePage<PageCubit, PageState, PageEvent> {
  CreateRequestAdPage({
    super.key,
    this.adId,
    required this.adTransactionType,
  });

  int? adId;
  final AdTransactionType adTransactionType;

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController fromPriceController = TextEditingController();
  final TextEditingController toPriceController = TextEditingController();
  final TextEditingController contactPersonController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void onWidgetCreated(BuildContext context) {
    cubit(context).setInitialParams(adId, adTransactionType);
  }

  @override
  void onEventEmitted(BuildContext context, PageEvent event) {
    switch (event.type) {
      case PageEventType.onOverMaxCount:
        _showMaxCountError(context, event.maxImageCount);
      case PageEventType.onAdCreated:
        context.router.replace(CreateAdResultRoute(
          adId: cubit(context).states.adId!,
          adTransactionType: cubit(context).states.adTransactionType,
        ));
    }
  }

  @override
  Widget onWidgetBuild(BuildContext context, PageState state) {
    titleController.updateOnRestore(state.title);
    descController.updateOnRestore(state.desc);
    fromPriceController.updateOnRestore(
      priceMaskFormatter.formatInt(state.fromPrice),
    );
    toPriceController.updateOnRestore(
      priceMaskFormatter.formatInt(state.toPrice),
    );
    contactPersonController.updateOnRestore(state.contactPerson);
    phoneController.updateOnRestore(
      phoneMaskFormatter.formatString(state.phone),
    );
    emailController.updateOnRestore(state.email);

    return Scaffold(
      appBar: DefaultAppBar(
        titleText:
            state.isEditing ? Strings.adEditTitle : Strings.adCreateTitle,
        backgroundColor: context.appBarColor,
        onBackPressed: () => context.router.pop(),
      ),
      backgroundColor: context.backgroundColor,
      body: state.isNotPrepared
          ? Container(
              child: state.isPreparingInProcess
                  ? DefaultLoadingWidget(isFullScreen: true)
                  : DefaultErrorWidget(
                      isFullScreen: true,
                      onRetryClicked: () =>
                          cubit(context).getEditingInitialData(),
                    ),
            )
          : SingleChildScrollView(
              physics: BouncingScrollPhysics(),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(height: 20),
                    _buildTitleAndCategoryBlock(context, state),
                    SizedBox(height: 20),
                    _buildImageListBlock(context, state),
                    SizedBox(height: 20),
                    _buildDescAndPriceBlock(context, state),
                    SizedBox(height: 20),
                    _buildContactsBlock(context, state),
                    SizedBox(height: 20),
                    _buildAddressBlock(context, state),
                    SizedBox(height: 20),
                    _buildAutoContinueBlock(context, state),
                    SizedBox(height: 20),
                    _buildFooterBlock(context, state),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ),
    );
  }

  /// Build block methods

  Widget _buildTitleAndCategoryBlock(BuildContext context, PageState state) {
    return Container(
      color: context.cardColor,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        children: [
          LabelTextField(Strings.createAdNameLabel),
          SizedBox(height: 6),
          CustomTextFormField(
            autofillHints: const [AutofillHints.name],
            inputType: TextInputType.name,
            keyboardType: TextInputType.name,
            minLines: 1,
            maxLines: 3,
            hint: Strings.createAdNameLabel,
            textInputAction: TextInputAction.next,
            controller: titleController,
            validator: (value) => NotEmptyValidator.validate(value),
            textCapitalization: TextCapitalization.sentences,
            onChanged: (value) {
              cubit(context).setEnteredTitle(value);
            },
          ),
          SizedBox(height: 16),
          LabelTextField(Strings.createAdCategoryLabel),
          SizedBox(height: 6),
          CustomDropdownFormField(
            value: state.category?.name ?? "",
            hint: Strings.createAdCategoryLabel,
            validator: (value) => NotEmptyValidator.validate(value),
            onTap: () {
              context.router.push(
                NestedCategorySelectionRoute(
                  adType: state.adType,
                  onResult: (category) {
                    cubit(context).setSelectedCategory(category);
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildImageListBlock(BuildContext context, PageState state) {
    return Container(
      color: context.cardColor,
      child: Column(
        children: [
          AdImageListWidget(
            imagePaths: cubit(context).getImages(),
            maxCount: state.maxImageCount,
            validator: (value) => CountValidator.validate(value),
            onTakePhotoClicked: () => cubit(context).takeImage(),
            onPickImageClicked: () => cubit(context).pickImage(),
            onRemoveClicked: (file) => cubit(context).removeImage(file),
            onReorder: (i, j) => cubit(context).onReorder(i, j),
            onImageClicked: (index) async {
              final result = await context.router.push(
                LocaleImageViewerRoute(
                  images: cubit(context).getImages(),
                  initialIndex: index,
                ),
              );

              if (result != null) {
                cubit(context)
                    .setChangedImageList(result as List<UploadableFile>);
              }
            },
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildDescAndPriceBlock(BuildContext context, PageState state) {
    return Column(
      children: [
        Container(
          color: context.cardColor,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 24),
              LabelTextField(Strings.createAdDescLabel, isRequired: false),
              SizedBox(height: 8),
              CustomTextFormField(
                height: null,
                autofillHints: const [AutofillHints.name],
                inputType: TextInputType.name,
                keyboardType: TextInputType.name,
                maxLines: 5,
                minLines: 3,
                hint: Strings.createAdDescHint,
                textInputAction: TextInputAction.next,
                controller: descController,
                textCapitalization: TextCapitalization.sentences,
                onChanged: (value) {
                  cubit(context).setEnteredDesc(value);
                },
              ),
              SizedBox(height: 8),
            ],
          ),
        ),
        SizedBox(height: 4),
        Container(
          color: context.cardColor,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Strings.createAdPriceLabel.w(700).s(16),
              SizedBox(height: 12),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    flex: 5,
                    child: Column(
                      children: [
                        LabelTextField(Strings.createAdFromPriceLabel),
                        SizedBox(height: 6),
                        CustomTextFormField(
                          autofillHints: const [
                            AutofillHints.transactionAmount
                          ],
                          inputType: TextInputType.number,
                          keyboardType: TextInputType.number,
                          maxLines: 1,
                          minLines: 1,
                          hint: "-",
                          textInputAction: TextInputAction.next,
                          controller: fromPriceController,
                          inputFormatters: priceMaskFormatter,
                          validator: (value) => PriceValidator.validate(value),
                          onChanged: (value) {
                            cubit(context).setEnteredFromPrice(value);
                          },
                        )
                      ],
                    ),
                  ),
                  SizedBox(width: 16),
                  Flexible(
                    flex: 5,
                    child: Column(
                      children: [
                        LabelTextField(Strings.createAdToPriceLabel),
                        SizedBox(height: 6),
                        CustomTextFormField(
                          autofillHints: const [
                            AutofillHints.transactionAmount
                          ],
                          inputType: TextInputType.number,
                          keyboardType: TextInputType.number,
                          maxLines: 1,
                          minLines: 1,
                          hint: "-",
                          textInputAction: TextInputAction.next,
                          controller: toPriceController,
                          inputFormatters: priceMaskFormatter,
                          validator: (value) => PriceValidator.validate(value),
                          onChanged: (value) {
                            cubit(context).setEnteredToPrice(value);
                          },
                        )
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Flexible(
                    flex: 5,
                    child: Column(
                      children: [
                        LabelTextField(Strings.createAdCurrencyLabel),
                        SizedBox(height: 6),
                        CustomDropdownFormField(
                          value: state.currency?.name ?? "",
                          hint: "-",
                          validator: (value) =>
                              NotEmptyValidator.validate(value),
                          onTap: () async {
                            final currency = await showModalBottomSheet(
                              context: context,
                              isScrollControlled: true,
                              useSafeArea: true,
                              backgroundColor: Colors.transparent,
                              builder: (context) => CurrencySelectionPage(
                                initialSelectedItem: state.currency,
                              ),
                            );
                            cubit(context).setSelectedCurrency(currency);
                          },
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 16),
                  Flexible(
                    flex: 5,
                    child: Container(),
                  ),
                ],
              ),
              SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  CustomSwitch(
                    isChecked: state.isAgreedPrice,
                    onChanged: (value) {
                      cubit(context).setAgreedPrice(value);
                    },
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: Strings.createAdNegotiableLabel.w(400).s(14),
                  ),
                ],
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
        SizedBox(height: 4),
        Container(
          color: context.cardColor,
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              LabelTextField(
                Strings.createAdPaymentTypeLabel,
                isRequired: true,
              ),
              SizedBox(height: 16),
              ChipList(
                chips: _buildPaymentTypeChips(context, state),
                isShowAll: true,
                isShowChildrenCount: false,
                validator: (value) => CountValidator.validate(value),
                onClickedAdd: () async {
                  final paymentTypes = await showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    useSafeArea: true,
                    backgroundColor: Colors.transparent,
                    builder: (context) => PaymentTypeSelectionPage(
                      selectedPaymentTypes: state.paymentTypes,
                    ),
                  );
                  cubit(context).setSelectedPaymentTypes(paymentTypes);
                },
                onClickedShowLess: () {},
                onClickedShowMore: () {},
              ),
              SizedBox(height: 24),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildContactsBlock(BuildContext context, PageState state) {
    return Container(
      color: context.cardColor,
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8),
          Strings.createAdContactInfoLabel.w(700).s(16),
          SizedBox(height: 12),
          LabelTextField(Strings.createAdContactPersonLabel),
          SizedBox(height: 8),
          CustomTextFormField(
            autofillHints: const [AutofillHints.name],
            keyboardType: TextInputType.name,
            maxLines: 1,
            hint: Strings.createAdContactPersonLabel,
            inputType: TextInputType.name,
            textInputAction: TextInputAction.next,
            controller: contactPersonController,
            validator: (value) => NotEmptyValidator.validate(value),
            textCapitalization: TextCapitalization.words,
            onChanged: (value) {
              cubit(context).setEnteredContactPerson(value);
            },
          ),
          SizedBox(height: 12),
          LabelTextField(Strings.createAdContactPhoneLabel),
          SizedBox(height: 8),
          CustomTextFormField(
            autofillHints: const [AutofillHints.telephoneNumber],
            keyboardType: TextInputType.phone,
            maxLines: 1,
            hint: Strings.commonPhoneNumber,
            prefixText: "+998",
            inputType: TextInputType.phone,
            textInputAction: TextInputAction.next,
            controller: phoneController,
            inputFormatters: phoneMaskFormatter,
            validator: (value) => PhoneNumberValidator.validate(value),
            onChanged: (value) {
              cubit(context).setEnteredPhone(value);
            },
          ),
          SizedBox(height: 12),
          LabelTextField(Strings.commonEmail, isRequired: false),
          SizedBox(height: 8),
          CustomTextFormField(
            autofillHints: const [AutofillHints.email],
            keyboardType: TextInputType.emailAddress,
            inputType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            hint: Strings.commonEmail,
            maxLines: 1,
            controller: emailController,
            onChanged: (value) {
              cubit(context).setEnteredEmail(value);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildAddressBlock(BuildContext context, PageState state) {
    return Container(
      color: context.cardColor,
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8),
          Strings.createAdAddressesInfoLabel.w(700).s(16),
          SizedBox(height: 20),
          LabelTextField(Strings.createAdAddressLabel),
          SizedBox(height: 8),
          CustomDropdownFormField(
            value: state.address?.name ?? "",
            hint: Strings.createAdAddressLabel,
            validator: (value) => NotEmptyValidator.validate(value),
            onTap: () async {
              final address = await showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                useSafeArea: true,
                backgroundColor: Colors.transparent,
                builder: (context) => UserAddressSelectionPage(
                  selectedAddress: state.address,
                ),
              );

              cubit(context).setSelectedAddress(address);
            },
          ),
          SizedBox(height: 16),
          LabelTextField(Strings.createAdSearchAddressLabel),
          SizedBox(height: 8),
          ChipList(
            chips: _buildRequestAddressChips(context, state),
            isShowAll: state.isShowAllRequestDistricts,
            validator: (value) => CountValidator.validate(value),
            onClickedAdd: () {
              _showSelectionRequestAddress(context, state);
            },
            onClickedShowLess: () => cubit(context).showHideRequestDistricts(),
            onClickedShowMore: () => cubit(context).showHideRequestDistricts(),
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildAutoContinueBlock(BuildContext context, PageState state) {
    return Container(
      color: context.cardColor,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Strings.createAdAutoRenewLabel.w(600).s(14),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomSwitch(
                  isChecked: state.isAutoRenewal,
                  onChanged: (value) {
                    cubit(context).setAutoRenewal(value);
                  },
                ),
                SizedBox(width: 16),
                Expanded(
                  child: (state.isAutoRenewal
                          ? Strings.createAdAutoRenewOnDesc
                          : Strings.createAdAutoRenewOffDesc)
                      .w(400)
                      .s(14),
                ),
              ],
            ),
            SizedBox(height: 6),
          ],
        ),
      ),
    );
  }

  Widget _buildFooterBlock(BuildContext context, PageState state) {
    return Container(
      color: context.cardColor,
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(width: 16),
              Assets.images.icRequiredField.svg(),
              SizedBox(width: 8),
              Expanded(
                child: Strings.createAdRequiredFieldsLabel.w(300).s(13),
              ),
            ],
          ),
          SizedBox(height: 16),
          CustomElevatedButton(
            text: Strings.commonSave,
            onPressed: () {
              vibrateAsHapticFeedback();
              if (_formKey.currentState!.validate()) {
                cubit(context).createOrUpdateRequestAd();
              }
            },
            isLoading: state.isRequestSending,
          ),
        ],
      ),
    );
  }

  List<Widget> _buildPaymentTypeChips(BuildContext context, PageState state) {
    return state.paymentTypes
        .map(
          (element) => ChipItem(
            item: element,
            title: element.name ?? "",
            onActionClicked: (item) {
              cubit(context).removeSelectedPaymentType(element);
            },
          ),
        )
        .toList();
  }

  List<Widget> _buildRequestAddressChips(
      BuildContext context, PageState state) {
    return state.requestDistricts
        .map(
          (element) => ChipItem(
            item: element,
            title: element.name,
            onChipClicked: (item) =>
                _showSelectionRequestAddress(context, state),
            onActionClicked: (item) => cubit(context).removeAddress(item),
          ),
        )
        .toList();
  }

  Future<void> _showSelectionRequestAddress(
    BuildContext context,
    PageState state,
  ) async {
    final districts = await showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (context) => RegionAndDistrictSelectionPage(
        initialSelectedDistricts: state.requestDistricts,
      ),
    );
    cubit(context).setFreeDeliveryDistricts(districts);
  }

  Future<void> _showMaxCountError(BuildContext context, int maxCount) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button to close the dialog
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          // title: Text('Alert!'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Strings.imageListMaxCountError(
                  max_count: maxCount,
                ).s(14),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Strings.closeTitle.s(14),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
          ],
        );
      },
    );
  }
}