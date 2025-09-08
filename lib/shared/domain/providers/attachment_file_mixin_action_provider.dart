// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:dio/dio.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:findcarsale/features/account/domain/providers/attachment_file_provider.dart';
import 'package:findcarsale/shared/domain/models/attachment_file/attachment_model.dart';
import 'package:findcarsale/shared/exceptions/http_exception.dart';
import 'package:findcarsale/shared/mixins/file_picker_mixin.dart';
import 'package:findcarsale/shared/presentation/formz_state.dart';
import 'package:findcarsale/shared/utils/print_utils.dart';
import 'package:findcarsale/shared/widgets/custom_toast.dart';
import 'package:http_parser/http_parser.dart';
import 'package:mime/mime.dart';
import 'package:path/path.dart';

class AttachmentFileMixinActionProvider
    extends StateNotifier<FormzState<List<AttachmentModel>?>>
    with FilePickerMixin {
  AttachmentFileMixinActionProvider(this.ref)
    : super(const FormzState.initial());

  initState() {
    state = const FormzState.initial();
  }

  Ref ref;
  Future<List<File>> pickFile({
    bool isCamera = true,
    bool allowMultiple = true,
    FileType type = FileType.any,
  }) async {
    final listData =
        isCamera
            ? (await getCameraImageFiles() ?? [])
            : (await getFiles(allowMultiple: allowMultiple, type: type) ?? []);
    return listData;
  }

  Future<void> pickFileAndUpload({
    bool isCamera = true,
    bool allowMultiple = true,
    FileType type = FileType.any,
  }) async {
    final listData =
        isCamera
            ? (await getCameraImageFiles() ?? [])
            : (await getFiles(allowMultiple: allowMultiple, type: type) ?? []);
    uploadFile(listData: listData);
  }

  ///takes file path and looks for mime type
  AttachmentModel changeToAttachmentFile({required String filePath}) {
    try {
      final mimeType = lookupMimeType(filePath) ?? '';

      return AttachmentModel(
        file: filePath,
        // file: "data:" + mimeType + ";base64," + doc,
        name: basename(filePath),
        mime: mimeType,
      );
    } catch (e) {
      CustomToast.showToast(
        'Error Converting Image',
        status: ToastStatus.error,
      );
      return AttachmentModel();
    }
  }

  String getFileNameAttachmentModel(AttachmentModel file) {
    String fileName = file.name ?? '';
    if (fileName.length > 95) {
      fileName =
          fileName.substring(0, 40) +
          fileName.substring(fileName.length - 40, fileName.length);
    }
    final mimeTypeData = lookupMimeType(file.file!)?.split('/');
    if ((mimeTypeData ?? []).isNotEmpty) {
      final dataType =
          mimeTypeData?.length == 2 ? mimeTypeData![1] : mimeTypeData![0];
      if (!fileName.contains('.')) {
        fileName = '$fileName.$dataType';
      }
    }

    return fileName;
  }

  Future<FormData> changeToFormDataMultiPartAction(
    List<AttachmentModel> data,
  ) async {
    var formData = FormData();
    for (var file in data) {
      final mimeTypeData = lookupMimeType(file.file!)?.split('/');
      final fileName = getFileNameAttachmentModel(file);

      formData.files.addAll([
        MapEntry(
          'files',
          await MultipartFile.fromFile(
            file.file!,
            filename: fileName,
            contentType:
                (mimeTypeData ?? []).isNotEmpty
                    ? MediaType(mimeTypeData?[0] ?? '', mimeTypeData?[1] ?? '')
                    : null,
          ),
        ),
      ]);
      formData.fields.add(MapEntry('name', fileName));
    }

    return formData;
  }

  List<AttachmentModel> convertDataToAttachmentModel(List result) {
    return (result).map<AttachmentModel>((e) {
      String fileName = e['name'] ?? '';
      final extBeginIndex = fileName.lastIndexOf('.');
      final ext = fileName.substring(extBeginIndex + 1);
      return AttachmentModel.fromJson(
        e as Map<String, dynamic>,
      ).copyWith(mime: ext);
    }).toList();
  }

  Future<void> uploadFile({required List<File> listData}) async {
    try {
      state = const FormzState.loading();
      List<AttachmentModel> uploadAttach = [];
      for (var element in listData) {
        uploadAttach.add(changeToAttachmentFile(filePath: element.path));
      }
      final formData = await changeToFormDataMultiPartAction(uploadAttach);
      final response = await ref
          .read(attachmentFileRepositoryProvider)
          .uploadAttachment(map: formData);
      state = await response.fold((failure) => FormzState.failure(failure), (
        response,
      ) async {
        try {
          final responseData = response.data;
          final data = responseData['data'] ?? responseData.data;
          final result = convertDataToAttachmentModel(data);
          return FormzState.success(data: result);
        } catch (e) {
          PrintUtils.customLog(e.toString());
        }
        return FormzState.failure(CacheFailureException());
      });
    } catch (_) {
      state = FormzState.failure(CacheFailureException());
    }
  }
}

///intializing attachment provider
final attachmentFileProvider = AutoDisposeStateNotifierProvider<
  AttachmentFileMixinActionProvider,
  FormzState<List<AttachmentModel>?>
>((ref) => AttachmentFileMixinActionProvider(ref));
