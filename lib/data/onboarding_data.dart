class OnboardingItem {
  final String image;
  final String title;
  final String description;

  OnboardingItem({
    required this.image,
    required this.title,
    required this.description,
  });
}

List<OnboardingItem> onboardingData = [
  OnboardingItem(
    
    image: 'assets/images/onboarding_1.png',
    title: 'Book Flight',
    description: 'Found a flight that matches your destination and schedule? Book it instantly. Found a flight that \nmatches your destination.',
  ),
  OnboardingItem(
    image: 'assets/images/onboarding_2.png',
    title: 'Find a hotel room',
 description: 'Found a flight that matches your destination and schedule? Book it instantly. Found a flight that \nmatches your destination.',  ),
  OnboardingItem(
    image: 'assets/images/onboarding_3.png',
    title: 'Enjoy your trip',
 description: 'Found a flight that matches your destination and schedule? Book it instantly. Found a flight that \nmatches your destination.'  ),
];