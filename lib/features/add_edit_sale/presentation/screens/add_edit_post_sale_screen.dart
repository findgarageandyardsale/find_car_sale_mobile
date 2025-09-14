import 'dart:developer';

import 'package:auto_route/auto_route.dart';
import 'package:findcarsale/features/add_edit_sale/presentation/provider/warranty_state_provider%20copy.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:findcarsale/attachment_builder/provider/custom_attachment_provider.dart';
import 'package:findcarsale/features/add_edit_sale/presentation/widgets/category_selector.dart';
import 'package:findcarsale/features/add_edit_sale/presentation/widgets/year_picker.dart';
import 'package:findcarsale/features/authentication/presentation/widgets/auth_field.dart';
import 'package:findcarsale/services/capitalize_word_formatter_service.dart';
import 'package:findcarsale/shared/constants/spacing.dart';
import 'package:findcarsale/shared/domain/models/garage_yard/garage_yard_model.dart';
import 'package:findcarsale/shared/domain/models/response_data.dart';
import 'package:findcarsale/shared/extension/context.dart';
import 'package:findcarsale/shared/utils/helper_constant.dart';
import 'package:findcarsale/shared/utils/print_utils.dart';
import 'package:findcarsale/shared/widgets/action_button.dart';
import 'package:findcarsale/shared/widgets/custom_loading.dart';
import 'package:findcarsale/shared/widgets/custom_toast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:uuid/uuid.dart';
import '../../../../services/stripe_service.dart';
import '../../../../shared/globals.dart';
import '../../../../shared/presentation/formz_state.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/widgets/custom_bottomsheet.dart';
import '../provider/add_data_provider.dart';
import '../provider/add_state_provider.dart';
import '../provider/car_condition_provider.dart';
import '../provider/car_state_condition_state_provider.dart';
import 'package:findcarsale/shared/widgets/custom_radio_button.dart';
import '../widgets/image_screen.dart';
import '../widgets/sale_timing.dart';
import '../widgets/title_head.dart';

@RoutePage()
class AddEditPostSaleScreen extends ConsumerStatefulWidget {
  const AddEditPostSaleScreen({super.key, this.garageayard});
  final Garageayard? garageayard;

  @override
  ConsumerState<AddEditPostSaleScreen> createState() =>
      _AddPostSaleScreenState();
}

class _AddPostSaleScreenState extends ConsumerState<AddEditPostSaleScreen> {
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descController = TextEditingController();
  final TextEditingController streetNumberController = TextEditingController();
  final TextEditingController suiteController = TextEditingController();
  final TextEditingController cityController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController zipCodeController = TextEditingController();
  final TextEditingController promoCodeController = TextEditingController();
  final TextEditingController modelController = TextEditingController();
  final TextEditingController brandController = TextEditingController();
  final TextEditingController yearController = TextEditingController();
  final TextEditingController milesController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final formKey = GlobalKey<FormBuilderState>();

  bool isGarage = true;

  @override
  void initState() {
    super.initState();
    titleController.text = widget.garageayard?.title ?? '';
    descController.text = widget.garageayard?.description ?? '';
    streetNumberController.text =
        widget.garageayard?.location?.throughfare ??
        widget.garageayard?.location?.subThoroughfare ??
        '';
    suiteController.text = widget.garageayard?.location?.subLocality ?? '';
    cityController.text = widget.garageayard?.location?.locality ?? '';
    stateController.text = widget.garageayard?.location?.adminArea ?? '';
    zipCodeController.text = widget.garageayard?.location?.zipCode ?? '';
    milesController.text = widget.garageayard?.miles?.toString() ?? '';
    modelController.text = widget.garageayard?.model ?? '';
    brandController.text = widget.garageayard?.brand ?? '';
    yearController.text = widget.garageayard?.year?.toString() ?? '';
    phoneNumberController.text = widget.garageayard?.phoneNumber ?? '';
    promoCodeController.text = widget.garageayard?.promoCode ?? '';

    // Add listeners to the controllers to clear validation errors

    titleController.addListener(() {
      if (formKey.currentState?.fields['title']?.hasError ?? false) {
        formKey.currentState?.fields['title']?.validate();
      }
    });
    descController.addListener(() {
      if (formKey.currentState?.fields['description']?.hasError ?? false) {
        formKey.currentState?.fields['description']?.validate();
      }
    });
    streetNumberController.addListener(() {
      if (formKey.currentState?.fields['street_number']?.hasError ?? false) {
        formKey.currentState?.fields['street_number']?.validate();
      }
    });

    suiteController.addListener(() {
      if (formKey.currentState?.fields['suite_apt']?.hasError ?? false) {
        formKey.currentState?.fields['suite_apt']?.validate();
      }
    });
    cityController.addListener(() {
      if (formKey.currentState?.fields['city']?.hasError ?? false) {
        formKey.currentState?.fields['city']?.validate();
      }
    });
    stateController.addListener(() {
      if (formKey.currentState?.fields['state']?.hasError ?? false) {
        formKey.currentState?.fields['state']?.validate();
      }
    });
    zipCodeController.addListener(() {
      if (formKey.currentState?.fields['zip_code']?.hasError ?? false) {
        formKey.currentState?.fields['zip_code']?.validate();
      }
    });
    Future.microtask(() {
      ref.invalidate(addDataNotifierProvider);

      if (widget.garageayard != null) {
        if (widget.garageayard?.type == GarageYardType.garage) {
          setState(() {
            isGarage = true;
          });
        } else {
          setState(() {
            isGarage = false;
          });
        }
        ref
            .read(addDataNotifierProvider.notifier)
            .initializeEditPost(widget.garageayard!);

        ref
            .read(customAttachmentProvider('image').notifier)
            .addAttachmentofServer(widget.garageayard?.attachments);
      }
      ref
          .read(warrantyStateNotifierProvider.notifier)
          .updateWarrantyCondition(widget.garageayard?.warranty);
      ref
          .read(carStateConditionNotifierProvider.notifier)
          .updateCarCondition(widget.garageayard?.isNew);
    });
  }

  @override
  Widget build(BuildContext context) {
    final addCatdata = ref.watch(addDataNotifierProvider);

    final state = ref.watch(carconditionNotifierProvider);
    ref.watch(addCarConditionNotifierProvider);
    final addState = ref.watch(addNotifierProvider);
    ref.watch(customAttachmentProvider('image'));
    final imageLoadingState = ref.watch(loadingFilesProvider('image'));

    void proceedToPaymentFunction() async {
      try {
        final model = ref.read(addNotifierProvider.notifier).postData;

        final postPrice =
            (HelperConstant.priceForEach *
                (model?.availableTimeSlots ?? []).length);
        HelperConstant.postPrice =
            (postPrice == 0
                    ? (model?.price ?? HelperConstant.fixPrice)
                    : postPrice)
                .toString();
        PrintUtils.customLog(HelperConstant.postPrice.toString());
        PrintUtils.customLog(postPrice.toString());
        PrintUtils.customLog('>>>>>>>>>>>>>>>>>>>>>');
        // String uuid = Uuid().v4();

        String? transactionId = Uuid().v4();
        // String? transactionId = await StripeService.instance.makePayment();
        Navigator.of(context).pop();

        if ((transactionId ?? '').isNotEmpty) {
          if (widget.garageayard == null) {
            ref
                .read(addNotifierProvider.notifier)
                .addGarageSale(transactionId: transactionId!);
          } else {
            ref
                .read(addNotifierProvider.notifier)
                .updateGarageSale(transactionId: transactionId!);
          }
        } else {
          CustomToast.showToast('Payment Failed', status: ToastStatus.error);
        }
      } catch (e) {
        CustomToast.showToast('Payment Failed', status: ToastStatus.error);
      }
    }

    void paymentprocess() {
      primaryBottomSheet(
        context,
        child: SafeArea(
          child: Column(
            children: [
              Text(
                'Make your CAR SALE Event Live!',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  color: AppColors.primary,
                ),
              ),
              Text(
                'Save Your TIME & ENERGY by not posting physical Car Sale signs on poles and streets.\n',
                textAlign: TextAlign.center,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
              ),
              Text(
                'Make your Sale live simply by showing your presence Online by paying \$5.00',
                textAlign: TextAlign.center,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
              ),
              Text(
                'You can post up to 10 events in advance',
                textAlign: TextAlign.center,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
              ),

              // Text(
              //   'Make your Garage or Yard Sale Event live by simply paying \$${HelperConstant.priceForEach}.00 for each sale date.\n\nYour total is \$${HelperConstant.postPrice}.00.',
              //   textAlign: TextAlign.center,
              //   style: Theme.of(context)
              //       .textTheme
              //       .titleMedium
              //       ?.copyWith(fontWeight: FontWeight.w700),
              // ),
              Spacing.sizedBoxH_20(),
              ActionButton(
                width: double.infinity,
                label: 'Proceed to Payment',
                onPressed: () {
                  proceedToPaymentFunction();
                },
              ),
            ],
          ),
        ),
      );
    }

    Map<String, dynamic> convertDynamicToMap(dynamic data) {
      if (data is Map<String, dynamic>) {
        return data;
      } else {
        throw Exception('Data is not a Map<String, dynamic>');
      }
    }

    ref.listen(addNotifierProvider.select((value) => value), ((previous, next) {
      //show Snackbar on failure
      if (next is Failure) {
        ref.read(addNotifierProvider.notifier).initState();
        CustomToast.showToast(
          next.exception.message.toString(),
          status: ToastStatus.error,
        );
      } else if (next is Success) {
        ref.read(addNotifierProvider.notifier).initState();
        final currentData = convertDynamicToMap(
          (next.data as ResponseData).data,
        );
        //check if status is expired

        if (currentData.isEmpty) {
          Navigator.of(context).pop(true);
          if (widget.garageayard != null) {
            /// ref.read(addNotifierProvider.notifier).updateGarageSale(
            //   transactionId: transactionId!,
            // );
            CustomToast.showToast(
              'Post Updated Successfully',
              status: ToastStatus.success,
            );
          } else {
            showDialog(
              context: context,
              builder:
                  (context) => AlertDialog(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    insetPadding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 24,
                    ),
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          'Post added Successfully',
                          style: Theme.of(
                            context,
                          ).textTheme.headlineSmall!.copyWith(
                            color: AppColors.tertiary,
                            height: 1.43,
                            fontWeight: FontWeight.w700,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        Spacing.sizedBoxH_12(),
                        Text(
                          '* Your Car Sale event is now live!',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                        Spacing.sizedBoxH_08(),
                        Text(
                          '* Reach your potential customers Easily and Conveniently',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                        Spacing.sizedBoxH_08(),
                        Text(
                          '* You can manage or update your listing anytime to change date or time. Once event is posted and paid, upon cancellation of any posted event, there will be no refund or fee paid.',
                          textAlign: TextAlign.center,
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.w700),
                        ),
                        Spacing.sizedBoxH_20(),
                        ActionButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          label: 'Continue',
                        ),
                      ],
                    ),
                  ),
            );
          }
        } else {
          try {
            paymentprocess();
          } catch (_) {}
        }
      }
    }));

    ref.listen(addCarConditionNotifierProvider.select((value) => value), ((
      previous,
      next,
    ) {
      //show Snackbar on failure
      if (next is Failure) {
        CustomToast.showToast(
          next.exception.message.toString(),
          status: ToastStatus.error,
        );
      } else if (next is Success) {
        ref.read(carconditionNotifierProvider.notifier).fetchAllCatList();

        // change the next into Category object
        CarCondition item = CarCondition.fromJson(next.data);
        ref.read(addDataNotifierProvider.notifier).updateCat(item);

        CustomToast.showToast(
          'Category Added Successfully',
          status: ToastStatus.success,
        );
      }
    }));

    String title = widget.garageayard != null ? 'Update' : 'Post';

    void editFunction() {
      ref
          .read(addNotifierProvider.notifier)
          .updateGarageSale(transactionId: widget.garageayard?.transactionId);
    }

    Map<String, dynamic> convertEmptyStringsToNull(Map<String, dynamic> data) {
      data.forEach((key, value) {
        if (value is String && value.isEmpty) {
          data[key] = null;
        }
      });
      return data;
    }

    return CustomLoadingOverlay(
      isLoading: addState is Loading,
      child: context.doublePos(
        isGarage: isGarage,
        isActive: null,
        statusText: '$title Car Sale',
        onPosPressed:
            imageLoadingState
                ? null
                : () async {
                  try {
                    final isNew =
                        ref
                            .read(carStateConditionNotifierProvider.notifier)
                            .state;
                    final isWarranty =
                        ref.read(warrantyStateNotifierProvider.notifier).state;
                    PrintUtils.customLog(isNew.toString());
                    FocusScope.of(context).unfocus();
                    if (formKey.currentState?.saveAndValidate() ?? false) {
                      if ((ref.read(addDataNotifierProvider)?.attachments ?? [])
                          .isEmpty) {
                        CustomToast.showToast(
                          'Please add atleast one image',
                          status: ToastStatus.error,
                        );
                        return;
                      }

                      ref.read(addNotifierProvider.notifier).loadingState();
                      Map<String, dynamic> currentData = {};
                      currentData.addAll({
                        'is_new': isNew,

                        'warranty': isWarranty,
                      });
                      final data = formKey.currentState?.value;
                      if (data != null) {
                        currentData.addAll(data);
                      }
                      List<Location> locations = [];
                      try {
                        locations = await locationFromAddress(
                          '${currentData['street_number']}, ${currentData['city']}, ${currentData['state']} ${currentData['zip_code']}',
                        );
                      } catch (e) {
                        log('LocationFromAddress Error: ${e.toString()}');
                      }
                      if (locations.isNotEmpty) {
                        Location location = locations.first;
                        double latitude = location.latitude;
                        double longitude = location.longitude;
                        currentData.addAll({
                          "latitude": latitude,
                          "longitude": longitude,
                        });
                      }
                      currentData = convertEmptyStringsToNull(currentData);
                      PrintUtils.customLog(currentData.toString());
                      PrintUtils.customLog('-------////----------------');
                      ref
                          .read(addDataNotifierProvider.notifier)
                          .manageWholeData(currentData);
                      PrintUtils.customLog(
                        (widget.garageayard?.status == StatusEnum.expired)
                            .toString(),
                      );

                      if (widget.garageayard == null ||
                          widget.garageayard?.status == StatusEnum.expired) {
                        ///[ Process is for validation]

                        if (widget.garageayard != null) {
                          ref
                              .read(addNotifierProvider.notifier)
                              .updateGarageSale(
                                transactionId:
                                    HelperConstant.isPaymentRequired
                                        ? null
                                        : Uuid().v4(),
                              );
                        } else {
                          ref
                              .read(addNotifierProvider.notifier)
                              .addGarageSale();
                        }
                        /*
///[Payment Process is only after validation]
                    paymentprocess();
                    */
                      } else {
                        editFunction();
                      }
                    } else {
                      CustomToast.showToast(
                        'Please fill all the fields',
                        status: ToastStatus.error,
                      );
                    }
                  } catch (_) {
                    ref.read(addNotifierProvider.notifier).initState();
                  }
                },
        appbar: AppBar(
          backgroundColor:
              isGarage ? AppColors.surfaceLight : AppColors.softColor,
          title: Text(
            '$title Car Sale',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
          ),
          leading: BackButton(
            onPressed: () {
              ref.invalidate(addDataNotifierProvider);
              ref.invalidate(carconditionNotifierProvider);
              Navigator.of(context).pop();
            },
          ),
        ),
        content: Container(
          color: AppColors.white,
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: FormBuilder(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const TitleHead(
                      title: 'Add Image',
                      subtitle: 'Upload up to max 10 images of your item',
                    ),
                    Spacing.sizedBoxH_08(),
                    const ImageScreen(),
                    Spacing.sizedBoxH_30(),

                    AuthField(
                      name: 'title',
                      hintText: 'Title*',
                      labelText: 'Title*',
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                          errorText: 'Title cannot be empty.',
                        ),
                      ]),
                      controller: titleController,
                      inputFormatters: [
                        CapitalizeWordsInputFormatter(),
                      ], // Apply the custom TextInputFormatter
                    ),
                    Spacing.sizedBoxH_16(),
                    AuthField(
                      name: 'description',
                      hintText: 'Brief Description*',
                      labelText: 'Brief Description*',
                      controller: descController,
                      maxlines: 4,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                          errorText: 'Description cannot be empty.',
                        ),
                      ]),
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.multiline,
                    ),
                    Spacing.sizedBoxH_20(),
                    Consumer(
                      builder: (context, ref, child) {
                        final carConditionNotifier = ref.read(
                          carStateConditionNotifierProvider.notifier,
                        );
                        final carCondition = ref.watch(
                          carStateConditionNotifierProvider,
                        );

                        return CustomRadioGroup<bool>(
                          value: carCondition,
                          onChanged: (value) {
                            carConditionNotifier.updateCarCondition(value);
                          },
                          direction: Axis.horizontal,
                          options: const [
                            CustomRadioOption(value: true, title: 'New'),
                            CustomRadioOption(value: false, title: 'Used'),
                          ],
                        );
                      },
                    ),

                    Spacing.sizedBoxH_20(),
                    AuthField(
                      name: 'model',
                      hintText: 'Model*',
                      labelText: 'Model*',
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                          errorText: 'Model cannot be empty.',
                        ),
                      ]),
                      controller: modelController,
                      // Apply the custom TextInputFormatter
                    ),
                    Spacing.sizedBoxH_20(),
                    AuthField(
                      name: 'brand',
                      hintText: 'Brand*',
                      labelText: 'Brand*',
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                          errorText: 'Brand cannot be empty.',
                        ),
                      ]),
                      controller: brandController,
                      // Apply the custom TextInputFormatter
                    ),
                    Spacing.sizedBoxH_20(),
                    CustomYearPicker(
                      name: 'year',
                      hintText: 'Year*',
                      labelText: 'Year*',
                      validator: [
                        FormBuilderValidators.required(
                          errorText: 'Year cannot be empty.',
                        ),
                      ],
                      controller: yearController,
                    ),
                    Spacing.sizedBoxH_20(),
                    AuthField(
                      name: 'miles',
                      hintText: 'Current Mileage*',
                      labelText: 'Current Mileage*',
                      keyboardType: TextInputType.numberWithOptions(
                        decimal: true,
                        signed: false,
                      ),
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                          errorText: 'Current Mileage cannot be empty.',
                        ),
                      ]),
                      controller: milesController,
                      // Apply the custom TextInputFormatter
                    ),

                    Spacing.sizedBoxH_20(),
                    TitleHead(title: 'Any Warranty?'),
                    Consumer(
                      builder: (context, ref, child) {
                        final warrantyConditionNotifier = ref.read(
                          warrantyStateNotifierProvider.notifier,
                        );
                        final warrantyCondition = ref.watch(
                          warrantyStateNotifierProvider,
                        );

                        return CustomRadioGroup<bool>(
                          value: warrantyCondition,
                          onChanged: (value) {
                            warrantyConditionNotifier.updateWarrantyCondition(
                              value,
                            );
                          },
                          direction: Axis.horizontal,
                          options: const [
                            CustomRadioOption(value: true, title: 'Yes'),
                            CustomRadioOption(value: false, title: 'No'),
                          ],
                        );
                      },
                    ),

                    Spacing.sizedBoxH_20(),
                    /////
                    state.when(
                      initial: () {
                        return const SizedBox.shrink();
                      },
                      success: (categories) {
                        List<CarCondition> cats =
                            (categories as List<dynamic>)
                                .map(
                                  (category) => CarCondition.fromJson(category),
                                )
                                .toList();
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            TitleHead(
                              title: 'Condition',

                              // clearWidget:
                              //  TextButton.icon(
                              //   // padding: EdgeInsets.zero,
                              //   onPressed: () {
                              //     final controller = TextEditingController();
                              //     primaryBottomSheet(
                              //       context,
                              //       child: Column(
                              //         children: [
                              //           AuthField(
                              //             autoFocus: true,
                              //             name: 'condition',
                              //             hintText: 'Condition',
                              //             labelText: 'Condition',
                              //             controller: controller,
                              //           ),
                              //           Spacing.sizedBoxH_12(),
                              //           ActionButton(
                              //             width: double.infinity,
                              //             label: 'Add Condition',
                              //             onPressed: () {
                              //               if (controller.text.isNotEmpty) {
                              //                 ref
                              //                     .read(
                              //                       addCarConditionNotifierProvider
                              //                           .notifier,
                              //                     )
                              //                     .addCateggory(
                              //                       controller.text,
                              //                     );

                              //                 Navigator.of(context).pop();
                              //               }
                              //             },
                              //           ),
                              //         ],
                              //       ),
                              //     );
                              //   },
                              //   icon: const Icon(Icons.add),
                              //   label: Text(
                              //     'Add Condition',
                              //     style: Theme.of(context).textTheme.labelLarge
                              //         ?.copyWith(color: AppColors.primary),
                              //   ),
                              // ),
                            ),
                            CarConditionSelector(cats: cats, isSingle: true),
                            Spacing.sizedBoxH_20(),
                          ],
                        );
                      },
                      loading: () {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            const TitleHead(title: 'Category'),
                            Wrap(
                              runSpacing: 16.0,
                              spacing: 12.0,
                              children:
                                  [1, 2, 3, 4, 5, 6]
                                      .map(
                                        (e) => Container(
                                              width: 120.0,
                                              height: 40.0,
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(8),
                                              ),
                                            )
                                            .animate(
                                              onPlay:
                                                  (controller) =>
                                                      controller.repeat(),
                                            )
                                            .shimmer(
                                              color: Colors.grey.shade300,
                                              duration: const Duration(
                                                seconds: 2,
                                              ),
                                            ),
                                      )
                                      .toList(),
                            ),
                            Spacing.sizedBoxH_20(),
                          ],
                        );
                      },
                      failure: (error) => const SizedBox.shrink(),
                    ),

                    Text(
                      'Address',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Spacing.sizedBoxH_08(),
                    AuthField(
                      name: 'street_number',
                      hintText: 'Street Name*',
                      labelText: 'Street Name*',
                      textInputAction: TextInputAction.next,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                          errorText: 'Street Name cannot be empty.',
                        ),
                      ]),
                      keyboardType: TextInputType.text,
                      onChanged: (value) {},
                      inputFormatters: [
                        CapitalizeWordsInputFormatter(),
                      ], // Apply the custom TextInputFormatter

                      controller: streetNumberController,
                    ),
                    Spacing.sizedBoxH_16(),
                    AuthField(
                      name: 'suite_apt',
                      hintText: 'Suite/Apt',
                      labelText: 'Suite/Apt',
                      textInputAction: TextInputAction.next,
                      validator: FormBuilderValidators.compose([
                        // FormBuilderValidators.required(
                        //     errorText: 'Suite/Apt cannot be empty.'),
                      ]),
                      keyboardType: TextInputType.text,
                      onChanged: (value) {},
                      controller: suiteController,
                    ),
                    Spacing.sizedBoxH_16(),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: AuthField(
                            name: 'city',
                            hintText: 'City*',
                            labelText: 'City*',
                            inputFormatters: [CapitalizeWordsInputFormatter()],
                            textInputAction: TextInputAction.next,
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(
                                errorText: 'City cannot be empty.',
                              ),
                            ]),
                            keyboardType: TextInputType.text,
                            onChanged: (value) {},
                            controller: cityController,
                          ),
                        ),
                        Spacing.sizedBoxW_12(),
                        Expanded(
                          child: AuthField(
                            name: 'state',
                            hintText: 'State*',
                            labelText: 'State*',
                            readOnly: true,
                            onTap: () {
                              primaryBottomSheet(
                                context,
                                child: SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * 0.7,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Select State',
                                        style: Theme.of(
                                          context,
                                        ).textTheme.titleMedium?.copyWith(
                                          fontWeight: FontWeight.w700,
                                        ),
                                      ),
                                      Expanded(
                                        child: ListView.builder(
                                          itemCount: usStates.length,
                                          shrinkWrap: true,
                                          itemBuilder: (context, index) {
                                            return ListTile(
                                              contentPadding: EdgeInsets.zero,
                                              title: Text(
                                                '${usStates[index]['name']!} (${usStates[index]['abbreviation']!})',
                                              ),
                                              onTap: () {
                                                stateController.text =
                                                    usStates[index]['abbreviation']!;
                                                Navigator.pop(context);
                                              },
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            textInputAction: TextInputAction.next,
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(
                                errorText: 'State cannot be empty.',
                              ),
                            ]),
                            keyboardType: TextInputType.text,
                            onChanged: (value) {},
                            controller: stateController,
                          ),
                        ),
                      ],
                    ),
                    Spacing.sizedBoxH_16(),
                    AuthField(
                      name: 'zip_code',
                      hintText: 'Zip Code*',
                      labelText: 'Zip Code*',
                      textInputAction: TextInputAction.next,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                          errorText: 'Zip Code cannot be empty.',
                        ),
                      ]),
                      keyboardType: TextInputType.number,
                      onChanged: (value) {},
                      controller: zipCodeController,
                    ),
                    Spacing.sizedBoxH_24(),
                    Text(
                      'Contact Information',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Spacing.sizedBoxH_08(),
                    AuthField(
                      name: 'phone_number',
                      hintText: 'Phone Number',
                      labelText: 'Phone Number',
                      textInputAction: TextInputAction.next,
                      validator: FormBuilderValidators.compose([
                        FormBuilderValidators.required(
                          errorText: 'Phone Number is empty.',
                        ),
                        FormBuilderValidators.match(
                          RegExp(
                            r'^(?:\+1\s?)?(\([2-9][0-9]{2}\)|[2-9][0-9]{2})[-\.\s]?[0-9]{3}[-\.\s]?[0-9]{4}$',
                          ),
                          errorText: 'Invalid American Phone Number',
                        ),
                      ]),
                      keyboardType: TextInputType.phone,
                      onChanged: (value) {
                        if (formKey
                                .currentState
                                ?.fields['phone_number']
                                ?.hasError ??
                            false) {
                          formKey.currentState?.fields['phone_number']
                              ?.validate();
                        }
                      },
                      controller: phoneNumberController,
                    ),
                    Spacing.sizedBoxH_24(),
                    const TitleHead(
                      title: 'Promo Code',
                      subtitle: 'You can add a promo code to your sale',
                    ),
                    Spacing.sizedBoxH_12(),
                    AuthField(
                      name: 'promo_code',
                      hintText: 'Promo Code',
                      labelText: 'Promo Code',
                      textInputAction: TextInputAction.next,
                      keyboardType: TextInputType.text,
                      onChanged: (value) {},
                      controller: promoCodeController,
                    ),
                    Spacing.sizedBoxH_24(),
                    SaleTiming(
                      isGarage: isGarage,
                      totalSlot:
                          (widget.garageayard?.availableTimeSlots ?? []).length,
                    ),
                    Spacing.sizedBoxH_30(),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  customtabDesign(final String text, final bool isActive, final bool isGarage) {
    return Row(
      crossAxisAlignment:
          CrossAxisAlignment
              .center, // Ensures the Row sizes itself based on its children
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (isActive)
          Icon(
            Icons.check,
            color: isActive ? AppColors.white : AppColors.black,
          ),
        if (isActive) Spacing.sizedBoxW_08(),
        Text(
          text,
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
            color:
                isActive
                    ? AppColors.white
                    : isGarage
                    ? AppColors.tertiary
                    : AppColors.secondary,
          ),
        ),
      ],
    );
  }
}
