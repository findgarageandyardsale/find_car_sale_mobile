// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'attachment_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AttachmentModelImpl _$$AttachmentModelImplFromJson(
  Map<String, dynamic> json,
) => _$AttachmentModelImpl(
  id: (json['id'] as num?)?.toInt(),
  file: json['file'] as String?,
  thumbnail: json['thumbnail'] as String?,
  name: json['name'] as String?,
  isInclude: json['is_include'] as bool?,
  mime: json['mime_type'] as String?,
  attachment: readValueForAttachmentID(json, 'attachment') as String?,
);

Map<String, dynamic> _$$AttachmentModelImplToJson(
  _$AttachmentModelImpl instance,
) => <String, dynamic>{
  'id': instance.id,
  'file': instance.file,
  'thumbnail': instance.thumbnail,
  'name': instance.name,
  'is_include': instance.isInclude,
  'mime_type': instance.mime,
  'attachment': instance.attachment,
};
