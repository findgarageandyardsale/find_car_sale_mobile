import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:findcarsale/shared/domain/models/attachment_file/attachment_model.dart';
import '../../../../shared/theme/app_colors.dart';
import '../../../../shared/widgets/file_image_builder.dart';

class CustomCarousel extends StatefulWidget {
  const CustomCarousel({
    super.key,
    required this.isGarage,
    required this.attachments,
    required this.share,
  });
  final List<AttachmentModel> attachments;
  final VoidCallback share;

  final bool isGarage;

  @override
  State<StatefulWidget> createState() {
    return _CarouselWithIndicatorState();
  }
}

class _CarouselWithIndicatorState extends State<CustomCarousel> {
  int _current = 0;
  final CarouselSliderController _controller = CarouselSliderController();
  bool _isAutoPlaying = true;

  @override
  Widget build(BuildContext context) {
    return widget.attachments.isEmpty
        ? const SizedBox.shrink()
        : Stack(
          children: [
            CarouselSlider(
              items:
                  widget.attachments.map((e) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _isAutoPlaying = !_isAutoPlaying;
                        });
                      },
                      child: FileImageBuilder(
                        url: e.file ?? '',
                        clickUrl: e.file ?? '',
                        height: 356,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      ),
                    );
                  }).toList(),
              carouselController: _controller,
              options: CarouselOptions(
                height: 400,
                aspectRatio: 16 / 9,
                viewportFraction: 1,
                initialPage: 0,
                enableInfiniteScroll: true,
                reverse: false,
                autoPlay: _isAutoPlaying,
                autoPlayInterval: const Duration(seconds: 5),
                autoPlayAnimationDuration: const Duration(milliseconds: 800),
                autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                enlargeFactor: 0.3,
                scrollDirection: Axis.horizontal,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                },
              ),
            ),
            Positioned(
              top: 16,
              left: 4,
              child: CircleAvatar(
                backgroundColor:
                    widget.isGarage
                        ? AppColors.surfaceLight
                        : AppColors.softColor,
                child: const BackButton(color: AppColors.black),
              ),
            ),
            Positioned(
              top: 16,
              right: 8,
              child: CircleAvatar(
                backgroundColor:
                    widget.isGarage
                        ? AppColors.surfaceLight
                        : AppColors.softColor,
                child: IconButton(
                  onPressed: () {
                    setState(() {
                      _isAutoPlaying = !_isAutoPlaying;
                    });
                  },
                  icon: Icon(
                    _isAutoPlaying ? Icons.pause : Icons.play_arrow,
                    color: AppColors.black,
                  ),
                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left:
                  MediaQuery.of(context).size.width / 2 -
                  ((widget.attachments.length * 20 + 8) / 2),
              child: Row(
                children:
                    widget.attachments.asMap().entries.map((entry) {
                      return GestureDetector(
                        onTap: () => _controller.animateToPage(entry.key),
                        child: Container(
                          width: (_current == entry.key) ? 20 : 12.0,
                          height: 10.0,
                          margin: const EdgeInsets.symmetric(
                            vertical: 8.0,
                            horizontal: 4.0,
                          ),
                          decoration: BoxDecoration(
                            shape:
                                (_current == entry.key)
                                    ? BoxShape.rectangle
                                    : BoxShape.circle,
                            borderRadius:
                                (_current == entry.key)
                                    ? BorderRadius.circular(6.0)
                                    : null,
                            color:
                                (_current == entry.key)
                                    ? widget.isGarage
                                        ? AppColors.primary
                                        : AppColors.green
                                    : Colors.white,
                          ),
                        ),
                      );
                    }).toList(),
              ),
            ),
          ],
        );
  }
}
