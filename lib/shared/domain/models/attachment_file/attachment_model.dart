// ignore_for_file: invalid_annotation_target
import 'package:freezed_annotation/freezed_annotation.dart';

part 'attachment_model.freezed.dart';
part 'attachment_model.g.dart';

@freezed
class AttachmentModel with _$AttachmentModel {
  factory AttachmentModel({
    int? id,
    String? file,
    String? thumbnail,
    String? name,
   @JsonKey(name: 'is_include')  bool? isInclude,
    @JsonKey(name: 'mime_type') String? mime,
    @JsonKey(readValue: readValueForAttachmentID) String? attachment,
  }) = _AttachmentModel;

  factory AttachmentModel.fromJson(Map<String, dynamic> json) =>
      _$AttachmentModelFromJson(json);
}

AttachmentModel? setAttachment(val) {
  if (val == null) {
    return val;
  } else {
    if (val is String) {
      return AttachmentModel(id: int.parse(val));
    } else {
      return AttachmentModel.fromJson(val);
    }
  }
}

List<AttachmentModel>? setListAttachement(val) {
  return val == null
      ? null
      : (val as List).map((e) => setAttachment(e)!).toList();
}

String? readValueForAttachmentID(Map map, String key) =>
    map[key] ?? map['attachment_id'];
