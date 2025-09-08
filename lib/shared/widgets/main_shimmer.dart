import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../constants/spacing.dart';

class MainViewShimmer extends StatelessWidget {
  const MainViewShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.all(16.0),
      shrinkWrap: true,
      itemBuilder: (_, index) => Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(16.0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: Colors.grey.shade300,
            width: 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 120.0,
              height: 120.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
              ),
            )
                .animate(
                  onPlay: (controller) => controller.repeat(),
                )
                .shimmer(
                    color: Colors.grey.shade300,
                    duration: const Duration(seconds: 2)),
            Spacing.sizedBoxW_16(),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    width: double.infinity,
                    height: 14.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  )
                      .animate(
                        onPlay: (controller) => controller.repeat(),
                      )
                      .shimmer(
                          color: Colors.grey.shade300,
                          duration: const Duration(seconds: 2)),
                  Spacing.sizedBoxH_12(),
                  Row(
                    children: [
                      Container(
                        width: 30.0,
                        height: 30.0,
                        decoration: const BoxDecoration(
                            color: Colors.white, shape: BoxShape.circle),
                      )
                          .animate(
                            onPlay: (controller) => controller.repeat(),
                          )
                          .shimmer(
                              color: Colors.grey.shade300,
                              duration: const Duration(seconds: 2)),
                      Container(
                        width: 55.0,
                        height: 12.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      )
                          .animate(
                            onPlay: (controller) => controller.repeat(),
                          )
                          .shimmer(
                            color: Colors.grey.shade300,
                            duration: const Duration(seconds: 2),
                          ),
                      Spacing.sizedBoxW_16(),
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          height: 12.0,
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                        )
                            .animate(
                              onPlay: (controller) => controller.repeat(),
                            )
                            .shimmer(
                              color: Colors.grey.shade300,
                              duration: const Duration(seconds: 2),
                            ),
                      ),
                    ],
                  ),
                  Spacing.sizedBoxH_16(),
                  Row(
                    children: [
                      Container(
                        width: 18.0,
                        height: 30.0,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      )
                          .animate(
                            onPlay: (controller) => controller.repeat(),
                          )
                          .shimmer(
                            color: Colors.grey.shade300,
                            duration: const Duration(seconds: 2),
                          ),
                      Flexible(
                        child: Column(
                          children: [
                            Container(
                              width: 120.0,
                              height: 12.0,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                            )
                                .animate(
                                  onPlay: (controller) => controller.repeat(),
                                )
                                .shimmer(
                                  color: Colors.grey.shade300,
                                  duration: const Duration(seconds: 2),
                                ),
                            Spacing.sizedBoxH_08(),
                            Container(
                              width: 120.0,
                              height: 12.0,
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                              ),
                            )
                                .animate(
                                  onPlay: (controller) => controller.repeat(),
                                )
                                .shimmer(
                                  color: Colors.grey.shade300,
                                  duration: const Duration(seconds: 2),
                                ),
                          ],
                        ),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      itemCount: 6,
    );
  }
}
