import 'package:auto_route/auto_route.dart';
import 'package:findcarsale/shared/presentation/formz_state.dart';
import 'package:findcarsale/shared/widgets/action_button.dart';
import 'package:findcarsale/shared/widgets/no_data.dart';
import 'package:findcarsale/shared/widgets/sold_overlay.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:findcarsale/features/explore/presentation/providers/explore_state_provider.dart';
import 'package:findcarsale/features/sales/presentation/provider/sale_state_provider.dart';
import 'package:findcarsale/routes/app_route.gr.dart';
import 'package:findcarsale/shared/extension/context.dart';
import 'package:findcarsale/shared/widgets/custom_toast.dart';
import '../../../../services/user_cache_service/domain/providers/current_user_provider.dart';
import '../../../../services/chat_service/presentation/providers/chat_state_provider.dart';
import '../../../../shared/constants/spacing.dart';
import '../../../../shared/domain/models/garage_yard/garage_yard_model.dart';
import '../../../../shared/domain/models/user/user_model.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/utils/app_utils.dart';
import '../../../../shared/utils/map_utils.dart';
import '../../../../shared/widgets/custom_loading.dart';
import '../../../../shared/widgets/decription_chip.dart';
import '../widgets/custom_carousel.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

@RoutePage()
class PostDetailScreen extends ConsumerStatefulWidget {
  const PostDetailScreen({super.key, required this.garageayard, this.isActive});
  final Garageayard garageayard;
  final bool? isActive;

  @override
  ConsumerState<PostDetailScreen> createState() => _PostDetailScreenState();
}

class _PostDetailScreenState extends ConsumerState<PostDetailScreen> {
  late GoogleMapController mapController;

  final Set<Circle> _circles = {};
  bool _isLoadingChat = false;

  void getDetailPage() {
    Future.microtask(() {
      ref
          .read(detailPageProvider.notifier)
          .fetchPostDetails(widget.garageayard.id);
    });
  }

  @override
  void initState() {
    super.initState();
    _loadCustomCircle();
    getDetailPage();
  }

  void _loadCustomCircle() {
    // Create a circle with half-mile radius
    LatLng position = LatLng(
      widget.garageayard.location?.latitude ?? 27.6782,
      widget.garageayard.location?.longitude ?? 85.3808,
    );

    _circles.add(
      Circle(
        circleId: const CircleId('customCircle'),
        center: position,
        radius: MapUtils.halfMileInMeters, // Half mile radius
        fillColor: Colors.blue.withOpacity(0.2),
        strokeColor: Colors.blue,
        strokeWidth: 2,
      ),
    );

    setState(() {}); // Update the UI to display the circle
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
  }

  Widget _buildSpecItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: Colors.grey[600],
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600),
        ),
      ],
    );
  }

  void shareLink() async {
    // PrintUtils.customLog("Post Description ${widget.garageayard.toJson()}");
    // showDialog(
    //   context: context,
    //   builder: (context) => const Center(
    //     child: CircularProgressIndicator(
    //       color: AppColors.primary,
    //     ),
    //   ),
    // );
    // BranchUniversalObject buo = BranchUniversalObject(
    //   canonicalIdentifier: 'flutter/branch',
    //   title: widget.garageayard.title ?? '',
    //   imageUrl: '${AppConfigs.baseUrl}${widget.garageayard.attachments?.first}',
    //   contentDescription: widget.garageayard.description ?? "",
    //   publiclyIndex: true,
    //   locallyIndex: true,
    //   contentMetadata: BranchContentMetaData()
    //     ..addCustomMetadata(
    //       postId,
    //       widget.garageayard.id.toString(),
    //     ),
    // );

    // BranchLinkProperties lp = BranchLinkProperties(
    //     channel: 'facebook',
    //     feature: 'sharing',
    //     stage: 'new share',
    //     tags: ['one', 'two', 'three']);
    // lp.addControlParam('url', 'http://www.google.com');
    // lp.addControlParam('url2', 'http://flutter.dev');
    // BranchResponse response =
    //     await FlutterBranchSdk.getShortUrl(buo: buo, linkProperties: lp);
    // if (response.success) {
    //   final size = MediaQuery.of(context).size;
    //   final box = context.findRenderObject() as RenderBox?;
    //   Share.share(
    //     'Check out this amazing post ${response.result}',
    //     subject: 'Look ${widget.garageayard.title}',
    //     sharePositionOrigin: box!.localToGlobal(const Offset(0, 0)) &
    //         Size(
    //           size.height / 2,
    //           size.width,
    //         ),
    //   );
    // } else {
    //   PrintUtils.customLog(
    //       'Error : ${response.errorCode} - ${response.errorMessage}');
    // }
    // Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final currentUserAsyncValue = ref.watch(currentUserProvider);
    final markState = ref.watch(markAsSoldProvider);

    final detailState = ref.watch(detailPageProvider);

    ref.listen(markAsSoldProvider, (previous, next) {
      next.maybeWhen(
        success: (data) {
          CustomToast.showToast(
            'Post marked as sold',
            status: ToastStatus.success,
          );
          ref
              .read(detailPageProvider.notifier)
              .fetchPostDetails(widget.garageayard.id);
          ref.read(exploreNotifierProvider);
        },
        failure: (error) {
          CustomToast.showToast(
            'Mark as sold failed',
            status: ToastStatus.error,
          );
        },
        orElse: () {},
      );
    });

    return CustomLoadingOverlay(
      isLoading: _isLoadingChat || markState is Loading,
      child: context.doublePos(
        isGarage: true,
        isActive: widget.isActive,
        actionButton: currentUserAsyncValue.when(
          data: (User? data) {
            if (data == null) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ActionButton(
                  label: 'Login to Chat',
                  onPressed: () {
                    context.router.push(LoginScreen());
                  },
                ),
              );
            } else {
              // Use detailState to get the userId from fetched data
              return detailState.maybeWhen(
                success: (garageayard) {
                  // Check if current user is the post owner
                  if (garageayard.userId != null &&
                      garageayard.userId == data.userId) {
                    // Show owner action buttons (Edit and Mark as Sold)
                    return _buildOwnerActionButtons(
                      context,
                      ref,
                      data,
                      garageayard,
                    );
                  } else if (garageayard.userId != null &&
                      garageayard.userId != data.userId) {
                    // Show chat button if user is not the seller
                    return _buildChatButton(context, ref, data);
                  }
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ActionButton(
                      label: 'Login to Chat',
                      onPressed: () {
                        context.router.push(LoginScreen());
                      },
                    ),
                  );
                },
                orElse: () => const SizedBox.shrink(),
              );
            }
          },
          error: (Object error, StackTrace stackTrace) {
            return const SizedBox.shrink();
          },
          loading: () {
            return const SizedBox.shrink();
          },
        ),
        onPosPressed: () async {
          detailState.maybeWhen(
            orElse: () {},
            success: (data) {
              final garageayard = data;
              if (widget.isActive == null) {
                if (garageayard.location?.latitude == null ||
                    garageayard.location?.longitude == null) {
                  CustomToast.showToast(
                    'Location not available',
                    status: ToastStatus.error,
                  );
                  return;
                }
                AppUtils.openAppDirections(
                  garageayard.location?.latitude ?? 0.0,
                  garageayard.location?.longitude ?? 0.0,
                );
              } else if (widget.isActive == true || widget.isActive == false) {
                context.router
                    .push(AddEditPostSaleScreen(garageayard: garageayard))
                    .then((val) {
                      if (val == true) {
                        ref.read(saleNotifierProvider.notifier)
                          ..resetState()
                          ..fetchExplorePosts();
                        Navigator.pop(context);
                      }
                    });
              }
            },
          );
        },
        content: detailState.when(
          initial: () {
            return const Center(child: CircularProgressIndicator());
          },
          loading: () {
            return const Center(child: CircularProgressIndicator());
          },
          failure: (failuer) {
            return NoData(errorMessage: failuer.toString());
          },
          success: (val) {
            final garageayard = val is Garageayard ? val : widget.garageayard;
            _loadCustomCircle();
            bool isGarage = true;
            // garageayard.type == GarageYardType.garage;
            return SafeArea(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomCarousel(
                      isGarage: isGarage,
                      share: shareLink,
                      attachments: garageayard.attachments ?? [],
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  garageayard.title ?? '',
                                  style: Theme.of(
                                    context,
                                  ).textTheme.headlineSmall?.copyWith(
                                    fontWeight: FontWeight.w700,
                                    color:
                                        isGarage
                                            ? AppColors.primary
                                            : AppColors.green,
                                  ),
                                ),
                              ),
                              if (garageayard.status == StatusEnum.sold)
                                SoldOverlay(),
                            ],
                          ),
                          Spacing.sizedBoxH_16(),

                          // Car Specifications Section
                          Container(
                            padding: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                              color: Colors.grey[50],
                              borderRadius: BorderRadius.circular(12),
                              border: Border.all(color: Colors.grey[200]!),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Car Specifications',
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color:
                                        isGarage
                                            ? AppColors.primary
                                            : AppColors.green,
                                  ),
                                ),
                                Spacing.sizedBoxH_12(),
                                Row(
                                  children: [
                                    Expanded(
                                      child: _buildSpecItem(
                                        'Make',
                                        garageayard.brand ?? 'N/A',
                                      ),
                                    ),
                                    Expanded(
                                      child: _buildSpecItem(
                                        'Model',
                                        garageayard.model ?? 'N/A',
                                      ),
                                    ),
                                  ],
                                ),
                                Spacing.sizedBoxH_08(),
                                Row(
                                  children: [
                                    Expanded(
                                      child: _buildSpecItem(
                                        'Year',
                                        garageayard.year ?? 'N/A',
                                      ),
                                    ),
                                    Expanded(
                                      child: _buildSpecItem(
                                        'Miles',
                                        garageayard.miles != null
                                            ? '${garageayard.miles!.toStringAsFixed(0)} miles'
                                            : 'N/A',
                                      ),
                                    ),
                                  ],
                                ),
                                Spacing.sizedBoxH_08(),
                                Row(
                                  children: [
                                    Expanded(
                                      child: _buildSpecItem(
                                        'Condition',
                                        garageayard.condition?.name ?? 'N/A',
                                      ),
                                    ),
                                    Expanded(
                                      child: _buildSpecItem(
                                        'Status',
                                        garageayard.isNew == true
                                            ? 'New'
                                            : 'Used',
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Spacing.sizedBoxH_16(),

                          // Pricing Section
                          if (garageayard.price != null)
                            Container(
                              padding: const EdgeInsets.all(16.0),
                              decoration: BoxDecoration(
                                color:
                                    isGarage
                                        ? AppColors.primary.withOpacity(0.1)
                                        : AppColors.green.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                  color:
                                      isGarage
                                          ? AppColors.primary
                                          : AppColors.green,
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Price',
                                        style: Theme.of(
                                          context,
                                        ).textTheme.titleMedium?.copyWith(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                      Text(
                                        '\$${garageayard.price!.toStringAsFixed(0)}',
                                        style: Theme.of(
                                          context,
                                        ).textTheme.headlineMedium?.copyWith(
                                          fontWeight: FontWeight.w700,
                                          color:
                                              isGarage
                                                  ? AppColors.primary
                                                  : AppColors.green,
                                        ),
                                      ),
                                    ],
                                  ),
                                  if (garageayard.warranty == true)
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 6,
                                      ),
                                      decoration: BoxDecoration(
                                        color: Colors.green,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Text(
                                        'Warranty',
                                        style: Theme.of(
                                          context,
                                        ).textTheme.bodySmall?.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          Spacing.sizedBoxH_16(),

                          Spacing.sizedBoxH_16(),

                          Text(
                            garageayard.description ?? '',
                            style: Theme.of(context).textTheme.bodyLarge,
                          ),
                          Spacing.sizedBoxH_16(),
                          DescriptionChip(
                            isGarage: isGarage,
                            text: garageayard.condition?.name ?? '',
                          ),
                          Spacing.sizedBoxH_16(),
                          SizedBox(
                            height: 320,
                            child: GoogleMap(
                              mapType: MapType.terrain,
                              onMapCreated: _onMapCreated,
                              myLocationButtonEnabled: false,
                              circles: _circles,
                              mapToolbarEnabled: true,
                              zoomControlsEnabled: true,
                              zoomGesturesEnabled: true,
                              gestureRecognizers:
                                  <Factory<OneSequenceGestureRecognizer>>{
                                    Factory<OneSequenceGestureRecognizer>(
                                      () => EagerGestureRecognizer(),
                                    ),
                                  },
                              initialCameraPosition: CameraPosition(
                                target: LatLng(
                                  garageayard.location?.latitude ?? 27.6782,
                                  garageayard.location?.longitude ?? 85.3808,
                                ),
                                zoom: 15,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildChatButton(
    BuildContext context,
    WidgetRef ref,
    User currentUser,
  ) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: ActionButton(
        label: _isLoadingChat ? 'Starting Chat...' : 'Chat with Seller',
        onPressed:
            _isLoadingChat
                ? null
                : () => _initiateChat(context, ref, currentUser),
        borderColor: AppColors.primary,
        buttonColor:
            _isLoadingChat
                ? AppColors.primary.withOpacity(0.6)
                : AppColors.primary,
        textColor: AppColors.white,
        icon: _isLoadingChat ? null : Icons.chat,
      ),
    );
  }

  Widget _buildOwnerActionButtons(
    BuildContext context,
    WidgetRef ref,
    User currentUser,
    Garageayard garageayard,
  ) {
    return Container(
      margin: const EdgeInsets.all(16),
      child: Row(
        children: [
          Expanded(
            child: ActionButton(
              label: 'Edit Post',
              onPressed: () => _editPost(context, ref, garageayard),
              borderColor: AppColors.primary,
              buttonColor: AppColors.primary,
              textColor: AppColors.white,
              icon: Icons.edit,
            ),
          ),
          const SizedBox(width: 12),
          if (garageayard.status != StatusEnum.expired &&
              garageayard.status != StatusEnum.sold)
            Expanded(
              child: ActionButton(
                label:
                    garageayard.status == StatusEnum.expired
                        ? 'Mark as Available'
                        : 'Mark as Sold',
                onPressed: () => _togglePostStatus(context, ref, garageayard),
                borderColor:
                    garageayard.status == StatusEnum.expired
                        ? AppColors.green
                        : Colors.red,
                buttonColor:
                    garageayard.status == StatusEnum.expired
                        ? AppColors.green
                        : Colors.red,
                textColor: AppColors.white,
                icon:
                    garageayard.status == StatusEnum.expired
                        ? Icons.check_circle
                        : Icons.sell,
              ),
            ),
        ],
      ),
    );
  }

  void _editPost(BuildContext context, WidgetRef ref, Garageayard garageayard) {
    context.router.push(AddEditPostSaleScreen(garageayard: garageayard)).then((
      val,
    ) {
      if (val == true) {
        ref.read(saleNotifierProvider.notifier)
          ..resetState()
          ..fetchExplorePosts();
        // Refresh the detail page
        ref.read(detailPageProvider.notifier).fetchPostDetails(garageayard.id);
      }
    });
  }

  Future<void> _togglePostStatus(
    BuildContext context,
    WidgetRef ref,
    Garageayard garageayard,
  ) async {
    try {
      // Show confirmation dialog
      final confirmed = await showDialog<bool>(
        context: context,
        builder:
            (context) => AlertDialog(
              title: Text('Mark as Sold?'),
              content: Text(
                'This will mark your post as sold and remove it from active listings.',
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('Cancel'),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    backgroundColor: Colors.red,
                    foregroundColor: AppColors.white,
                  ),
                  onPressed: () => Navigator.of(context).pop(true),
                  child: Text('Mark Sold'),
                ),
              ],
            ),
      );

      if (confirmed == true) {
        ref.read(markAsSoldProvider.notifier).markAsSold(garageayard.id);
      }
    } catch (e) {
      CustomToast.showToast(
        'Error updating post status',
        status: ToastStatus.error,
      );
    }
  }

  Future<void> _initiateChat(
    BuildContext context,
    WidgetRef ref,
    User currentUser,
  ) async {
    try {
      // Set loading state
      setState(() {
        _isLoadingChat = true;
      });

      final detailState = ref.read(detailPageProvider);

      // Get the garage yard data from detailState
      final garageayard = detailState.maybeWhen(
        success: (data) => data is Garageayard ? data : widget.garageayard,
        orElse: () => widget.garageayard,
      );

      if (garageayard.userId == null) {
        CustomToast.showToast(
          'Seller information not available',
          status: ToastStatus.error,
        );
        return;
      }

      final chatService = ref.read(chatServiceProvider);

      // Create or get existing chat room with timeout
      final chatRoom = await chatService.createOrGetChatRoom(
        garageYardId: garageayard.id.toString(),
        sellerId: garageayard.userId.toString(),
        sellerName:
            '${garageayard.user?.firstName} ${garageayard.user?.lastName}',
        buyerName: '${currentUser.firstName} ${currentUser.lastName}',
        postId: garageayard.id.toString(),
        postTitle: garageayard.title ?? '',
        buyerId: currentUser.userId.toString(),
        garageYardTitle: garageayard.title,
        chatInitiatedByUsername:
            '${currentUser.firstName} ${currentUser.lastName}',
      );

      if (chatRoom != null) {
        // Navigate to chat screen
        if (context.mounted) {
          context.router.push(ChatScreen(chatRoom: chatRoom));
        }
      } else {
        CustomToast.showToast(
          'Failed to start chat. Please try again.',
          status: ToastStatus.error,
        );
      }
    } catch (e) {
      print('Error in _initiateChat: $e'); // Debug log

      String errorMessage = 'Error starting chat';
      if (e.toString().contains('timeout') ||
          e.toString().contains('timed out')) {
        errorMessage =
            'Connection timed out. Please check your internet connection.';
      } else if (e.toString().contains('Unable to resolve host') ||
          e.toString().contains('firestore.googleapis.com')) {
        errorMessage = 'Network error. Please check your internet connection.';
      } else if (e.toString().contains('Firebase not initialized')) {
        errorMessage = 'Firebase not ready. Please try again.';
      } else {
        errorMessage = 'Error starting chat: ${e.toString()}';
      }

      CustomToast.showToast(errorMessage, status: ToastStatus.error);
    } finally {
      // Reset loading state
      if (mounted) {
        setState(() {
          _isLoadingChat = false;
        });
      }
    }
  }
}
