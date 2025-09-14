import 'package:auto_route/auto_route.dart';
import 'package:findcarsale/dummy_data.dart';
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

    // final detailState = ref.watch(detailPageProvider);
    final detailDeta = DummyDataService.getDummyGarageYardById(
      widget.garageayard.id ?? 0,
    );

    // Use detailDeta for the detail page
    final garageayard = detailDeta ?? widget.garageayard;
    _loadCustomMarker(garageayard);
    bool isGarage = garageayard.type == GarageYardType.garage;
    StatusEnum? status = garageayard.status;

    return context.doublePos(
      isGarage: isGarage,
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
      content: SafeArea(
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
                        color: isGarage ? AppColors.primary : AppColors.green,
                      ),
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
                                  'Brand',
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
                                  garageayard.isNew == true ? 'New' : 'Used',
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
                                isGarage ? AppColors.primary : AppColors.green,
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Price',
                                  style: Theme.of(context).textTheme.titleMedium
                                      ?.copyWith(fontWeight: FontWeight.w600),
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

                    // Enhanced Location Section
                    Container(
                      padding: const EdgeInsets.all(16.0),
                      decoration: BoxDecoration(
                        color: Colors.blue[50],
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.blue[200]!),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: Colors.blue[600],
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Text(
                                'Location',
                                style: Theme.of(
                                  context,
                                ).textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: Colors.blue[600],
                                ),
                              ),
                            ],
                          ),
                          Spacing.sizedBoxH_08(),
                          LocationText(
                            fromDetail: true,
                            isGarage: isGarage,
                            location: AppUtils.formatLocationAsAddress(
                              garageayard.location ?? const LocationModel(),
                            ),
                          ),
                          if (garageayard.location?.addressLine != null) ...[
                            Spacing.sizedBoxH_04(),
                            Text(
                              garageayard.location!.addressLine!,
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(color: Colors.grey[600]),
                            ),
                          ],
                          if (garageayard.location?.zipCode != null) ...[
                            Spacing.sizedBoxH_04(),
                            Text(
                              'ZIP: ${garageayard.location!.zipCode!}',
                              style: Theme.of(context).textTheme.bodySmall
                                  ?.copyWith(color: Colors.grey[500]),
                            ),
                          ],
                        ],
                      ),
                    ),
                    Spacing.sizedBoxH_16(),

                    // Contact Information Section
                    if (garageayard.phoneNumber != null)
                      Container(
                        padding: const EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          color: Colors.green[50],
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.green[200]!),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.phone,
                                  color: Colors.green[600],
                                  size: 20,
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Contact Information',
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleMedium?.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: Colors.green[600],
                                  ),
                                ),
                              ],
                            ),
                            Spacing.sizedBoxH_08(),
                            Row(
                              children: [
                                Text(
                                  'Phone: ',
                                  style: Theme.of(context).textTheme.bodyMedium
                                      ?.copyWith(fontWeight: FontWeight.w500),
                                ),
                                Text(
                                  garageayard.phoneNumber!,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.bodyMedium?.copyWith(
                                    color: Colors.green[700],
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    if (garageayard.phoneNumber != null) Spacing.sizedBoxH_16(),
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
      ),
    );
  }
}
