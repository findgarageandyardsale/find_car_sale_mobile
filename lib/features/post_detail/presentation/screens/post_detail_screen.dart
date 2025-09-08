import 'package:auto_route/auto_route.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:findcarsale/features/explore/presentation/providers/explore_state_provider.dart';
import 'package:findcarsale/features/sales/presentation/provider/sale_state_provider.dart';
import 'package:findcarsale/routes/app_route.gr.dart';
import 'package:findcarsale/shared/extension/context.dart';
import 'package:findcarsale/shared/widgets/custom_toast.dart';
import 'package:findcarsale/shared/widgets/no_data.dart';
import '../../../../services/user_cache_service/domain/providers/current_user_provider.dart';
import '../../../../shared/constants/spacing.dart';
import '../../../../shared/domain/models/garage_yard/garage_yard_model.dart';
import '../../../../shared/domain/models/user/user_model.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/utils/app_utils.dart';
import '../../../../shared/utils/cusotm_date_utils.dart';
import '../../../../shared/widgets/decription_chip.dart';
import '../../../../shared/widgets/location_text.dart';
import '../../../../shared/widgets/status_chip.dart';
import '../../../../shared/widgets/timer_text.dart';
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

  final Set<Marker> _markers = {};

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
    // _loadCustomMarker();
    getDetailPage();
  }

  void _loadCustomMarker(garageayard) async {
    // Load the custom marker from assets
    BitmapDescriptor customIcon = await BitmapDescriptor.asset(
      const ImageConfiguration(size: Size(16, 26)),
      garageayard.type == GarageYardType.garage
          ? 'assets/garage.png'
          : 'assets/yard.png', // Path to your image in assets
    );

    // Add a marker using the custom icon
    _markers.add(
      Marker(
        markerId: const MarkerId('customMarker'),
        position: LatLng(
          garageayard.location?.latitude ?? 27.6782,
          garageayard.location?.longitude ?? 85.3808,
        ),
        icon: customIcon,
        // consumeTapEvents: true,
      ),
    );

    setState(() {}); // Update the UI to display the marker
  }

  void _onMapCreated(GoogleMapController controller) {
    mapController = controller;
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

    final detailState = ref.watch(detailPageProvider);

    return context.doublePos(
      isGarage: detailState.maybeWhen(
        orElse: () {
          return false;
        },
        success: (data) {
          return data.type == GarageYardType.garage;
        },
        failure: (error) {
          return false;
        },
        loading: () {
          return false;
        },
        initial: () {
          return false;
        },
      ),
      isActive: widget.isActive,
      actions: currentUserAsyncValue.when(
        data: (User? data) {
          if (data == null) {
            return [const SizedBox.shrink()];
          } else {
            return [];
          }
        },
        error: (Object error, StackTrace stackTrace) {
          return [const SizedBox.shrink()];
        },
        loading: () {
          return [const SizedBox.shrink()];
        },
      ),
      onPosPressed: () async {
        detailState.maybeWhen(
          orElse: () {},
          success: (garageayard) {
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
          _loadCustomMarker(garageayard);
          bool isGarage = garageayard.type == GarageYardType.garage;
          StatusEnum? status = garageayard.status;
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
                        Text(
                          garageayard.title ?? '',
                          style: Theme.of(
                            context,
                          ).textTheme.headlineSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                            color:
                                isGarage ? AppColors.primary : AppColors.green,
                          ),
                        ),
                        Spacing.sizedBoxH_16(),
                        if (status != null) StatusChip(status: status),
                        if (status != null) Spacing.sizedBoxH_16(),
                        Column(
                          children:
                              (garageayard.availableTimeSlots ?? [])
                                  .map(
                                    (e) => Column(
                                      children: [
                                        TimerText(
                                          fromDetail: true,
                                          isGarage: isGarage,
                                          date: CustomDateUtils.formatDate(
                                            e.date ?? DateTime.now(),
                                          ),
                                          time:
                                              '${CustomDateUtils.convertTo12HourFormat(e.startTime)} - ${CustomDateUtils.convertTo12HourFormat(e.endTime)}',
                                        ),
                                        Spacing.sizedBoxH_08(),
                                      ],
                                    ),
                                  )
                                  .toList(),
                        ),
                        Spacing.sizedBoxH_08(),
                        LocationText(
                          fromDetail: true,
                          isGarage: isGarage,
                          location: AppUtils.formatLocationAsAddress(
                            garageayard.location ?? const LocationModel(),
                          ),
                        ),
                        Spacing.sizedBoxH_16(),
                        Text(
                          garageayard.description ?? '',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        Spacing.sizedBoxH_16(),
                        Wrap(
                          runSpacing: 12.0,
                          spacing: 6.0,
                          children:
                              garageayard.category
                                  ?.map(
                                    (e) => DescriptionChip(
                                      isGarage: isGarage,
                                      text: e.name ?? '',
                                    ),
                                  )
                                  .toList() ??
                              [],
                        ),
                        Spacing.sizedBoxH_16(),
                        SizedBox(
                          height: 320,
                          child: GoogleMap(
                            mapType: MapType.terrain,
                            onMapCreated: _onMapCreated,
                            myLocationButtonEnabled: false,
                            markers: _markers,
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
    );
  }
}
