import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:findcarsale/routes/app_route.gr.dart';
import '../../../../shared/theme/app_colors.dart';

@RoutePage()
class CustomIntroScreen extends StatefulWidget {
  const CustomIntroScreen({super.key});

  @override
  State<CustomIntroScreen> createState() => _CustomIntroScreenState();
}

class _CustomIntroScreenState extends State<CustomIntroScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<Map<String, String>> _introPages = [
    {
      'image': 'assets/1.jpg',
      'title': 'Find Your Perfect Car',
      'description':
          'Discover thousands of cars from trusted dealers and private sellers in your area.',
    },
    {
      'image': 'assets/2.jpg',
      'title': 'Compare & Save',
      'description':
          'Compare prices, features, and specifications to find the best deal for your budget.',
    },
    {
      'image': 'assets/3.jpg',
      'title': 'Easy Booking',
      'description':
          'Book test drives and connect with sellers directly through our secure platform.',
    },
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onNextPage() {
    if (_currentPage < _introPages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _onDone();
    }
  }

  void _onDone() {
    AutoRouter.of(
      context,
    ).pushAndPopUntil(DashboardScreen(), predicate: (_) => false);
  }

  void _onSkip() {
    _onDone();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        top: false,
        child: Stack(
          children: [
            PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemCount: _introPages.length,
              //lets do this vanumna aba
              itemBuilder: (context, i) {
                final page = _introPages[i];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Small image
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.1),
                              blurRadius: 20,
                              offset: const Offset(0, 10),
                            ),
                          ],
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.asset(page['image']!, fit: BoxFit.cover),
                        ),
                      ),
                      const SizedBox(height: 40),
                      // Title
                      Text(
                        page['title']!,
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      // Description
                      Text(
                        page['description']!,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.grey,
                          height: 1.5,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                );
              },
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                // padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.transparent,
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(24),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, -5),
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    TextButton(
                      onPressed: _onSkip,
                      child: const Text(
                        'Skip',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: List.generate(
                          _introPages.length,
                          (index) => AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            margin: const EdgeInsets.symmetric(horizontal: 4),
                            height: 8,
                            width: _currentPage == index ? 24 : 8,
                            decoration: BoxDecoration(
                              color:
                                  _currentPage == index
                                      ? AppColors.primary
                                      : AppColors.secondaryContainer,
                              borderRadius: BorderRadius.circular(4),
                            ),
                          ),
                        ),
                      ),
                    ),
                    ElevatedButton(
                      onPressed: _onNextPage,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 24,
                          vertical: 4,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(24),
                        ),
                      ),
                      child: Text(
                        _currentPage == _introPages.length - 1
                            ? 'Start'
                            : 'Next',
                        style: const TextStyle(fontWeight: FontWeight.w700),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
