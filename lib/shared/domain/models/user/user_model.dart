// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:findcarsale/shared/domain/models/attachment_file/attachment_model.dart';
import 'package:findcarsale/shared/domain/models/garage_yard/garage_yard_model.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
class User with _$User {
  const factory User({
    @JsonKey(readValue: readValueForID) int? userId,
    String? username,
    String? password,
    String? email,
    @JsonKey(name: 'first_name') String? firstName,
    @JsonKey(name: 'last_name') String? lastName,
    @JsonKey(name: 'notification') bool? notification,
    String? images,
    @JsonKey(name: 'phone_number') String? phoneNumber,
    String? token,
    @JsonKey(name: 'location') LocationModel? address,
    @JsonKey(readValue: readValueForProfileImage) AttachmentModel? profile,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}

int? readValueForID(Map map, String key) =>
    map[key] ?? map['user_id'] ?? map['id'];
Map<String, dynamic>? readValueForProfileImage(Map map, String key) =>
    map[key] ?? map['profile_picture'] ?? map['image'];
