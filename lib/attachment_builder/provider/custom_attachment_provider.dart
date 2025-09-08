import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:findcarsale/shared/domain/models/attachment_file/attachment_model.dart';
import 'package:findcarsale/shared/utils/image_utils.dart';
import 'package:findcarsale/shared/widgets/custom_toast.dart';
import 'package:http_parser/http_parser.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:mime/mime.dart';
import 'package:file_picker/file_picker.dart';
import 'package:path/path.dart';

import '../../features/account/domain/providers/attachment_file_provider.dart';
import '../../shared/utils/print_utils.dart';
import '../mixins/file_picker_mixins.dart';
import '../state/attachment_state.dart';

final customAttachmentProvider = StateNotifierProvider.autoDispose
    .family<CustomAttachmentNotifier, AttachmentState, String>(
      (ref, id) => CustomAttachmentNotifier(ref, id),
    );

class CustomAttachmentNotifier extends StateNotifier<AttachmentState>
    with CustomFilePickerMixin {
  // Filter get temporaryFilter => _temporaryFilter;
  String id;

  final Ref _ref;
  CustomAttachmentNotifier(this._ref, this.id)
    : super(
        AttachmentState(
          isLoading: false,
          localAttachments: [],
          serverAttachments: [],
        ),
      );

  /// Add the attachments from server
  /// [attachments] list of attachments from server
  void addAttachmentofServer(List<AttachmentModel>? attachments) {
    if (attachments == null) return;
    state = state.copyWith(serverAttachments: [...attachments]);
  }

  ///converts the file to attachment
  /// [filePath] path of the file
  AttachmentModel changeFileToAttachment({required String filePath}) {
    try {
      final mimeType = lookupMimeType(filePath) ?? '';
      return AttachmentModel(
        id: 1,
        file: filePath.toString(),
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

  /// Remove the specified attachment from the list of server attachments
  /// [attachmentId] the ID of the attachment to be removed
  void removeCurrentAttachments(int attachmentId) {
    final currentAttachments = state.serverAttachments ?? [];
    final attachmentExists = currentAttachments.any(
      (attachment) => attachment.id == attachmentId,
    );

    if (attachmentExists) {
      state = state.copyWith(
        serverAttachments:
            currentAttachments
                .where((attachment) => attachment.id != attachmentId)
                .toList(),
      );
    }
  }

  /// Change the specified attachment->isInclude from the list of server attachments
  /// [attachmentId] the ID of the attachment in which status of isInclude uis to be change
  /// [isInclude] the status of isInclude
  void updateStateAttachment({
    required int? attachmentId,
    required bool isInclude,
  }) {
    try {
      List<AttachmentModel> attachmentsList = [
        ...(state.serverAttachments ?? []),
      ];
      final updatedList =
          attachmentsList.map((e) {
            if (e.id == attachmentId) {
              return e.copyWith(isInclude: isInclude);
            }
            return e;
          }).toList();
      state = state.copyWith(serverAttachments: updatedList);
    } catch (e) {
      PrintUtils.customLog('Error in Deleteing files$e');
    }
  }

  // Add the below function inside your working class
  Future<File> _cropImage(File imageFile) async {
    CroppedFile? cropped = await ImageCropper().cropImage(
      sourcePath: imageFile.path,
      // aspectRatio: CropAspectRatio(ratioX: 520, ratioY: 520)
      // [
      // 	CropAspectRatioPreset.square,
      // 	CropAspectRatioPreset.ratio3x2,
      // 	CropAspectRatioPreset.original,
      // 	CropAspectRatioPreset.ratio4x3,
      // 	CropAspectRatioPreset.ratio16x9
      // 	]
      // ,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Crop',
          cropGridColor: Colors.black,
          initAspectRatio: CropAspectRatioPreset.original,
          lockAspectRatio: false,
        ),
        IOSUiSettings(title: 'Crop'),
      ],
    );

    if (cropped != null) {
      return File(cropped.path);
    }
    return imageFile;
  }

  /// Pick files from device
  ///
  /// [isCamera] indicates if the files should be picked from the camera
  /// [allowMultiple] indicates if multiple files can be picked
  /// [type] specifies the type of files to pick
  void pickFiles({
    bool isCamera = false,
    bool allowMultiple = true,
    FileType type = FileType.any,
    required final void Function(List<AttachmentModel> attachmentList)
    onAddAttachment,
  }) async {
    List<File> pickedFiles = [];
    try {
      // Retrieve files either from camera or file picker
      final listData =
          isCamera
              ? (await getCameraImageFiles() ?? [])
              : (await getFiles(allowMultiple: allowMultiple, type: type) ??
                  []);
      if (isCamera) {
        if (listData.isEmpty) {
          return;
        } else {
          // File croppedFile = await _cropImage(listData[0]);
          // listData.clear();
          // listData.add(croppedFile);
        }
      }

      if (listData.length > 4) {
        CustomToast.showToast(
          'Only 4 images can be uploaded at once.',
          status: ToastStatus.info,
        );
        listData.removeRange(4, listData.length);
      }

      state = state.copyWith(isLoading: true, localAttachments: listData);

      // Process the picked files ie compresses the picked files
      if (listData.isNotEmpty) {
        await processFiles(listData, pickedFiles);
        List<AttachmentModel> attachments =
            pickedFiles.map((e) {
              return changeFileToAttachment(filePath: e.path);
            }).toList();

        final links = await uploadAttachmentsServer(attachments);
        state = state.copyWith(
          isLoading: false,
          localAttachments: [],
          serverAttachments: [...(state.serverAttachments ?? []), ...links],
        );
        onAddAttachment(state.serverAttachments ?? []);
      } else {
        CustomToast.showToast(
          'There is no item selected',
          status: ToastStatus.info,
        );
      }
    } catch (e) {
      log('Compression Error: $e ');
    }
    state = state.copyWith(isLoading: false, localAttachments: []);
  }

  /// Processes a list of files and adds them to the `pickedFiles` list.
  /// Images larger than 2 MB or in HEIC/HEVC format are compressed before adding.
  ///
  /// This function ensures that each file is processed sequentially and awaits
  /// the asynchronous operations correctly.
  ///
  /// - Parameters:
  ///   - listData: A list of files to be processed.
  ///   - pickedFiles: A list where processed files will be added.
  ///
  /// Example:
  /// ```dart
  /// List<File> files = [...]; // Your list of files
  /// List<File> processedFiles = [];
  /// await processFiles(files, processedFiles);
  ///
  Future<void> processFiles(List<File> listData, List<File> pickedFiles) async {
    await Future.forEach<File>(listData, (element) async {
      if (ImageUtils.isImage(path: element.path)) {
        final heicFormat = element.path.split('.').last.toLowerCase();
        if ((element.lengthSync()) / (1024 * 1024) > 2.0 ||
            heicFormat == 'heic' ||
            heicFormat == 'hevc') {
          File compressedFile = await ImageUtils.compressImage(element.path);
          pickedFiles.add(compressedFile);
        } else {
          pickedFiles.add(element);
        }
      } else {
        pickedFiles.add(element);
      }
    });
    // await Future.delayed(const Duration(seconds: 2), () {});
  }

  /// Upload files to server
  ///
  /// [uploadImage] list of files to be uploaded
  Future<List<AttachmentModel>> uploadAttachmentsServer(
    List<AttachmentModel> uploadImage,
  ) async {
    try {
      final formData = await changeToFormDataMultiPartAction(uploadImage);
      PrintUtils.customLog('Uploading attachments ${(formData.toString())}');

      final result = await _ref
          .read(attachmentFileRepositoryProvider)
          .uploadAttachment(map: formData);

      final data = await result.fold(
        (failure) {
          PrintUtils.customLog('Error in uploading attachments');
        },
        (response) async {
          try {
            final responseData = response.data;
            final data = responseData['data'] ?? responseData.data;
            final result = convertDataToAttachmentModel(data);
            return result;
          } catch (e) {
            PrintUtils.customLog(e.toString());
          }
        },
      );
      return data ?? [];
    } catch (e) {
      log('Error in uploading attachments $e');
      return [];
    }
  }

  List<AttachmentModel> convertDataToAttachmentModel(List result) {
    try {
      List<AttachmentModel> attachments =
          (result).map<AttachmentModel>((e) {
            String fileName = e['name'] ?? '';
            final extBeginIndex = fileName.lastIndexOf('.');
            final ext = fileName.substring(extBeginIndex + 1);
            return AttachmentModel.fromJson(
              e as Map<String, dynamic>,
            ).copyWith(mime: ext);
          }).toList();
      return attachments;
    } catch (e) {
      PrintUtils.customLog('Error in converting data to attachment model $e');
    }
    return (result).map<AttachmentModel>((e) {
      String fileName = e['name'] ?? '';
      final extBeginIndex = fileName.lastIndexOf('.');
      final ext = fileName.substring(extBeginIndex + 1);
      return AttachmentModel.fromJson(
        e as Map<String, dynamic>,
      ).copyWith(mime: ext);
    }).toList();
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
}
