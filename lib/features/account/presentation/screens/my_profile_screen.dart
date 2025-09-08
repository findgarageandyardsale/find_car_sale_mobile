import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:findcarsale/features/account/presentation/widgets/circular_user_image_widget.dart';
import 'package:findcarsale/routes/app_route.gr.dart';
import 'package:findcarsale/services/user_cache_service/domain/providers/current_user_provider.dart';
import 'package:findcarsale/shared/constants/spacing.dart';
import 'package:findcarsale/shared/domain/models/garage_yard/garage_yard_model.dart';
import 'package:findcarsale/shared/theme/app_colors.dart';
import 'package:findcarsale/shared/widgets/action_button.dart';

@RoutePage()
class MyProfileScreen extends ConsumerWidget {
  const MyProfileScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userModel = ref.watch(currentUserProvider);
    final user = userModel.value;

    String? getAddress(LocationModel? model) {
      if (model == null) {
        return null;
      } else {
        final appartNumber =
            model.apartmentNumber != null ? '${model.apartmentNumber}, ' : '';

        final suiteApp =
            model.subLocality != null ? '${model.subLocality}, ' : '';
        final streetName =
            model.throughfare != null ? '${model.throughfare}, ' : '';
        final streetNumber =
            model.subThoroughfare != null ? '${model.subThoroughfare}, ' : '';
        final cityName = model.locality != null ? '${model.locality}, ' : '';
        final state = model.adminArea != null ? '${model.adminArea}, ' : '';
        final zipcode = model.zipCode != null ? '${model.zipCode}' : '';
        return '$appartNumber$suiteApp$streetNumber$streetName$cityName$state$zipcode';
      }
    }

    return Scaffold(
      appBar: AppBar(title: const Text('My Profile')),
      body: SafeArea(
        child: ListView(
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Spacing.sizedBoxH_20(),
                CircularUserImageWidget(
                  firstName: user?.firstName,
                  lastName: user?.lastName,
                  file: user?.profile?.file,
                ),
                Spacing.sizedBoxH_16(),
                Text(
                  '${user?.firstName} ${user?.lastName}',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Spacing.sizedBoxH_30(),
                ActionButton(
                  textColor: Colors.white,
                  borderColor: Theme.of(context).primaryColor,
                  label: 'Edit Profile',
                  onPressed: () {
                    context.router.push(const EditProfileScreen());
                  },
                ),
              ],
            ),
            const SizedBox(height: 30),
            ProfileInfoListTileWidget(
              icon: Icons.mail_outline,
              title: 'Email',
              subTitle: '${user?.email}',
            ),
            ProfileInfoListTileWidget(
              icon: Icons.call_outlined,
              title: 'Phone',
              subTitle: '${user?.phoneNumber}',
            ),
            if (user?.address != null)
              ProfileInfoListTileWidget(
                icon: Icons.location_on_outlined,
                title: 'Address',
                subTitle: getAddress(user?.address) ?? '',
              ),
          ],
        ),
      ),
    );
  }
}

class ProfileInfoListTileWidget extends StatelessWidget {
  const ProfileInfoListTileWidget({
    super.key,
    required this.icon,
    required this.title,
    required this.subTitle,
  });
  final IconData icon;
  final String title;
  final String subTitle;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 18,
        backgroundColor: AppColors.lightPrimaryColor,
        child: Icon(icon, size: 20, color: AppColors.primary),
      ),
      title: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
          fontWeight: FontWeight.w700,
          color: AppColors.tileColor,
        ),
      ),
      subtitle: Text(subTitle, style: Theme.of(context).textTheme.bodySmall),
      onTap: () {},
    );
  }
}
