import 'package:flutter/material.dart';
import '../../../flight_search/presentation/pages/flight_search_page.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingData> _onboardingData = [
    OnboardingData(
      title: 'Search Flights Instantly',
      subtitle: 'Find the best flight deals in seconds',
      backgroundColor: const Color(0xFF2196F3),
      illustration: 'assets/images/onboard-img3.png',
    ),
    OnboardingData(
      title: 'Compare Prices Easily',
      subtitle: 'Find the best deals on flights from\nmultiple airlines in one place.',
      backgroundColor: const Color(0xFF7C4DFF),
      illustration: 'assets/images/onboard-img1.png',
    ),
    OnboardingData(
      title: 'Book with Confidence',
      subtitle: 'Secure your travel plans with our reliable\nbooking process.',
      backgroundColor: const Color(0xFFFF6B35),
      illustration: 'assets/images/onboard-img2.png',
    ),
  ];

  void _nextPage() {
    if (_currentPage < _onboardingData.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _navigateToFlightSearch();
    }
  }

  void _navigateToFlightSearch() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => const FlightSearchPage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() {
            _currentPage = index;
          });
        },
        itemCount: _onboardingData.length,
        itemBuilder: (context, index) {
          return _buildOnboardingScreen(_onboardingData[index]);
        },
      ),
    );
  }

  Widget _buildOnboardingScreen(OnboardingData data) {
    return Container(
      color: data.backgroundColor,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            children: [
              const SizedBox(height: 60),

              // Image inside rounded white card
              Container(
                width: 280,
                height: 280,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(32),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Image.asset(
                    data.illustration,
                    fit: BoxFit.contain,
                    errorBuilder: (context, error, stackTrace) {
                      return const Icon(
                        Icons.image_not_supported,
                        size: 120,
                        color: Colors.grey,
                      );
                    },
                  ),
                ),
              ),

              const SizedBox(height: 48),

              // Title
              Text(
                data.title,
                style: const TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 16),

              // Subtitle
              Text(
                data.subtitle,
                style: const TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                  height: 1.5,
                ),
                textAlign: TextAlign.center,
              ),

              const SizedBox(height: 24),

              // Page indicators
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  _onboardingData.length,
                  (index) => Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    width: _currentPage == index ? 24 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: _currentPage == index
                          ? Colors.white
                          : Colors.white.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),

              const Spacer(),

              // Next / Get Started button
              SizedBox(
                width: double.infinity,
                height: 56,
                child: ElevatedButton(
                  onPressed: _nextPage,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.black87,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(28),
                    ),
                    elevation: 0,
                  ),
                  child: Text(
                    _currentPage == _onboardingData.length - 1
                        ? 'Get Started'
                        : 'Next',
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }
}

class OnboardingData {
  final String title;
  final String subtitle;
  final Color backgroundColor;
  final String illustration;

  OnboardingData({
    required this.title,
    required this.subtitle,
    required this.backgroundColor,
    required this.illustration,
  });
}
