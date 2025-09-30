import 'package:get/get.dart';

class AgencyNotificationsController extends GetxController {
  // Reactive list of offers
  final RxList<Map<String, dynamic>> agencyOffers = <Map<String, dynamic>>[
    {
      "person": "Ahmed Ali",
      "destination": "Giza Pyramids",
      "duration": "2 days",
      "budget": 1500,
      "members": 2,
      "time": "2m ago",
    },
    {
      "person": "Sara Hassan",
      "destination": "Luxor to Aswan",
      "duration": "3 days",
      "budget": 3000,
      "members": 4,
      "time": "15m ago",
    },
    {
      "person": "Mohamed Farouk",
      "destination": "White Desert",
      "duration": "1 day",
      "budget": 1200,
      "members": 1,
      "time": "1h ago",
    },
    {
      "person": "Nour Adel",
      "destination": "Sharm El-Sheikh",
      "duration": "5 days",
      "budget": 5000,
      "members": 3,
      "time": "3h ago",
    },
    {
      "person": "Khaled Mostafa",
      "destination": "Egyptian Museum",
      "duration": "Half day",
      "budget": 300,
      "members": 1,
      "time": "Yesterday",
    },
    {
      "person": "Mona Samir",
      "destination": "Luxor & Karnak temples",
      "duration": "2 days",
      "budget": 2000,
      "members": 2,
      "time": "2d ago",
    },
    {
      "person": "Omar Taha",
      "destination": "Siwa Oasis",
      "duration": "3 days",
      "budget": 4000,
      "members": 2,
      "time": "3d ago",
    },
  ].obs;

  void removeOffer(int index) {
    agencyOffers.removeAt(index);
  }
}
