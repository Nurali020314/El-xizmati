import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:onlinebozor/common/colors/color_extension.dart';
import 'package:onlinebozor/common/extensions/text_extensions.dart';
import 'package:onlinebozor/common/gen/assets/assets.gen.dart';
import 'package:onlinebozor/common/widgets/common/chips_add_item.dart';
import 'package:onlinebozor/common/widgets/common/chips_item.dart';
import 'package:onlinebozor/common/widgets/common/custom_dropdown_field.dart';
import 'package:onlinebozor/common/widgets/common/label_text_field.dart';
import 'package:onlinebozor/common/widgets/dashboard/app_diverder.dart';
import 'package:onlinebozor/common/widgets/image/image_ad_list_widget.dart';
import 'package:onlinebozor/common/widgets/switch/custom_switch.dart';
import 'package:onlinebozor/common/widgets/switch/custom_toggle.dart';
import 'package:onlinebozor/presentation/common/selection_currency/page.dart';
import 'package:onlinebozor/presentation/common/selection_unit/page.dart';
import 'package:onlinebozor/presentation/common/selection_user_address/page.dart';
import 'package:onlinebozor/presentation/common/selection_user_warehouse/page.dart';

import '../../../../../common/core/base_page.dart';
import '../../../../../common/gen/localization/strings.dart';
import '../../../../../common/widgets/common/common_text_field.dart';
import '../../../common/router/app_router.dart';
import '../../../common/widgets/common/common_button.dart';
import '../../common/selection_address/page.dart';
import '../../common/selection_payment_type/page.dart';
import '../../utils/mask_formatters.dart';
import 'cubit/page_cubit.dart';

@RoutePage()
class CreateProductAdPage extends BasePage<PageCubit, PageState, PageEvent> {
  CreateProductAdPage({super.key});

  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController warehouseController = TextEditingController();
  final TextEditingController priceController = TextEditingController();

  final TextEditingController contactPersonController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  @override
  void onEventEmitted(BuildContext context, PageEvent event) {
    switch (event.type) {
      case PageEventType.onOverMaxCount:
        _showMaxCountError(context, event.maxImageCount);
    }
  }

  @override
  Widget onWidgetBuild(BuildContext context, PageState state) {
    // priceController =
    //     TextEditingController(text: currencyFormatter.format(text));

    return Scaffold(
      appBar: _buildAppBar(context),
      backgroundColor: Color(0xFFF2F4FB),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SizedBox(height: 12),
            _buildTitleAndCategoryBlock(context, state),
            SizedBox(height: 12),
            _buildImageListBlock(context, state),
            SizedBox(height: 16),
            _buildDescAndPriceBlock(context, state),
            SizedBox(height: 16),
            _buildAdditionalInfoBlock(context, state),
            SizedBox(height: 16),
            _buildContactsBlock(context, state),
            SizedBox(height: 16),
            _buildDeliveryBlock(context, state),
            SizedBox(height: 16),
            _buildAutoContinueBlock(context, state),
            SizedBox(height: 16),
            _buildPinMySocialAccountsBlock(context, state),
            SizedBox(height: 16),
            _buildFooterBlock(context, state),
            SizedBox(height: 24),
          ],
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: Assets.images.icArrowLeft.svg(),
        onPressed: () => context.router.pop(),
      ),
      elevation: 0.5,
      backgroundColor: Colors.white,
      centerTitle: true,
      bottomOpacity: 1,
      title: Strings.adCreateTitle.w(500).s(16).c(context.colors.textPrimary),
    );
  }

  /// Build block methods

  Widget _buildTitleAndCategoryBlock(
    BuildContext context,
    PageState state,
  ) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        children: [
          LabelTextField(text: 'Название товара'),
          SizedBox(height: 6),
          CommonTextField(
            autofillHints: const [AutofillHints.name],
            inputType: TextInputType.name,
            keyboardType: TextInputType.name,
            minLines: 1,
            maxLines: 3,
            hint: 'Название товара',
            textInputAction: TextInputAction.next,
            controller: titleController,
            onChanged: (value) {
              cubit(context).setEnteredTitle(value);
            },
          ),
          SizedBox(height: 16),
          LabelTextField(text: 'Категория'),
          SizedBox(height: 6),
          CustomDropdownField(
            text: state.category?.name ?? "",
            hint: "Категория",
            onTap: () {
              context.router.push(
                SelectionNestedCategoryRoute(onResult: (categoryResponse) {
                  cubit(context).setSelectedCategory(categoryResponse);
                }),
              );
            },
            // onTap: () async {
            // final category = await showModalBottomSheet(
            //   context: context,
            //   isScrollControlled: true,
            //   useSafeArea: true,
            //   backgroundColor: Colors.transparent,
            //   builder: (context) => SelectionCategoryPage(
            //     key: Key(""),
            //     initialSelectedItem: state.category,
            //   ),
            // );
            //
            // cubit(context).setSelectedCategory(category);
            // },
          ),
        ],
      ),
    );
  }

  Widget _buildImageListBlock(
    BuildContext context,
    PageState state,
  ) {
    return Container(
      color: Colors.white,
      child: Column(
        children: [
          ImageAdListWidget(
            imagePaths: cubit(context).getImages(),
            maxCount: state.maxImageCount,
            onTakePhotoClicked: () {
              cubit(context).takeImage();
            },
            onPickImageClicked: () {
              cubit(context).pickImage();
            },
            onImageClicked: (index) async {
              final result = await context.router.push(
                LocaleImageViewerRoute(
                  images: cubit(context).getImages(),
                  initialIndex: index,
                ),
              );

              if (result != null) {
                cubit(context).setChangedImageList(result as List<XFile>);
              }
            },
            onRemoveClicked: (imagePath) {
              cubit(context).removeImage(imagePath);
            },
            onReorder: (oldIndex, newIndex) {
              cubit(context).onReorder(oldIndex, newIndex);
            },
          ),
          SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildDescAndPriceBlock(
    BuildContext context,
    PageState state,
  ) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          LabelTextField(text: 'Описание товара'),
          SizedBox(height: 6),
          CommonTextField(
            height: null,
            autofillHints: const [AutofillHints.name],
            inputType: TextInputType.name,
            keyboardType: TextInputType.name,
            maxLines: 5,
            minLines: 3,
            hint:
                'Подумайте, какие подробности вы хотели бы узнать из объявления. И добавьте их в описание',
            textInputAction: TextInputAction.next,
            controller: descController,
            onChanged: (value) {
              cubit(context).setEnteredDesc(value);
            },
          ),
          SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                flex: 5,
                child: Column(
                  children: [
                    LabelTextField(text: 'Кол-во на складе'),
                    SizedBox(height: 6),
                    CommonTextField(
                      autofillHints: const [AutofillHints.telephoneNumber],
                      inputType: TextInputType.number,
                      keyboardType: TextInputType.number,
                      maxLines: 1,
                      minLines: 1,
                      hint: '-',
                      textInputAction: TextInputAction.next,
                      controller: warehouseController,
                      inputFormatters: quantityMaskFormatter,
                      onChanged: (value) {
                        cubit(context).setEnteredWarehouseCount(value);
                      },
                    )
                  ],
                ),
              ),
              SizedBox(width: 16),
              Flexible(
                  flex: 4,
                  child: Column(
                    children: [
                      LabelTextField(text: 'Тип', isRequired: false),
                      SizedBox(height: 6),
                      CustomDropdownField(
                        text: state.unit?.name ?? "",
                        hint: "-",
                        onTap: () async {
                          final unit = await showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            useSafeArea: true,
                            backgroundColor: Colors.transparent,
                            builder: (context) => SelectionUnitPage(
                              key: Key(""),
                              selectedUnit: state.unit,
                            ),
                          );

                          cubit(context).setSelectedUnit(unit);
                        },
                      ),
                    ],
                  ))
            ],
          ),
          SizedBox(height: 16),
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(
                flex: 5,
                child: Column(
                  children: [
                    LabelTextField(text: 'Цена'),
                    SizedBox(height: 6),
                    CommonTextField(
                      autofillHints: const [AutofillHints.transactionAmount],
                      inputType: TextInputType.number,
                      keyboardType: TextInputType.number,
                      maxLines: 1,
                      minLines: 1,
                      hint: '-',
                      textInputAction: TextInputAction.next,
                      controller: priceController,
                      inputFormatters: amountMaskFormatter,
                      onChanged: (value) {
                        cubit(context).setEnteredPrice(value);
                      },
                    )
                  ],
                ),
              ),
              SizedBox(width: 16),
              Flexible(
                flex: 4,
                child: Column(
                  children: [
                    LabelTextField(text: 'Валюта', isRequired: false),
                    SizedBox(height: 6),
                    CustomDropdownField(
                      text: state.currency?.name ?? "",
                      hint: "-",
                      onTap: () async {
                        // _showCurrencyBottomSheet(context);
                        final currency = await showModalBottomSheet(
                          context: context,
                          isScrollControlled: true,
                          useSafeArea: true,
                          backgroundColor: Colors.transparent,
                          builder: (context) => SelectionCurrencyPage(
                            key: Key(""),
                            initialSelectedItem: state.currency,
                          ),
                        );

                        cubit(context).setSelectedCurrency(currency);
                      },
                    ),
                  ],
                ),
              )
            ],
          ),
          SizedBox(height: 8),
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
                child: "Договорная".w(400).s(14).c(Color(0xFF41455E)),
              ),
            ],
          ),
          SizedBox(height: 24),
          LabelTextField(text: 'Способ оплаты', isRequired: true),
          SizedBox(height: 16),
          Wrap(
            direction: Axis.horizontal,
            spacing: 8,
            runSpacing: 8,
            alignment: WrapAlignment.start,
            crossAxisAlignment: WrapCrossAlignment.start,
            runAlignment: WrapAlignment.start,
            children: _buildPaymentTypeChips(context, state),
          ),
        ],
      ),
    );
  }

  Widget _buildAdditionalInfoBlock(
    BuildContext context,
    PageState state,
  ) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8),
          "Дополнительная информация".w(700).s(16).c(Color(0xFF41455E)),
          SizedBox(height: 20),
          LabelTextField(text: "Бизнес или личное", isRequired: false),
          SizedBox(height: 8),
          CustomToggle(
            width: 240,
            isChecked: state.isBusiness,
            onChanged: (isChecked) {
              cubit(context).setIsBusiness(isChecked);
            },
            negativeTitle: "Личное",
            positiveTitle: "Бизнес",
          ),
          SizedBox(height: 16),
          LabelTextField(text: "Состояние", isRequired: false),
          SizedBox(height: 8),
          CustomToggle(
            width: 240,
            isChecked: state.isNew,
            onChanged: (isChecked) {
              cubit(context).setIsNew(isChecked);
            },
            negativeTitle: "Б / У",
            positiveTitle: "Новый",
          ),
        ],
      ),
    );
  }

  Widget _buildContactsBlock(
    BuildContext context,
    PageState state,
  ) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8),
          "Контактная информация".w(700).s(16).c(Color(0xFF41455E)),
          SizedBox(height: 20),
          LabelTextField(text: "Местоположение"),
          SizedBox(height: 8),
          CustomDropdownField(
            text: state.address?.name ?? "",
            hint: "Местоположение",
            onTap: () async {
              final address = await showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                useSafeArea: true,
                backgroundColor: Colors.transparent,
                builder: (context) => SelectionUserAddressPage(
                  key: Key(""),
                  selectedAddress: state.address,
                ),
              );

              cubit(context).setSelectedAddress(address);
            },
          ),
          SizedBox(height: 12),
          "Контактное лицо".w(500).s(14).c(Color(0xFF41455E)),
          SizedBox(height: 8),
          CommonTextField(
            autofillHints: const [AutofillHints.name],
            keyboardType: TextInputType.name,
            maxLines: 1,
            hint: 'Контактное лицо',
            inputType: TextInputType.name,
            textInputAction: TextInputAction.next,
            controller: contactPersonController,
            onChanged: (value) {
              cubit(context).setEnteredContactPerson(value);
            },
          ),
          SizedBox(height: 12),
          "Номер телефона".w(500).s(14).c(Color(0xFF41455E)),
          SizedBox(height: 8),
          CommonTextField(
            autofillHints: const [AutofillHints.telephoneNumber],
            keyboardType: TextInputType.phone,
            maxLines: 1,
            hint: '',
            prefixText: "+998 ",
            inputType: TextInputType.phone,
            textInputAction: TextInputAction.next,
            controller: phoneController,
            // inputFormatters: phoneMaskFormatter,
            onChanged: (value) {
              cubit(context).setEnteredPhone(value);
            },
          ),
          SizedBox(height: 12),
          "Эл. почта".w(500).s(14).c(Color(0xFF41455E)),
          SizedBox(height: 8),
          CommonTextField(
            autofillHints: const [AutofillHints.email],
            keyboardType: TextInputType.emailAddress,
            inputType: TextInputType.emailAddress,
            textInputAction: TextInputAction.next,
            hint: "Эл. почта",
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

  Widget _buildDeliveryBlock(
    BuildContext context,
    PageState state,
  ) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 8),
          "Способы приема".w(700).s(16).c(Color(0xFF41455E)),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomSwitch(
                isChecked: state.isPickupEnabled,
                onChanged: (value) {
                  cubit(context).setPickupEnabling(value);
                },
              ),
              SizedBox(width: 16),
              Expanded(
                child: "Самовывоз с адреса".w(400).s(15).c(Color(0xFF41455E)),
              ),
            ],
          ),
          SizedBox(height: 8),
          Visibility(
            visible: state.isPickupEnabled,
            child: Wrap(
              direction: Axis.horizontal,
              spacing: 8,
              runSpacing: 8,
              alignment: WrapAlignment.start,
              crossAxisAlignment: WrapCrossAlignment.start,
              runAlignment: WrapAlignment.start,
              children: _buildPickupAddressChips(context, state),
            ),
          ),
          SizedBox(height: 10),
          AppDivider(thickness: 1),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomSwitch(
                isChecked: state.isFreeDeliveryEnabled,
                onChanged: (value) {
                  cubit(context).setFreeDeliveryEnabling(value);
                },
              ),
              SizedBox(width: 16),
              Expanded(
                child: "Бесплатная доставка".w(400).s(14).c(Color(0xFF41455E)),
              ),
            ],
          ),
          SizedBox(height: 8),
          Visibility(
            visible: state.isFreeDeliveryEnabled,
            child: Wrap(
              direction: Axis.horizontal,
              spacing: 8,
              runSpacing: 8,
              alignment: WrapAlignment.start,
              crossAxisAlignment: WrapCrossAlignment.start,
              runAlignment: WrapAlignment.start,
              children: _buildPaymentTypeChips(context, state),
            ),
          ),
          SizedBox(height: 10),
          AppDivider(thickness: 1),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomSwitch(
                isChecked: state.isPaidDeliveryEnabled,
                onChanged: (value) {
                  cubit(context).setPaidDeliveryEnabling(value);
                },
              ),
              SizedBox(width: 16),
              Expanded(
                child: "Платная доставка".w(400).s(14).c(Color(0xFF41455E)),
              ),
            ],
          ),
          SizedBox(height: 8),
          Visibility(
            visible: state.isPaidDeliveryEnabled,
            child: Wrap(
              direction: Axis.horizontal,
              spacing: 8,
              runSpacing: 8,
              alignment: WrapAlignment.start,
              crossAxisAlignment: WrapCrossAlignment.start,
              runAlignment: WrapAlignment.start,
              children: _buildPaymentTypeChips(context, state),
            ),
          ),
          SizedBox(height: 6),
        ],
      ),
    );
  }

  Widget _buildAutoContinueBlock(
    BuildContext context,
    PageState state,
  ) {
    return Container(
      color: Colors.white,
      child: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            "Автопродление".w(600).s(14).c(Color(0xFF41455E)),
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
                  child: "Объявление будет деактивировано через 15 дней"
                      .w(400)
                      .s(14)
                      .c(Color(0xFF41455E)),
                ),
              ],
            ),
            SizedBox(height: 6),
          ],
        ),
      ),
    );
  }

  Widget _buildPinMySocialAccountsBlock(
    BuildContext context,
    PageState state,
  ) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          "Мои соц. сети".w(600).s(14).c(Color(0xFF41455E)),
          SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              CustomSwitch(
                isChecked: state.isShowMySocialAccount,
                onChanged: (value) {
                  cubit(context).setShowMySocialAccounts(value);
                },
              ),
              SizedBox(width: 16),
              Expanded(
                child: "Показать мои соц. сети на описание товара"
                    .w(400)
                    .s(14)
                    .c(Color(0xFF41455E)),
              ),
            ],
          ),
          SizedBox(height: 6),
        ],
      ),
    );
  }

  Widget _buildFooterBlock(
    BuildContext context,
    PageState state,
  ) {
    return Container(
      color: Colors.white,
      padding: EdgeInsets.all(16),
      child: Column(
        children: [
          Row(
            children: [
              SizedBox(width: 16),
              Assets.images.icRequiredField.svg(),
              SizedBox(width: 8),
              Expanded(
                child: "Необходимо заполнить все поля отмеченный звездочкой "
                    .w(300)
                    .s(13)
                    .c(context.colors.textSecondary),
              ),
            ],
          ),
          SizedBox(height: 16),
          CommonButton(
            color: context.colors.buttonPrimary,
            onPressed: () {
              cubit(context).sendCreateProductAdRequest();
            },
            // enabled: false,
            loading: state.isRequestSending,
            child: Container(
              height: 52,
              alignment: Alignment.center,
              width: double.infinity,
              child: Strings.commonContinueTitle
                  .w(500)
                  .s(14)
                  .c(context.colors.textPrimaryInverse),
            ),
          ),
        ],
      ),
    );
  }

  List<Widget> _buildPaymentTypeChips(
    BuildContext context,
    PageState state,
  ) {
    List<Widget> chips = [];
    chips.add(
      ChipsAddItem(
        onAddClicked: () async {
          final paymentTypes = await showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            useSafeArea: true,
            backgroundColor: Colors.transparent,
            builder: (context) => SelectionPaymentTypePage(
              key: Key(""),
              selectedPaymentTypes: state.paymentTypes,
            ),
          );
          cubit(context).setSelectedPaymentTypes(paymentTypes);
        },
      ),
    );
    chips.addAll(state.paymentTypes
        .map(
          (element) => ChipsItem(
            item: element,
            title: element.name ?? "",
            onRemoveClicked: (item) {
              cubit(context).removeSelectedPaymentType(element);
            },
          ),
        )
        .toList());
    return chips;
  }

  List<Widget> _buildPickupAddressChips(BuildContext context, PageState state) {
    List<Widget> chips = [];
    chips.add(
      ChipsAddItem(
        onAddClicked: () async {
          final pickupAddresses = await showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            useSafeArea: true,
            backgroundColor: Colors.transparent,
            builder: (context) => SelectionUserWarehousePage(
              key: Key(""),
              selectedItems: state.pickupAddresses,
            ),
          );

          cubit(context).setSelectedPickupAddresses(pickupAddresses);
        },
      ),
    );
    chips.addAll(state.pickupAddresses
        .map(
          (element) => ChipsItem(
            item: element,
            title: element.name ?? "",
            onRemoveClicked: (item) {
              cubit(context).removeSelectedPickupAddress(element);
            },
          ),
        )
        .toList());
    return chips;
  }

  List<Widget> _buildDeliveryForFree(BuildContext context, PageState state) {
    List<Widget> chips = [];
    chips.add(
      ChipsAddItem(
        onAddClicked: () async {
          final paymentTypes = await showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            useSafeArea: true,
            backgroundColor: Colors.transparent,
            builder: (context) => SelectionAddressPage(
              key: Key(""),
              selectedPaymentTypes: state.items,
            ),
          );
          cubit(context).setSelectedDeleveryForFree(paymentTypes);
        },
      ),
    );
    chips.addAll(state.paymentType
        .map(
          (element) => ChipsItem(
            item: element,
            title: element.name ?? "",
            onRemoveClicked: (item) {
              cubit(context).removeSelectedDeliveryForFree(element);
            },
          ),
        )
        .toList());
    return chips;
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