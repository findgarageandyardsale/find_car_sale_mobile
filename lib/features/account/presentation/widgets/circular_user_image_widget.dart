import 'package:flutter/material.dart';
import 'package:findcarsale/shared/theme/app_colors.dart';
import 'package:findcarsale/shared/widgets/file_image_builder.dart';

class CircularUserImageWidget extends StatelessWidget {
  const CircularUserImageWidget({
    super.key,
    required this.firstName,
    required this.lastName,
    this.file,
  });
  final String? firstName, lastName;
  final String? file;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 90,
      width: 90,
      child: CircleAvatar(
        radius: 50,
        backgroundColor: AppColors.lightPrimaryColor,
        child:
            (file ?? '').isNotEmpty
                ? FileImageBuilder(
                  clickUrl: '',
                  url: file!,
                  fit: BoxFit.cover,
                  shape: BoxShape.circle,
                )
                : FnameLnameCircleTextWidget(
                  firstName: firstName ?? 'Garage',
                  lastName: lastName ?? 'Sales',
                  fontsize: 16,
                ),
      ),
    );
  }
}

class FnameLnameCircleTextWidget extends StatelessWidget {
  const FnameLnameCircleTextWidget({
    super.key,
    required this.firstName,
    required this.lastName,
    this.fontsize = 25,
  });
  final String firstName;
  final String lastName;
  final double fontsize;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        (firstName.isEmpty ? 'N/A' : firstName[0].toUpperCase()) +
            (lastName.isEmpty ? '' : lastName[0].toUpperCase()),
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
          fontSize: fontsize,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }
}
