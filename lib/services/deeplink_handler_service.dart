import 'dart:convert';

import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:findcarsale/routes/app_route.gr.dart';
import 'package:findcarsale/shared/domain/models/garage_yard/garage_yard_model.dart';

class DeepLinkHandler {
  DeepLinkHandler._();
  static final DeepLinkHandler _instance = DeepLinkHandler._();
  static DeepLinkHandler get instance => _instance;

  static void handleUrl(
    Map<String, dynamic> data,
    BuildContext context, {
    bool fromNotification = true,
  }) async {
    try {
      // Check if the data contains an ID
      Map<String, dynamic> mainData = json.decode(data['data']);
      int? entityId = int.tryParse(mainData['id'].toString());
      if (entityId != null) {
        // Navigate to the post detail screen
        context.router.push(
          PostDetailScreen(garageayard: Garageayard(id: entityId)),
        );
      } else {
        // If no ID is found, check for other possible navigation paths
        String? type = data['type']?.toString();
        if (type != null) {
          switch (type.toLowerCase()) {
            case 'garage_and_yard_posted':
              int? postId = int.tryParse((data['id'] ?? '').toString());
              if (postId != null) {
                context.router.push(
                  PostDetailScreen(garageayard: Garageayard(id: postId)),
                );
              }
              break;
            // Add more cases for different notification types if needed
          }
        }
      }
    } catch (e) {
      print('Error handling deep link: $e');
    }
  }
}
