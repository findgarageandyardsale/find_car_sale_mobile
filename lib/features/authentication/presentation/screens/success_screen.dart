import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:findcarsale/shared/constants/spacing.dart';
import 'package:findcarsale/shared/widgets/action_button.dart';

import '../../../../routes/app_route.gr.dart';

@RoutePage()
class SuccessScreen extends StatefulWidget {
  const SuccessScreen({super.key, this.fromLogin});
  final bool? fromLogin;

  @override
  State<SuccessScreen> createState() => _SuccessScreenState();
}

class _SuccessScreenState extends State<SuccessScreen> {
  @override
  void initState() {
    super.initState();
    if (widget.fromLogin ?? false) {
      Future.delayed(const Duration(seconds: 2), () async {
        context.router.pushAndPopUntil(
          DashboardScreen(),
          predicate: (_) => false,
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(
                child: Image.asset(
                  'assets/launcher.jpeg',
                  height: 160,
                  width: 160,
                ),
              ),
              Spacing.sizedBoxH_20(),
              Text(
                (widget.fromLogin ?? false)
                    ? 'You Have \n Successfully \n Signed In'
                    : 'You Have \n Successfully \n Signed Up',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
                textAlign: TextAlign.center,
              ),
              Spacing.sizedBoxH_30(),
              if (!(widget.fromLogin ?? false))
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: ActionButton(
                    width: double.infinity,
                    label: 'Login',
                    onPressed: () {
                      context.router.pushAndPopUntil(
                        LoginScreen(),
                        predicate: (_) => false,
                      );
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
