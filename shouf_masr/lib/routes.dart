import 'package:get/get.dart';
import 'package:shouf_masr/screens/setting_screen.dart';
import 'screens/splash_screen.dart';
import 'screens/role_selection.dart';
import 'screens/traveler_auth.dart';
import 'screens/traveler_login.dart';
import 'screens/traveler_signup.dart'; // <-- Added signup
import 'screens/agency_signup.dart';
import 'screens/agency_contact.dart';
import 'screens/search_screen.dart';
import 'screens/offers_screen.dart';
import 'screens/trip_details_screen.dart';
import 'screens/reviews_screen.dart';
import 'screens/company_profile.dart';
import 'screens/requests_screen.dart';
import 'screens/waiting_screen.dart';
import 'screens/home_screen.dart';
import 'screens/article_screen.dart';
import 'screens/my_offers_screen.dart';
import 'screens/notifications_screen.dart';
import 'screens/offer_details_screen.dart';
import 'screens/messages_screen.dart';
import 'screens/chat_screen.dart';
import 'screens/send_offer_screen.dart';
import 'screens/not_found_screen.dart';

final appRoutes = [
  GetPage(
    name: '/',
    page: () => const SplashScreen(),
    transition: Transition.fadeIn,
    transitionDuration: const Duration(milliseconds: 700),
  ),
  GetPage(
    name: '/role-selection',
    page: () => const RoleSelection(),
    transition: Transition.zoom,
    transitionDuration: const Duration(milliseconds: 700),
  ),
  GetPage(
    name: '/traveler-auth',
    page: () => const TravelerAuth(),
    transition: Transition.rightToLeft,
    transitionDuration: const Duration(milliseconds: 500),
  ),
  GetPage(
    name: '/traveler-login',
    page: () => const TravelerLogin(),
    transition: Transition.rightToLeft,
    transitionDuration: const Duration(milliseconds: 500),
  ),
  GetPage(
    name: '/traveler-signup',
    page: () => const TravelerSignup(),
    transition: Transition.rightToLeft,
    transitionDuration: const Duration(milliseconds: 500),
  ),
  GetPage(
    name: '/agency-signup',
    page: () => const AgencySignup(),
    transition: Transition.rightToLeft,
  ),
  GetPage(
    name: '/agency-contact',
    page: () => const AgencyContact(),
    transition: Transition.rightToLeft,
  ),
  GetPage(name: '/search', page: () => const SearchScreen()),
  GetPage(name: '/setting', page: () => SettingsScreen()),
  GetPage(name: '/offers', page: () => const OffersScreen()),
  GetPage(name: '/trip-details', page: () => const TripDetailsScreen()),
  GetPage(name: '/reviews', page: () => const ReviewsScreen()),
  GetPage(name: '/company-profile', page: () => const CompanyProfileScreen()),
  GetPage(name: '/requests', page: () => const RequestsScreen()),
  GetPage(name: '/waiting', page: () => const WaitingScreen()),
  GetPage(name: '/home', page: () => const HomeScreen()),
  GetPage(name: '/article', page: () => const ArticleScreen()),
  GetPage(name: '/my-offers', page: () => const MyOffersScreen()),
  GetPage(name: '/notifications', page: () => const NotificationsScreen()),
  GetPage(name: '/offer-details', page: () => const OfferDetailsScreen()),
  GetPage(name: '/messages', page: () => const MessagesScreen()),
  GetPage(name: '/chat', page: () => const ChatScreen()),
  GetPage(name: '/send-offer', page: () => const SendOfferScreen()),
  GetPage(name: '/404', page: () => const NotFoundScreen()),
];
