import 'dart:convert';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:findcarsale/shared/domain/models/garage_yard/garage_yard_model.dart';
import 'package:findcarsale/shared/exceptions/http_exception.dart';
import 'package:findcarsale/shared/presentation/formz_state.dart';
import 'package:findcarsale/shared/utils/helper_constant.dart';
import 'package:findcarsale/shared/utils/print_utils.dart';
import 'package:findcarsale/shared/widgets/custom_toast.dart';
import 'package:uuid/uuid.dart';
import '../../../../../shared/utils/cusotm_date_utils.dart';
import '../../../data/repositories/add_garage_repository.dart';

class AddNotifier extends StateNotifier<FormzState> {
  final AddGarageRepository addRepository;
  final Garageayard? postData;

  AddNotifier({required this.addRepository, required this.postData})
    : super(const FormzState.initial());

  void initState() {
    state = const FormzState.initial();
  }

  void loadingState() {
    state = const FormzState.initial();
  }

  Future<void> addGarageSale({String? transactionId}) async {
    try {
      state = const FormzState.loading();

      List<AvailableTimeSlot> timeSlots = [];
      timeSlots.addAll(postData?.availableTimeSlots ?? []);

      List<Map<String, dynamic>> availableTimeSlots =
          convertAvailableTimeSlotListToJson(timeSlots);

      final postPrice =
          (HelperConstant.priceForEach *
              (postData?.availableTimeSlots ?? []).length);

      HelperConstant.postPrice =
          (postPrice == 0
                  ? (postData?.price ?? HelperConstant.fixPrice)
                  : postPrice)
              .toString();

      Map<String, dynamic> data = postData!.toJson();
      data['condition'] = postData?.condition?.id;
      data['price'] = postPrice;
      data['name'] = postData?.title;
      data['status'] = 'Active';
      data['available_time_slots'] = availableTimeSlots;

      // if (transactionId != null) {
      data['transaction_id'] =
          HelperConstant.isPaymentRequired ? transactionId : Uuid().v4();
      // } else {
      //   data['transaction_id'] = null;
      // }
      data['images'] = postData?.attachments?.map((e) => e.id).toList();

      final response = await addRepository.addGaragePost(singleItem: data);

      state = await response.fold((failure) => FormzState.failure(failure), (
        data,
      ) {
        return FormzState.success(data: data);
      });
    } catch (e) {
      CustomToast.showToast(e.toString(), status: ToastStatus.error);
      state = FormzState.failure(
        AppException(
          message: e.toString(),
          statusCode: 600,
          identifier: 'try catch error',
        ),
      );
    }
  }

  Future<void> updateGarageSale({String? transactionId}) async {
    try {
      state = const FormzState.loading();
      List<AvailableTimeSlot> timeSlots = [];
      timeSlots.addAll(postData?.availableTimeSlots ?? []);

      List<Map<String, dynamic>> availableTimeSlots =
          convertAvailableTimeSlotListToJson(timeSlots);

      Map<String, dynamic> data = postData!.toJson();
      final postPrice =
          (HelperConstant.priceForEach *
              (postData?.availableTimeSlots ?? []).length);

      HelperConstant.postPrice =
          (postPrice == 0
                  ? (postData?.price ?? HelperConstant.fixPrice)
                  : postPrice)
              .toString();
      data['condition'] = postData?.condition?.id;
      data['price'] = postPrice;
      data['name'] = postData?.title;

      data['transaction_id'] =
          HelperConstant.isPaymentRequired
              ? transactionId
              : transactionId ?? Uuid().v4();
      // if (transactionId != null) {
      //   data['transaction_id'] = transactionId;
      // } else {
      //   data['transaction_id'] = null;
      // }
      //Just for testing
      // data['status'] = 'Expired';
      data['status'] = 'Active';
      data['available_time_slots'] = availableTimeSlots;
      data['images'] = postData?.attachments?.map((e) => e.id).toList();

      PrintUtils.customLog(jsonEncode(data));
      final response = await addRepository.editGaragePost(
        singleItem: data,
        id: postData!.id!,
      );

      state = await response.fold((failure) => FormzState.failure(failure), (
        data,
      ) {
        return FormzState.success(data: data);
      });
    } catch (e) {
      CustomToast.showToast(e.toString(), status: ToastStatus.error);
      state = FormzState.failure(
        AppException(
          message: e.toString(),
          statusCode: 600,
          identifier: 'try catch error',
        ),
      );
    }
  }

  /*Future<void> paymentGarageSale({String? transactionId}) async {
    try {
      Map<String, dynamic> data = postData!.toJson();
      if (postData?.id != null) {
        if (transactionId != null) {
          data['transaction_id'] = transactionId;
        }
        data['status'] = 'Active';
        data['is_garage'] = postData?.type == GarageYardType.garage;
        data['garage_and_yard'] = postData?.id;
        PrintUtils.customLog(jsonEncode(data));
        final response = await addRepository.payementForGaragePost(
          singleItem: data,
          id: postData!.id!,
        );

        state = await response.fold(
          (failure) => FormzState.failure(failure),
          (data) {
            return FormzState.success(data: data);
          },
        );
      }
    } catch (e) {
      CustomToast.showToast(e.toString(), status: ToastStatus.error);
      state = FormzState.failure(
        AppException(
          message: e.toString(),
          statusCode: 600,
          identifier: 'try catch error',
        ),
      );
    }
  }
*/
  List<Map<String, dynamic>> convertAvailableTimeSlotListToJson(
    List<AvailableTimeSlot> timeSlots,
  ) {
    return timeSlots.map((timeSlot) {
      return {
        'id': timeSlot.id,
        'date': CustomDateUtils.formatDateFilter(
          timeSlot.date ?? DateTime.now(),
        ),
        'start_time': CustomDateUtils.convertTo24HourFormat(
          timeSlot.startTime ?? '',
        ), // Convert start time
        'end_time': CustomDateUtils.convertTo24HourFormat(
          timeSlot.endTime ?? '',
        ), // Convert end time
        'garage_yard_id': timeSlot.garageYardId,
      };
    }).toList();
  }
}
