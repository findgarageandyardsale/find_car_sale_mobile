// ignore_for_file: unrelated_type_equality_checks

import 'dart:developer';
import 'dart:math' as rand;
import 'package:flutter/material.dart';
import 'package:findcarsale/shared/domain/models/attachment_file/attachment_model.dart';
import 'package:findcarsale/shared/domain/models/garage_yard/garage_yard_model.dart';
import 'package:findcarsale/shared/utils/cusotm_date_utils.dart';
import 'package:findcarsale/shared/utils/print_utils.dart';
import 'package:findcarsale/shared/widgets/custom_toast.dart';
import 'package:state_notifier/state_notifier.dart';

class AddDataNotifier extends StateNotifier<Garageayard?> {
  AddDataNotifier() : super(const Garageayard());

  bool isSelected(Category cat) {
    List<Category> categories = state?.category ?? [];
    return categories.contains(cat);
  }

  void manageWholeData(Map<String, dynamic> intitialData) {
    try {
      Map<String, dynamic> data = {};
      Map<String, dynamic> locaionData = {};
      data.addAll(intitialData);

      Garageayard garageayard = state ?? const Garageayard();
      if (data['is_garage'] == true) {
        garageayard = garageayard.copyWith(type: GarageYardType.garage);
      } else {
        garageayard = garageayard.copyWith(type: GarageYardType.yard);
      }

      locaionData.addAll({
        "sub_locality": data['suite_apt'],
        "locality": data['city'],
        "admin_area": data['state'],
        "zip_code": data['zip_code'],
        "throughfare": data['street_number'],
        "latitude": data['latitude'],
        "longitude": data['longitude'],
      });
      garageayard = garageayard.copyWith(
        title: data['title'],
        description: data['description'],
        promoCode: data['promo_code'],
        location: LocationModel.fromJson(locaionData),
        attachments: state?.attachments ?? [],
      );
      state = garageayard;
    } catch (e) {
      log('ManageWholeData Error: ${e.toString()}');
    }
  }

  void initializeEditPost(Garageayard garageayard) {
    if (garageayard.status == StatusEnum.expired) {
      state = garageayard.copyWith(
        availableTimeSlots: updateEditableTimeSlots([]),
      );
      addInitialTimeSlot();
    } else {
      // state = garageayard.copyWith(
      //   availableTimeSlots:
      //       updateEditableTimeSlots(garageayard.availableTimeSlots ?? []),
      // );
      List<AvailableTimeSlot> slots = updateEditableTimeSlots(
        garageayard.availableTimeSlots ?? [],
      );
      // Check updated list

      state = garageayard.copyWith(availableTimeSlots: slots);
    }
  }

  List<AvailableTimeSlot> updateEditableTimeSlots(
    List<AvailableTimeSlot> slots,
  ) {
    // Get today's date without the time
    final today = DateTime.now();

    // Create a new list for updated slots
    List<AvailableTimeSlot> updatedSlots = [];

    // Iterate through each AvailableTimeSlot
    for (var slot in slots) {
      if (slot.date != null) {
        // Extract only the date part, ignore the time
        final slotDate = DateTime(
          slot.date!.year,
          slot.date!.month,
          slot.date!.day,
        );
        slot = slot.copyWith(
          startTime: CustomDateUtils.convertTo12HourFormat(
            slot.startTime ?? '',
          ),
          endTime: CustomDateUtils.convertTo12HourFormat(slot.endTime ?? ''),
        );

        // Check if the slot date is before today
        if (slotDate.isBefore(DateTime(today.year, today.month, today.day))) {
          // If the slot date is before today, set isEditable to true
          slot = slot.copyWith(isEditable: false);
        }
      }

      // Add the modified or unmodified slot back to the list
      updatedSlots.add(slot);
    }

    return updatedSlots;
  }

  void updateCat(Category cat) {
    try {
      // Create a new list of categories to ensure state change
      List<Category> categories = List.from(state?.category ?? []);

      if (categories.contains(cat)) {
        // Remove the category if it's already selected
        categories.removeWhere((element) => element.id == cat.id);
      } else {
        // Add the category if it's not selected
        categories.add(cat);
      }

      // Update the state with a new instance of Garageayard
      state = state?.copyWith(category: categories);
    } catch (e) {
      log('UpdateCat Error: ${e.toString()}');
    }
  }

  void addAttachment(List<AttachmentModel>? attachments) {
    state = state?.copyWith(attachments: [...(attachments ?? [])]);
  }

  void updateStateAttachment({required String? id, required bool isInclude}) {
    try {
      List<AttachmentModel> attachmentsList = [...(state?.attachments ?? [])];
      final updatedList =
          attachmentsList.map((e) {
            if (e.id == id) {
              return e.copyWith(isInclude: isInclude);
            }
            return e;
          }).toList();
      state = state?.copyWith(attachments: updatedList);
    } catch (e) {
      PrintUtils.customLog('Error in Deleteing files$e');
    }
  }

  void removeAttachment({required int? id}) {
    try {
      List<AttachmentModel> attachmentsList = [...(state?.attachments ?? [])];
      attachmentsList.removeWhere((element) => element.id == id);
      state = state?.copyWith(attachments: attachmentsList);
    } catch (e) {
      PrintUtils.customLog('Error in Deleteing files $e');
    }
  }

  void addInitialTimeSlot({DateTime? date}) {
    try {
      final singleSlot = AvailableTimeSlot(
        id: rand.Random.secure().nextInt(1000000),
        date: date ?? DateTime.now(),
        startTime: '09:00 AM',
        endTime: '05:00 PM',
      );
      List<AvailableTimeSlot> slots = [];
      if ((state?.availableTimeSlots ?? []).isEmpty) {
        slots.addAll(state?.availableTimeSlots ?? []);
        slots.add(singleSlot);
        state = state?.copyWith(availableTimeSlots: slots);
      } else {
        AvailableTimeSlot lastSlot = (state?.availableTimeSlots ?? []).last;

        if (lastSlot.startTime != null &&
            lastSlot.endTime != null &&
            lastSlot.startTime != lastSlot.endTime) {
          TimeOfDay startTime = CustomDateUtils.stringToTimeOfDay(
            lastSlot.startTime ?? '',
          );
          TimeOfDay endTime = CustomDateUtils.stringToTimeOfDay(
            lastSlot.endTime ?? '',
          );
          if (CustomDateUtils.isFirstTimeAfter(startTime, endTime) ||
              startTime == endTime) {
            CustomToast.showToast(
              CustomDateUtils.isFirstTimeAfter(startTime, endTime)
                  ? "Start time should always come before end time."
                  : "Start time and end time cannot be the same.",
              status: ToastStatus.error,
            );
          } else {
            slots.addAll(state?.availableTimeSlots ?? []);
            slots.add(singleSlot);
            state = state?.copyWith(availableTimeSlots: slots);
          }
        } else {
          CustomToast.showToast(
            "Please select a valid start time and end time.",
            status: ToastStatus.error,
          );
        }
      }
    } catch (e) {
      log('AddInitialTimeSlot Error: ${e.toString()}');
    }
  }

  void addTimeSlot(AvailableTimeSlot timeSlot) {
    try {
      List<AvailableTimeSlot> slots = state?.availableTimeSlots ?? [];
      slots.add(timeSlot);
      state = state?.copyWith(availableTimeSlots: slots);
    } catch (e) {
      log('AddTimeSlot Error: ${e.toString()}');
    }
  }

  void editTimeSlot(AvailableTimeSlot timeSlot) {
    try {
      List<AvailableTimeSlot> slots = [];
      slots.addAll(state?.availableTimeSlots ?? []);
      AvailableTimeSlot slot = slots.firstWhere(
        (slot) => slot.id == timeSlot.id,
      );
      int index = slots.indexWhere((slot) => slot.id == timeSlot.id);
      slots[index] = slot.copyWith(
        date: timeSlot.date ?? slot.date,
        startTime: timeSlot.startTime ?? slot.startTime,
        endTime: timeSlot.endTime ?? slot.endTime,
      );
      state = state?.copyWith(availableTimeSlots: slots);
    } catch (e) {
      log('EditTimeSlot Error: ${e.toString()}');
    }
  }

  void removeTimeSlot(AvailableTimeSlot timeSlot) {
    try {
      List<AvailableTimeSlot> slots = [];
      slots.addAll(state?.availableTimeSlots ?? []);
      slots.removeWhere((slot) => slot.id == timeSlot.id);
      state = state?.copyWith(availableTimeSlots: slots);
    } catch (e) {
      log('RemoveTimeSlot Error: ${e.toString()}');
    }
  }
}
