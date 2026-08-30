import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:findcarsale/services/chat_service/data/repositories/chat_repository_impl.dart';
import 'package:findcarsale/services/chat_service/domain/repositories/chat_repository.dart';
import 'package:findcarsale/shared/domain/models/chat/chat_models.dart';

// Repository Provider
final chatRepositoryProvider = Provider<ChatRepository>((ref) {
  return ChatRepositoryImpl();
});

// Chat Rooms Providers
final userChatRoomsProvider = StreamProvider.family<List<ChatRoom>, String>((
  ref,
  userId,
) {
  final repository = ref.watch(chatRepositoryProvider);
  return repository.getUserChatRoomsStream(userId);
});

final chatRoomProvider = FutureProvider.family<ChatRoom?, String>((
  ref,
  roomId,
) async {
  final repository = ref.watch(chatRepositoryProvider);
  final result = await repository.getChatRoom(roomId);
  return result.fold((l) => null, (r) => r);
});

// Messages Providers
final chatMessagesProvider = StreamProvider.family<List<ChatMessage>, String>((
  ref,
  roomId,
) {
  final repository = ref.watch(chatRepositoryProvider);
  return repository.getChatMessagesStream(roomId);
});

// User Providers
final chatUserProvider = FutureProvider.family<ChatUser?, String>((
  ref,
  userId,
) async {
  final repository = ref.watch(chatRepositoryProvider);
  final result = await repository.getChatUser(userId);
  return result.fold((l) => null, (r) => r);
});

// Notifications Providers
final chatNotificationsProvider =
    FutureProvider.family<List<ChatNotification>, String>((ref, userId) async {
      final repository = ref.watch(chatRepositoryProvider);
      final result = await repository.getUserNotifications(userId);
      return result.fold((l) => <ChatNotification>[], (r) => r);
    });

// Unread Count Provider
final unreadCountProvider = StreamProvider.family<int, String>((ref, userId) {
  final repository = ref.watch(chatRepositoryProvider);
  return repository.getUnreadCountStream(userId);
});

// Chat Room Updates Provider
final chatRoomUpdatesProvider = StreamProvider.family<ChatRoom, String>((
  ref,
  roomId,
) {
  final repository = ref.watch(chatRepositoryProvider);
  return repository.getChatRoomUpdates(roomId);
});
