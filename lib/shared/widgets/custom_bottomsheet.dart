import 'package:flutter/material.dart';

///Primary bottom sheet main template
Future primaryBottomSheet(
  BuildContext context, {
  required Widget child,
  bool hasBack = true,
  String closeText = 'Back',
  bool isDismissible = true,
  bool hasSpace = true,
  EdgeInsets? padding,
}) {
  try {
    return showModalBottomSheet(
      isDismissible: isDismissible,
      showDragHandle: true,
      context: context,
      backgroundColor: Colors.white,
      constraints: const BoxConstraints(maxWidth: double.infinity),
      isScrollControlled: true,
      builder:
          (context) => PopScope(
            canPop: isDismissible,
            onPopInvokedWithResult: (val, _) {
              if (val) {
                return;
              }
            },
            child: SafeArea(
              child: Container(
                width: double.infinity,
                padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom,
                ),
                child: Wrap(
                  children: [
                    hasSpace
                        ? Padding(
                          padding:
                              padding ??
                              const EdgeInsets.only(
                                top: 5,
                                right: 28,
                                left: 28,
                                bottom: 10,
                              ),
                          child: child,
                        )
                        : child,
                  ],
                ),
              ),
            ),
          ),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(8),
          topRight: Radius.circular(8),
        ),
      ),
    );
  } catch (e) {
    return Future.value(null);
  }
}
