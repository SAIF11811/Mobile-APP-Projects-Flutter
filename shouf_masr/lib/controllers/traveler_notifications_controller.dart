import 'package:get/get.dart';

class TravelerNotificationsController extends GetxController {
  final RxList<Map<String, String>> notifications = <Map<String, String>>[
    {
      "title": "Pharaoh Travels",
      "message": "Exclusive discount for a Giza Pyramids tour this weekend!",
      "time": "2m ago"
    },
    {
      "title": "Nile Star Cruises",
      "message": "Your luxury cruise booking has been confirmed.",
      "time": "15m ago"
    },
    {
      "title": "Desert Horizon",
      "message": "Join our safari adventure to the White Desert.",
      "time": "1h ago"
    },
    {
      "title": "Red Sea Voyages",
      "message": "Snorkeling and diving packages are now available.",
      "time": "3h ago"
    },
    {
      "title": "Cairo Heritage Tours",
      "message": "Don’t miss the new exhibition at the Egyptian Museum.",
      "time": "Yesterday"
    },
    {
      "title": "Lotus Travel Agency",
      "message": "Enjoy a guided tour of Luxor and Karnak temples.",
      "time": "2d ago"
    },
    {
      "title": "Oasis Explorer",
      "message": "Experience Siwa Oasis with our special package.",
      "time": "3d ago"
    },
  ].obs;
}
