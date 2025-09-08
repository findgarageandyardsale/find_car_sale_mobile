import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:findcarsale/shared/constants/spacing.dart';

@RoutePage()
class AboutUsScreen extends StatelessWidget {
  const AboutUsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('About Us')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                'Find Car Sale App',
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
              Spacing.sizedBoxH_16(),
              const Text(
                'Find Car Sale is your user-friendly platform designed to effortlessly discover and list car sales in your local community.',
                textAlign: TextAlign.justify,
              ),
              Spacing.sizedBoxH_16(),
              const Text(
                'The quick sign-up, intuitive navigation, and secure transactions were designed to help you effortlessly find amazing deals or post your own sale listing to reach nearby buyers. Keep your neighborhood decluttered as our organized sales ensure the transition of your unwanted items to treasures for others. ',
                textAlign: TextAlign.justify,
              ),
              Spacing.sizedBoxH_16(),
              const Text(
                'Make an eco-friendly impact by giving your items a second life, while you earn cash. Sell fast, buy easily, and connect with your neighbors—all in one place!',
                textAlign: TextAlign.justify,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
