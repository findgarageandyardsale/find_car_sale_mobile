import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:findcarsale/routes/app_route.gr.dart';
import 'package:findcarsale/services/chat_service/domain/providers/chat_providers.dart';
import 'package:findcarsale/services/user_cache_service/domain/providers/current_user_provider.dart';
import 'package:findcarsale/shared/theme/app_colors.dart';

class UnreadMessageBadge extends ConsumerWidget {
  const UnreadMessageBadge({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentUserAsync = ref.watch(currentUserProvider);

    return currentUserAsync.when(
      data: (user) {
        if (user == null) {
          return IconButton(
            onPressed: () {
              context.router.push(LoginScreen());
            },
            icon: const Icon(Icons.message_outlined, color: AppColors.primary),
          );
        }

        final unreadCountAsync = ref.watch(
          unreadCountProvider(user.userId.toString()),
        );

        return unreadCountAsync.when(
          data: (unreadCount) {
            return Stack(
              children: [
                IconButton(
                  onPressed: () {
                    context.router.push(ChatListScreen());
                  },
                  icon: const Icon(
                    Icons.message_outlined,
                    color: AppColors.primary,
                  ),
                ),
                if (unreadCount > 0)
                  Positioned(
                    right: 8,
                    top: 8,
                    child: Container(
                      padding: const EdgeInsets.all(4),
                      decoration: const BoxDecoration(
                        color: AppColors.error,
                        shape: BoxShape.circle,
                      ),
                      constraints: const BoxConstraints(
                        minWidth: 16,
                        minHeight: 16,
                      ),
                      child: Text(
                        unreadCount > 99 ? '99+' : unreadCount.toString(),
                        style: const TextStyle(
                          color: AppColors.white,
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
              ],
            );
          },
          error: (error, stackTrace) {
            return IconButton(
              onPressed: () {
                context.router.push(ChatListScreen());
              },
              icon: const Icon(
                Icons.message_outlined,
                color: AppColors.primary,
              ),
            );
          },
          loading: () {
            return IconButton(
              onPressed: () {
                context.router.push(ChatListScreen());
              },
              icon: const Icon(
                Icons.message_outlined,
                color: AppColors.primary,
              ),
            );
          },
        );
      },
      error: (error, stackTrace) {
        return IconButton(
          onPressed: () {
            context.router.push(LoginScreen());
          },
          icon: const Icon(Icons.message_outlined, color: AppColors.primary),
        );
      },
      loading: () {
        return IconButton(
          onPressed: () {
            context.router.push(LoginScreen());
          },
          icon: const Icon(Icons.message_outlined, color: AppColors.primary),
        );
      },
    );
  }
}
