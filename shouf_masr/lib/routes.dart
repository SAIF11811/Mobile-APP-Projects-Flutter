import 'package:get/get.dart';
import 'package:shouf_masr/screens/agency_auth.dart';
import 'package:shouf_masr/screens/agency_login.dart';
import 'package:shouf_masr/screens/agency_notifications_screen.dart';
import 'package:shouf_masr/screens/agency_profile_screen.dart';
import 'package:shouf_masr/screens/traveler_profile_screen.dart';
import 'screens/splash_screen.dart';
import 'screens/role_selection.dart';
import 'screens/traveler_auth.dart';
import 'screens/traveler_login.dart';
import 'screens/traveler_signup.dart';
import 'screens/agency_signup.dart';
import 'screens/agency_contact.dart';
import 'screens/search_screen.dart';
import 'screens/offers_screen.dart';
import 'screens/company_profile.dart';
import 'screens/waiting_screen.dart';
import 'screens/home_screen.dart';
import 'screens/article_screen.dart';
import 'screens/traveler_notifications_screen.dart';
import 'screens/offer_details_screen.dart';
import 'screens/chat_screen.dart';
import 'screens/send_offer_screen.dart';

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
    name: '/agency-auth',
    page: () => const AgencyAuth(),
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
  GetPage(
    name: '/agency-login',
    page: () => const AgencyLogin(),
    transition: Transition.rightToLeft,
  ),
  GetPage(name: '/search', page: () => const SearchScreen()),
  GetPage(name: '/agency-profile', page: () => AgencyProfileScreen()),
  GetPage(name: '/traveler-profile', page: () => TravelerSettingsScreen()),
  GetPage(name: '/offers', page: () => const OffersScreen()),
  GetPage(name: '/company-profile', page: () => const CompanyProfileScreen(company: {},)),
  GetPage(name: '/waiting', page: () => const WaitingScreen()),
  GetPage(name: '/home', page: () => const HomeScreen()),
  GetPage(name: '/article', page: () => const ArticleScreen(article: {},)),
  GetPage(name: '/traveler_notifications', page: () => TravelerNotificationsScreen()),
  GetPage(name: '/agency_notifications', page: () => AgencyNotificationsScreen()),
  GetPage(name: '/offer-details', page: () => const OfferDetailsScreen(article: {},)),
  GetPage(name: '/chat', page: () => const ChatScreen()),
  GetPage(name: '/send-offer', page: () => SendOfferScreen()),
  GetPage(name: '/wait', page: () => WaitingScreen()),
];
