import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import '../widgets/components.dart';
import 'chat_screen.dart';
import 'company_profile.dart';

class AvailableOffersScreen extends StatefulWidget {
  final String home;
  final String destination;
  final String adults;
  final String children;
  final String dates;
  final String budget;

  const AvailableOffersScreen({
    super.key,
    required this.home,
    required this.destination,
    required this.adults,
    required this.children,
    required this.dates,
    required this.budget,
  });

  @override
  State<AvailableOffersScreen> createState() => _AvailableOffersScreenState();
}

class _AvailableOffersScreenState extends State<AvailableOffersScreen>
    with SingleTickerProviderStateMixin {
  int _tappedIndex = -1;
  bool _isLoading = true;
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    // loading delay
    Future.delayed(const Duration(seconds: 2), () {
      setState(() {
        _isLoading = false;
      });
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  final List<Map<String, dynamic>> articles = [
    {
      "image": "assets/images/2.jpeg",
      "title": "Walking Through the Temples of Luxor",
      "author": "By Ancient Trails",
      "days": "3 Days",
      "price": "\$350",
      "rating": 4.8,
      "company": {
        "name": "Ancient Trails",
        "description":
        "Ancient Trails specializes in immersive cultural journeys across Egypt. Our focus is on ancient temples, ruins, and heritage sites. With professional Egyptologists as guides, travelers gain unique insights into Egyptian history and traditions.",
        "rating": 5,
        "trips": [
          "Guided tours of Karnak and Luxor Temples",
          "Evening light-and-sound show at Karnak",
          "Visit to the Valley of the Kings and Queens",
        ],
        "packages": [
          "3-day Luxor cultural experience",
          "7-day heritage-focused Nile Valley package",
        ],
        "reviews": [
          {
            "text": "The guides were incredibly knowledgeable and brought history to life!",
            "rating": 5,
          },
          {
            "text": "Perfect for history lovers who enjoy detailed explanations.",
            "rating": 4,
          },
        ],
      }
    },
    {
      "image": "assets/images/3.jpeg",
      "title": "A Timeless Journey Sailing the Nile",
      "author": "By Nile Cruises",
      "days": "5 Days",
      "price": "\$1200",
      "rating": 4.8,
      "company": {
        "name": "Nile Cruises",
        "description":
        "Nile Cruises offers luxurious voyages along the Nile, combining relaxation with cultural exploration. Guests enjoy 5-star service, onboard entertainment, and excursions to temples and riverside villages.",
        "rating": 4.9,
        "trips": [
          "4-night cruise from Luxor to Aswan",
          "Sunset sailing with live traditional music",
          "Exclusive visit to Philae Temple by boat",
        ],
        "packages": [
          "Luxury Nile Cruise with daily excursions",
          "Romantic 5-day honeymoon package",
        ],
        "reviews": [
          {
            "text": "The cruise was unforgettable – the views were breathtaking!",
            "rating": 5,
          },
          {
            "text": "Fantastic food, friendly staff, and perfectly organized tours.",
            "rating": 4,
          },
        ],
      }
    },
    {
      "image": "assets/images/4.jpeg",
      "title": "Discovering Peace at Siwa Oasis",
      "author": "By Desert Explorer",
      "days": "4 Days",
      "price": "\$480",
      "rating": 3.9,
      "company": {
        "name": "Desert Explorer",
        "description":
        "Desert Explorer curates adventures in Egypt’s deserts, focusing on oases, dunes, and stargazing experiences. We emphasize eco-friendly tourism and authentic interactions with local communities.",
        "rating": 4,
        "trips": [
          "4x4 jeep safari across the Great Sand Sea",
          "Traditional dinner under the stars at Siwa",
          "Visit to Cleopatra’s Spring and Siwa salt lakes",
        ],
        "packages": [
          "Weekend desert camping experience",
          "5-day Sahara expedition with local guides",
        ],
        "reviews": [
          {
            "text": "Loved the desert nights – so peaceful and magical!",
            "rating": 5,
          },
          {
            "text":
            "Friendly guides and a very authentic experience, though a bit basic.",
            "rating": 3,
          },
        ],
      }
    },
    {
      "image": "assets/images/6.jpeg",
      "title": "Inside the Egyptian Museum of Cairo",
      "author": "By Heritage Guide",
      "days": "2 Days",
      "price": "\$250",
      "rating": 4.2,
      "company": {
        "name": "Heritage Guide",
        "description":
        "Heritage Guide offers expert-led museum tours across Cairo, focusing on Egypt’s heritage and priceless treasures. Tours are designed for both casual visitors and academic researchers.",
        "rating": 4.5,
        "trips": [
          "Half-day tour of the Egyptian Museum",
          "Special Tutankhamun exhibition visit",
          "Evening lecture on ancient Egyptian art",
        ],
        "packages": [
          "Private guided museum tour for families",
          "Full-day Cairo museums and monuments package",
        ],
        "reviews": [
          {
            "text": "Very informative – the guide explained artifacts in an engaging way.",
            "rating": 4,
          },
          {
            "text":
            "Perfect for families and history enthusiasts. Highly recommended!",
            "rating": 5,
          },
        ],
      }
    },
  ];

  final List<Map<String, dynamic>> offers = [
    // 1. Cairo
    {"title": "Cairo", "desc": "3 Days", "price": "\$400", "members": "20"},
    {"title": "Cairo", "desc": "5 Days", "price": "\$650", "members": "18"},
    {"title": "Cairo", "desc": "7 Days", "price": "\$950", "members": "12"},
    {"title": "Cairo", "desc": "10 Days", "price": "\$1350", "members": "8"},
    {"title": "Cairo", "desc": "14 Days", "price": "\$1850", "members": "5"},

    // 2. Luxor
    {"title": "Luxor", "desc": "3 Days", "price": "\$500", "members": "15"},
    {"title": "Luxor", "desc": "5 Days", "price": "\$800", "members": "12"},
    {"title": "Luxor", "desc": "7 Days", "price": "\$1100", "members": "9"},
    {"title": "Luxor", "desc": "10 Days", "price": "\$1500", "members": "6"},
    {"title": "Luxor", "desc": "14 Days", "price": "\$2000", "members": "4"},

    // 3. Aswan
    {"title": "Aswan", "desc": "3 Days", "price": "\$480", "members": "16"},
    {"title": "Aswan", "desc": "5 Days", "price": "\$750", "members": "12"},
    {"title": "Aswan", "desc": "7 Days", "price": "\$1050", "members": "9"},
    {"title": "Aswan", "desc": "10 Days", "price": "\$1450", "members": "6"},
    {"title": "Aswan", "desc": "12 Days", "price": "\$1750", "members": "4"},

    // 4. Sharm El-Sheikh
    {
      "title": "Sharm El-Sheikh",
      "desc": "4 Days",
      "price": "\$600",
      "members": "15",
    },
    {
      "title": "Sharm El-Sheikh",
      "desc": "6 Days",
      "price": "\$900",
      "members": "10",
    },
    {
      "title": "Sharm El-Sheikh",
      "desc": "8 Days",
      "price": "\$1300",
      "members": "7",
    },
    {
      "title": "Sharm El-Sheikh",
      "desc": "10 Days",
      "price": "\$1650",
      "members": "5",
    },
    {
      "title": "Sharm El-Sheikh",
      "desc": "14 Days",
      "price": "\$2200",
      "members": "3",
    },

    // 5. Hurghada
    {"title": "Hurghada", "desc": "5 Days", "price": "\$700", "members": "10"},
    {"title": "Hurghada", "desc": "7 Days", "price": "\$1050", "members": "8"},
    {"title": "Hurghada", "desc": "10 Days", "price": "\$1500", "members": "5"},
    {"title": "Hurghada", "desc": "12 Days", "price": "\$1750", "members": "4"},
    {"title": "Hurghada", "desc": "14 Days", "price": "\$2100", "members": "2"},

    // 6. Alexandria
    {
      "title": "Alexandria",
      "desc": "2 Days",
      "price": "\$300",
      "members": "25",
    },
    {
      "title": "Alexandria",
      "desc": "4 Days",
      "price": "\$550",
      "members": "20",
    },
    {
      "title": "Alexandria",
      "desc": "6 Days",
      "price": "\$800",
      "members": "15",
    },
    {
      "title": "Alexandria",
      "desc": "8 Days",
      "price": "\$1050",
      "members": "12",
    },
    {
      "title": "Alexandria",
      "desc": "10 Days",
      "price": "\$1350",
      "members": "9",
    },

    // 7. Giza
    {"title": "Giza", "desc": "1 Day", "price": "\$150", "members": "40"},
    {"title": "Giza", "desc": "3 Days", "price": "\$450", "members": "20"},
    {"title": "Giza", "desc": "5 Days", "price": "\$700", "members": "12"},
    {"title": "Giza", "desc": "7 Days", "price": "\$950", "members": "8"},
    {"title": "Giza", "desc": "10 Days", "price": "\$1350", "members": "6"},

    // 8. Siwa Oasis
    {"title": "Siwa Oasis", "desc": "4 Days", "price": "\$550", "members": "8"},
    {"title": "Siwa Oasis", "desc": "6 Days", "price": "\$780", "members": "6"},
    {
      "title": "Siwa Oasis",
      "desc": "8 Days",
      "price": "\$1100",
      "members": "4",
    },
    {
      "title": "Siwa Oasis",
      "desc": "10 Days",
      "price": "\$1350",
      "members": "3",
    },
    {
      "title": "Siwa Oasis",
      "desc": "12 Days",
      "price": "\$1600",
      "members": "2",
    },

    // 9. Dahab
    {"title": "Dahab", "desc": "3 Days", "price": "\$500", "members": "14"},
    {"title": "Dahab", "desc": "5 Days", "price": "\$750", "members": "10"},
    {"title": "Dahab", "desc": "7 Days", "price": "\$1050", "members": "6"},
    {"title": "Dahab", "desc": "9 Days", "price": "\$1300", "members": "5"},
    {"title": "Dahab", "desc": "12 Days", "price": "\$1700", "members": "3"},

    // 10. Marsa Alam
    {"title": "Marsa Alam", "desc": "5 Days", "price": "\$750", "members": "9"},
    {
      "title": "Marsa Alam",
      "desc": "7 Days",
      "price": "\$1100",
      "members": "7",
    },
    {
      "title": "Marsa Alam",
      "desc": "10 Days",
      "price": "\$1600",
      "members": "5",
    },
    {
      "title": "Marsa Alam",
      "desc": "12 Days",
      "price": "\$1850",
      "members": "4",
    },
    {
      "title": "Marsa Alam",
      "desc": "14 Days",
      "price": "\$2200",
      "members": "2",
    },
    // 11. Fayoum Oasis
    {
      "title": "Fayoum Oasis",
      "desc": "2 Days",
      "price": "\$350",
      "members": "18",
    },
    {
      "title": "Fayoum Oasis",
      "desc": "4 Days",
      "price": "\$600",
      "members": "12",
    },
    {
      "title": "Fayoum Oasis",
      "desc": "6 Days",
      "price": "\$850",
      "members": "8",
    },
    {
      "title": "Fayoum Oasis",
      "desc": "8 Days",
      "price": "\$1100",
      "members": "6",
    },
    {
      "title": "Fayoum Oasis",
      "desc": "10 Days",
      "price": "\$1400",
      "members": "4",
    },

    // 12. Abu Simbel
    {
      "title": "Abu Simbel",
      "desc": "2 Days",
      "price": "\$400",
      "members": "11",
    },
    {"title": "Abu Simbel", "desc": "3 Days", "price": "\$600", "members": "7"},
    {"title": "Abu Simbel", "desc": "5 Days", "price": "\$850", "members": "5"},
    {
      "title": "Abu Simbel",
      "desc": "7 Days",
      "price": "\$1150",
      "members": "3",
    },
    {
      "title": "Abu Simbel",
      "desc": "10 Days",
      "price": "\$1500",
      "members": "2",
    },

    // 13. Port Said
    {"title": "Port Said", "desc": "2 Days", "price": "\$350", "members": "15"},
    {"title": "Port Said", "desc": "4 Days", "price": "\$600", "members": "10"},
    {"title": "Port Said", "desc": "6 Days", "price": "\$850", "members": "8"},
    {"title": "Port Said", "desc": "8 Days", "price": "\$1100", "members": "6"},
    {
      "title": "Port Said",
      "desc": "10 Days",
      "price": "\$1400",
      "members": "4",
    },

    // 14. Taba
    {"title": "Taba", "desc": "3 Days", "price": "\$500", "members": "12"},
    {"title": "Taba", "desc": "5 Days", "price": "\$750", "members": "9"},
    {"title": "Taba", "desc": "7 Days", "price": "\$1050", "members": "6"},
    {"title": "Taba", "desc": "9 Days", "price": "\$1350", "members": "4"},
    {"title": "Taba", "desc": "12 Days", "price": "\$1700", "members": "2"},

    // 15. Nuweiba
    {"title": "Nuweiba", "desc": "3 Days", "price": "\$480", "members": "10"},
    {"title": "Nuweiba", "desc": "5 Days", "price": "\$720", "members": "8"},
    {"title": "Nuweiba", "desc": "7 Days", "price": "\$1050", "members": "5"},
    {"title": "Nuweiba", "desc": "9 Days", "price": "\$1300", "members": "3"},
    {"title": "Nuweiba", "desc": "12 Days", "price": "\$1650", "members": "2"},

    // 16. Ismailia
    {"title": "Ismailia", "desc": "2 Days", "price": "\$300", "members": "20"},
    {"title": "Ismailia", "desc": "4 Days", "price": "\$550", "members": "15"},
    {"title": "Ismailia", "desc": "6 Days", "price": "\$800", "members": "10"},
    {"title": "Ismailia", "desc": "8 Days", "price": "\$1100", "members": "7"},
    {"title": "Ismailia", "desc": "10 Days", "price": "\$1400", "members": "5"},

    // 17. Ras Sudr
    {"title": "Ras Sudr", "desc": "3 Days", "price": "\$400", "members": "14"},
    {"title": "Ras Sudr", "desc": "5 Days", "price": "\$650", "members": "10"},
    {"title": "Ras Sudr", "desc": "7 Days", "price": "\$950", "members": "7"},
    {"title": "Ras Sudr", "desc": "9 Days", "price": "\$1250", "members": "5"},
    {"title": "Ras Sudr", "desc": "12 Days", "price": "\$1600", "members": "3"},

    // 18. Minya
    {"title": "Minya", "desc": "2 Days", "price": "\$300", "members": "18"},
    {"title": "Minya", "desc": "4 Days", "price": "\$550", "members": "12"},
    {"title": "Minya", "desc": "6 Days", "price": "\$800", "members": "9"},
    {"title": "Minya", "desc": "8 Days", "price": "\$1100", "members": "6"},
    {"title": "Minya", "desc": "10 Days", "price": "\$1400", "members": "4"},

    // 19. Beni Suef
    {"title": "Beni Suef", "desc": "2 Days", "price": "\$320", "members": "15"},
    {"title": "Beni Suef", "desc": "4 Days", "price": "\$580", "members": "11"},
    {"title": "Beni Suef", "desc": "6 Days", "price": "\$850", "members": "8"},
    {"title": "Beni Suef", "desc": "8 Days", "price": "\$1150", "members": "6"},
    {
      "title": "Beni Suef",
      "desc": "10 Days",
      "price": "\$1450",
      "members": "4",
    },

    // 20. Sohag
    {"title": "Sohag", "desc": "3 Days", "price": "\$450", "members": "12"},
    {"title": "Sohag", "desc": "5 Days", "price": "\$700", "members": "9"},
    {"title": "Sohag", "desc": "7 Days", "price": "\$1000", "members": "6"},
    {"title": "Sohag", "desc": "9 Days", "price": "\$1300", "members": "4"},
    {"title": "Sohag", "desc": "12 Days", "price": "\$1650", "members": "2"},

    // 21. Qena
    {"title": "Qena", "desc": "2 Days", "price": "\$320", "members": "14"},
    {"title": "Qena", "desc": "4 Days", "price": "\$600", "members": "10"},
    {"title": "Qena", "desc": "6 Days", "price": "\$880", "members": "7"},
    {"title": "Qena", "desc": "8 Days", "price": "\$1150", "members": "5"},
    {"title": "Qena", "desc": "10 Days", "price": "\$1450", "members": "3"},

    // 22. Kom Ombo
    {"title": "Kom Ombo", "desc": "2 Days", "price": "\$300", "members": "12"},
    {"title": "Kom Ombo", "desc": "4 Days", "price": "\$550", "members": "9"},
    {"title": "Kom Ombo", "desc": "6 Days", "price": "\$820", "members": "6"},
    {"title": "Kom Ombo", "desc": "8 Days", "price": "\$1100", "members": "4"},
    {"title": "Kom Ombo", "desc": "10 Days", "price": "\$1400", "members": "2"},

    // 23. Damietta
    {"title": "Damietta", "desc": "3 Days", "price": "\$400", "members": "18"},
    {"title": "Damietta", "desc": "5 Days", "price": "\$650", "members": "12"},
    {"title": "Damietta", "desc": "7 Days", "price": "\$950", "members": "8"},
    {"title": "Damietta", "desc": "9 Days", "price": "\$1250", "members": "6"},
    {"title": "Damietta", "desc": "12 Days", "price": "\$1600", "members": "3"},

    // 24. Mansoura
    {"title": "Mansoura", "desc": "2 Days", "price": "\$280", "members": "20"},
    {"title": "Mansoura", "desc": "4 Days", "price": "\$520", "members": "15"},
    {"title": "Mansoura", "desc": "6 Days", "price": "\$780", "members": "10"},
    {"title": "Mansoura", "desc": "8 Days", "price": "\$1050", "members": "7"},
    {"title": "Mansoura", "desc": "10 Days", "price": "\$1350", "members": "5"},

    // 25. Zagazig
    {"title": "Zagazig", "desc": "3 Days", "price": "\$350", "members": "16"},
    {"title": "Zagazig", "desc": "5 Days", "price": "\$600", "members": "12"},
    {"title": "Zagazig", "desc": "7 Days", "price": "\$900", "members": "8"},
    {"title": "Zagazig", "desc": "9 Days", "price": "\$1200", "members": "6"},
    {"title": "Zagazig", "desc": "12 Days", "price": "\$1550", "members": "3"},

    // 26. Suez
    {"title": "Suez", "desc": "2 Days", "price": "\$300", "members": "18"},
    {"title": "Suez", "desc": "4 Days", "price": "\$550", "members": "14"},
    {"title": "Suez", "desc": "6 Days", "price": "\$800", "members": "9"},
    {"title": "Suez", "desc": "8 Days", "price": "\$1100", "members": "6"},
    {"title": "Suez", "desc": "10 Days", "price": "\$1400", "members": "4"},

    // 27. Al Arish
    {"title": "Al Arish", "desc": "3 Days", "price": "\$420", "members": "15"},
    {"title": "Al Arish", "desc": "5 Days", "price": "\$680", "members": "11"},
    {"title": "Al Arish", "desc": "7 Days", "price": "\$950", "members": "7"},
    {"title": "Al Arish", "desc": "9 Days", "price": "\$1250", "members": "5"},
    {"title": "Al Arish", "desc": "12 Days", "price": "\$1600", "members": "3"},

    // 28. Sinai
    {"title": "Sinai", "desc": "4 Days", "price": "\$600", "members": "14"},
    {"title": "Sinai", "desc": "6 Days", "price": "\$850", "members": "10"},
    {"title": "Sinai", "desc": "8 Days", "price": "\$1150", "members": "7"},
    {"title": "Sinai", "desc": "10 Days", "price": "\$1450", "members": "5"},
    {"title": "Sinai", "desc": "12 Days", "price": "\$1750", "members": "3"},

    // 29. El Alamein
    {
      "title": "El Alamein",
      "desc": "2 Days",
      "price": "\$400",
      "members": "20",
    },
    {
      "title": "El Alamein",
      "desc": "4 Days",
      "price": "\$650",
      "members": "15",
    },
    {
      "title": "El Alamein",
      "desc": "6 Days",
      "price": "\$900",
      "members": "10",
    },
    {
      "title": "El Alamein",
      "desc": "8 Days",
      "price": "\$1200",
      "members": "6",
    },
    {
      "title": "El Alamein",
      "desc": "10 Days",
      "price": "\$1500",
      "members": "4",
    },

    // 30. Marsa Matruh
    {
      "title": "Marsa Matruh",
      "desc": "3 Days",
      "price": "\$450",
      "members": "18",
    },
    {
      "title": "Marsa Matruh",
      "desc": "5 Days",
      "price": "\$700",
      "members": "12",
    },
    {
      "title": "Marsa Matruh",
      "desc": "7 Days",
      "price": "\$950",
      "members": "8",
    },
    {
      "title": "Marsa Matruh",
      "desc": "9 Days",
      "price": "\$1250",
      "members": "6",
    },
    {
      "title": "Marsa Matruh",
      "desc": "12 Days",
      "price": "\$1600",
      "members": "3",
    },

    // 31. Taba
    {"title": "Taba", "desc": "2 Days", "price": "\$380", "members": "16"},
    {"title": "Taba", "desc": "4 Days", "price": "\$620", "members": "12"},
    {"title": "Taba", "desc": "6 Days", "price": "\$900", "members": "8"},
    {"title": "Taba", "desc": "8 Days", "price": "\$1180", "members": "6"},
    {"title": "Taba", "desc": "10 Days", "price": "\$1450", "members": "3"},

    // 32. Nuweiba
    {"title": "Nuweiba", "desc": "3 Days", "price": "\$400", "members": "15"},
    {"title": "Nuweiba", "desc": "5 Days", "price": "\$650", "members": "11"},
    {"title": "Nuweiba", "desc": "7 Days", "price": "\$950", "members": "7"},
    {"title": "Nuweiba", "desc": "9 Days", "price": "\$1250", "members": "5"},
    {"title": "Nuweiba", "desc": "12 Days", "price": "\$1600", "members": "3"},

    // 33. Fayoum
    {"title": "Fayoum", "desc": "2 Days", "price": "\$300", "members": "18"},
    {"title": "Fayoum", "desc": "4 Days", "price": "\$550", "members": "14"},
    {"title": "Fayoum", "desc": "6 Days", "price": "\$820", "members": "9"},
    {"title": "Fayoum", "desc": "8 Days", "price": "\$1100", "members": "6"},
    {"title": "Fayoum", "desc": "10 Days", "price": "\$1400", "members": "4"},

    // 34. Minya
    {"title": "Minya", "desc": "3 Days", "price": "\$370", "members": "20"},
    {"title": "Minya", "desc": "5 Days", "price": "\$620", "members": "15"},
    {"title": "Minya", "desc": "7 Days", "price": "\$880", "members": "10"},
    {"title": "Minya", "desc": "9 Days", "price": "\$1150", "members": "7"},
    {"title": "Minya", "desc": "12 Days", "price": "\$1500", "members": "4"},

    // 35. Beni Suef
    {"title": "Beni Suef", "desc": "2 Days", "price": "\$280", "members": "22"},
    {"title": "Beni Suef", "desc": "4 Days", "price": "\$520", "members": "16"},
    {"title": "Beni Suef", "desc": "6 Days", "price": "\$780", "members": "12"},
    {"title": "Beni Suef", "desc": "8 Days", "price": "\$1050", "members": "8"},
    {
      "title": "Beni Suef",
      "desc": "10 Days",
      "price": "\$1350",
      "members": "5",
    },

    // 36. Sohag
    {"title": "Sohag", "desc": "3 Days", "price": "\$360", "members": "18"},
    {"title": "Sohag", "desc": "5 Days", "price": "\$600", "members": "14"},
    {"title": "Sohag", "desc": "7 Days", "price": "\$880", "members": "9"},
    {"title": "Sohag", "desc": "9 Days", "price": "\$1150", "members": "6"},
    {"title": "Sohag", "desc": "12 Days", "price": "\$1500", "members": "4"},

    // 37. Quseir
    {"title": "Quseir", "desc": "2 Days", "price": "\$340", "members": "17"},
    {"title": "Quseir", "desc": "4 Days", "price": "\$580", "members": "13"},
    {"title": "Quseir", "desc": "6 Days", "price": "\$860", "members": "8"},
    {"title": "Quseir", "desc": "8 Days", "price": "\$1150", "members": "6"},
    {"title": "Quseir", "desc": "10 Days", "price": "\$1450", "members": "3"},

    // 38. Safaga
    {"title": "Safaga", "desc": "3 Days", "price": "\$420", "members": "16"},
    {"title": "Safaga", "desc": "5 Days", "price": "\$670", "members": "11"},
    {"title": "Safaga", "desc": "7 Days", "price": "\$950", "members": "7"},
    {"title": "Safaga", "desc": "9 Days", "price": "\$1250", "members": "5"},
    {"title": "Safaga", "desc": "12 Days", "price": "\$1600", "members": "3"},

    // 39. Ras Sudr
    {"title": "Ras Sudr", "desc": "2 Days", "price": "\$310", "members": "20"},
    {"title": "Ras Sudr", "desc": "4 Days", "price": "\$550", "members": "14"},
    {"title": "Ras Sudr", "desc": "6 Days", "price": "\$820", "members": "9"},
    {"title": "Ras Sudr", "desc": "8 Days", "price": "\$1100", "members": "6"},
    {"title": "Ras Sudr", "desc": "10 Days", "price": "\$1400", "members": "4"},

    // 40. Ismailia
    {"title": "Ismailia", "desc": "3 Days", "price": "\$400", "members": "18"},
    {"title": "Ismailia", "desc": "5 Days", "price": "\$650", "members": "12"},
    {"title": "Ismailia", "desc": "7 Days", "price": "\$920", "members": "8"},
    {"title": "Ismailia", "desc": "9 Days", "price": "\$1200", "members": "6"},
    {"title": "Ismailia", "desc": "12 Days", "price": "\$1550", "members": "3"},
    // 41. Dakhla Oasis
    {
      "title": "Dakhla Oasis",
      "desc": "3 Days",
      "price": "\$420",
      "members": "14",
    },
    {
      "title": "Dakhla Oasis",
      "desc": "5 Days",
      "price": "\$680",
      "members": "10",
    },
    {
      "title": "Dakhla Oasis",
      "desc": "7 Days",
      "price": "\$950",
      "members": "7",
    },
    {
      "title": "Dakhla Oasis",
      "desc": "9 Days",
      "price": "\$1250",
      "members": "5",
    },
    {
      "title": "Dakhla Oasis",
      "desc": "12 Days",
      "price": "\$1600",
      "members": "3",
    },

    // 42. Kharga Oasis
    {
      "title": "Kharga Oasis",
      "desc": "2 Days",
      "price": "\$350",
      "members": "16",
    },
    {
      "title": "Kharga Oasis",
      "desc": "4 Days",
      "price": "\$600",
      "members": "12",
    },
    {
      "title": "Kharga Oasis",
      "desc": "6 Days",
      "price": "\$880",
      "members": "8",
    },
    {
      "title": "Kharga Oasis",
      "desc": "8 Days",
      "price": "\$1150",
      "members": "6",
    },
    {
      "title": "Kharga Oasis",
      "desc": "10 Days",
      "price": "\$1450",
      "members": "4",
    },

    // 43. Marsa Matrouh
    {
      "title": "Marsa Matrouh",
      "desc": "3 Days",
      "price": "\$400",
      "members": "20",
    },
    {
      "title": "Marsa Matrouh",
      "desc": "5 Days",
      "price": "\$650",
      "members": "15",
    },
    {
      "title": "Marsa Matrouh",
      "desc": "7 Days",
      "price": "\$900",
      "members": "10",
    },
    {
      "title": "Marsa Matrouh",
      "desc": "9 Days",
      "price": "\$1200",
      "members": "7",
    },
    {
      "title": "Marsa Matrouh",
      "desc": "12 Days",
      "price": "\$1550",
      "members": "4",
    },

    // 44. Alamein
    {"title": "Alamein", "desc": "2 Days", "price": "\$300", "members": "22"},
    {"title": "Alamein", "desc": "4 Days", "price": "\$520", "members": "16"},
    {"title": "Alamein", "desc": "6 Days", "price": "\$800", "members": "12"},
    {"title": "Alamein", "desc": "8 Days", "price": "\$1050", "members": "8"},
    {"title": "Alamein", "desc": "10 Days", "price": "\$1350", "members": "5"},

    // 45. Damietta
    {"title": "Damietta", "desc": "3 Days", "price": "\$370", "members": "18"},
    {"title": "Damietta", "desc": "5 Days", "price": "\$600", "members": "14"},
    {"title": "Damietta", "desc": "7 Days", "price": "\$880", "members": "9"},
    {"title": "Damietta", "desc": "9 Days", "price": "\$1150", "members": "6"},
    {"title": "Damietta", "desc": "12 Days", "price": "\$1500", "members": "4"},

    // 46. Zagazig
    {"title": "Zagazig", "desc": "2 Days", "price": "\$280", "members": "25"},
    {"title": "Zagazig", "desc": "4 Days", "price": "\$520", "members": "18"},
    {"title": "Zagazig", "desc": "6 Days", "price": "\$780", "members": "12"},
    {"title": "Zagazig", "desc": "8 Days", "price": "\$1050", "members": "8"},
    {"title": "Zagazig", "desc": "10 Days", "price": "\$1350", "members": "5"},

    // 47. Suez
    {"title": "Suez", "desc": "3 Days", "price": "\$420", "members": "20"},
    {"title": "Suez", "desc": "5 Days", "price": "\$670", "members": "14"},
    {"title": "Suez", "desc": "7 Days", "price": "\$940", "members": "10"},
    {"title": "Suez", "desc": "9 Days", "price": "\$1200", "members": "6"},
    {"title": "Suez", "desc": "12 Days", "price": "\$1550", "members": "4"},

    // 48. Mansoura
    {"title": "Mansoura", "desc": "2 Days", "price": "\$320", "members": "18"},
    {"title": "Mansoura", "desc": "4 Days", "price": "\$560", "members": "14"},
    {"title": "Mansoura", "desc": "6 Days", "price": "\$830", "members": "10"},
    {"title": "Mansoura", "desc": "8 Days", "price": "\$1100", "members": "7"},
    {"title": "Mansoura", "desc": "10 Days", "price": "\$1400", "members": "5"},

    // 49. Banha
    {"title": "Banha", "desc": "3 Days", "price": "\$360", "members": "16"},
    {"title": "Banha", "desc": "5 Days", "price": "\$600", "members": "12"},
    {"title": "Banha", "desc": "7 Days", "price": "\$870", "members": "8"},
    {"title": "Banha", "desc": "9 Days", "price": "\$1150", "members": "5"},
    {"title": "Banha", "desc": "12 Days", "price": "\$1500", "members": "3"},

    // 50. Qalyub
    {"title": "Qalyub", "desc": "2 Days", "price": "\$300", "members": "20"},
    {"title": "Qalyub", "desc": "4 Days", "price": "\$540", "members": "15"},
    {"title": "Qalyub", "desc": "6 Days", "price": "\$810", "members": "10"},
    {"title": "Qalyub", "desc": "8 Days", "price": "\$1080", "members": "6"},
    {"title": "Qalyub", "desc": "10 Days", "price": "\$1400", "members": "4"},
  ];

  @override
  Widget build(BuildContext context) {
    int? enteredBudget = int.tryParse(widget.budget);

    int _calculateSelectedDays(String dateRange) {
      try {
        final parts = dateRange.split(" - ");
        if (parts.length != 2) return 0;

        DateTime parseDate(String s) {
          final dateRegex = RegExp(r'(\d{1,2})/(\d{1,2})/(\d{4})');
          final match = dateRegex.firstMatch(s.trim());
          if (match != null) {
            return DateTime(
              int.parse(match.group(3)!),
              int.parse(match.group(2)!),
              int.parse(match.group(1)!),
            );
          }
          throw FormatException();
        }

        final start = parseDate(parts[0]);
        final end = parseDate(parts[1]);
        return end.difference(start).inDays + 1;
      } catch (_) {
        return 0;
      }
    }

    bool _matchOfferDays(String offerDesc, int selectedDays) {
      final numbers = RegExp(r'\d+')
          .allMatches(offerDesc)
          .map((m) => int.parse(m.group(0)!))
          .toList();
      if (numbers.isEmpty) return true;

      final minDays = numbers.reduce((a, b) => a < b ? a : b);
      final maxDays = numbers.reduce((a, b) => a > b ? a : b);

      return selectedDays >= minDays && selectedDays <= maxDays;
    }

    final filteredOffers = offers.where((offer) {
      final price = int.tryParse(
        offer["price"]?.toString().replaceAll(RegExp(r'[^0-9]'), "") ?? "",
      ) ??
          0;

      final title = offer["title"]?.toString().toLowerCase() ?? "";
      final selectedDays = _calculateSelectedDays(widget.dates);

      // Destination match
      if (widget.destination.isNotEmpty &&
          widget.destination.toLowerCase() != "open" &&
          !title.contains(widget.destination.toLowerCase())) {
        return false;
      }

      // Budget match
      if (enteredBudget != null &&
          enteredBudget > 0 &&
          price > enteredBudget) {
        return false;
      }

      // Days match
      if (selectedDays > 0 &&
          !_matchOfferDays(offer["desc"]?.toString() ?? "", selectedDays)) {
        return false;
      }

      return true;
    }).toList();

    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFcdcc00),
        title: const Text("Available Offers"),
      ),
      backgroundColor: const Color(0xFFf5f5f5),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Filters Card
            Card(
              elevation: 6,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              shadowColor: Colors.black26,
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(Icons.travel_explore,
                            color: Colors.orange, size: 28),
                        const SizedBox(width: 8),
                        Text(
                          "Your Travel Plan",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.grey.shade800,
                          ),
                        ),
                      ],
                    ),
                    const Divider(
                        height: 20,
                        thickness: 1.2,
                        color: Colors.grey),
                    Row(
                      children: [
                        const Icon(Icons.home,
                            color: Colors.indigoAccent),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            widget.home.isEmpty
                                ? "Not Determined"
                                : widget.home,
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(Icons.location_on,
                            color: Colors.redAccent),
                        const SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            widget.destination.isEmpty
                                ? "All Destinations"
                                : widget.destination,
                            style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(Icons.people,
                            color: Colors.blueAccent),
                        const SizedBox(width: 8),
                        Text(
                          "${widget.adults} Adults, ${widget.children} Children",
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(Icons.date_range,
                            color: Colors.green),
                        const SizedBox(width: 8),
                        Text(
                          widget.dates,
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        const Icon(Icons.attach_money,
                            color: Colors.amber),
                        const SizedBox(width: 8),
                        Text(
                          widget.budget,
                          style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Center(
              child: Text(
                "Available Offers",
                style: TextStyle(
                    fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: filteredOffers.isEmpty
                  ? const Center(
                child: Text(
                  "No offers found for your criteria.",
                  style: TextStyle(
                      fontSize: 16, color: Colors.grey),
                ),
              )
                  : ListView.builder(
                padding: const EdgeInsets.only(bottom: 80),
                itemCount: filteredOffers.length,
                itemBuilder: (context, i) {
                  final offer = filteredOffers[i];
                  final article =
                  i < articles.length ? articles[i] : null;
                  final company = article?['company']
                  as Map<String, dynamic>?;

                  // Slide animation
                  final animation = Tween<Offset>(
                    begin: const Offset(1, 0),
                    end: Offset.zero,
                  ).animate(
                    CurvedAnimation(
                      parent: _controller,
                      curve: Interval(
                        i * 0.1,
                        1.0,
                        curve: Curves.easeOut,
                      ),
                    ),
                  );

                  return SlideTransition(
                    position: animation,
                    child: GestureDetector(
                      onTapDown: (_) =>
                          setState(() => _tappedIndex = i),
                      onTapUp: (_) =>
                          setState(() => _tappedIndex = -1),
                      onTapCancel: () =>
                          setState(() => _tappedIndex = -1),
                      child: AnimatedScale(
                        scale: _tappedIndex == i ? 0.97 : 1.0,
                        duration: const Duration(milliseconds: 150),
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 10),
                          decoration: BoxDecoration(
                            color:
                            Colors.white.withOpacity(0.9),
                            borderRadius:
                            BorderRadius.circular(16),
                            boxShadow: const [
                              BoxShadow(
                                color: Colors.black26,
                                blurRadius: 6,
                                offset: Offset(0, 3),
                              ),
                            ],
                          ),
                          padding: const EdgeInsets.all(14),
                          child: Column(
                            crossAxisAlignment:
                            CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Company: ${company?['name'] ?? 'Agency'}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.end,
                              ),

                              // Destination
                              Text(
                                'Destination: ${offer['title']?.toString() ?? 'Unknown Destination'}',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                                overflow:
                                TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 20),

                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment
                                    .spaceEvenly,
                                children: [
                                  Column(
                                    children: [
                                      const Icon(
                                          Icons
                                              .calendar_today,
                                          color:
                                          Colors.black54),
                                      const SizedBox(
                                          height: 4),
                                      Text(
                                        offer['desc']
                                            ?.toString() ??
                                            '',
                                        style: const TextStyle(
                                            fontSize: 13),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      const Icon(
                                          Icons
                                              .attach_money,
                                          color:
                                          Colors.black54),
                                      const SizedBox(
                                          height: 4),
                                      Text(
                                        offer['price']
                                            ?.toString() ??
                                            '',
                                        style: const TextStyle(
                                            fontSize: 13),
                                      ),
                                    ],
                                  ),
                                  Column(
                                    children: [
                                      const Icon(
                                          Icons.people,
                                          color:
                                          Colors.blue),
                                      const SizedBox(
                                          height: 4),
                                      Text(
                                        offer['members']
                                            ?.toString() ??
                                            '',
                                        style: const TextStyle(
                                            fontSize: 13),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment
                                    .spaceEvenly,
                                children: [
                                  CustomElevatedButton(
                                    text: 'Book Now',
                                    onPressed: () async {
                                      final Uri url =
                                      Uri.parse(
                                          'https://travco.com/en/');

                                      if (!await launchUrl(
                                        url,
                                        mode: LaunchMode
                                            .externalApplication,
                                      )) {
                                        ScaffoldMessenger.of(
                                            context)
                                            .showSnackBar(
                                          const SnackBar(
                                              content: Text(
                                                  'Could not launch the booking URL')),
                                        );
                                      }
                                    },
                                    backgroundColor:
                                    const Color(
                                        0xFFcdcc00),
                                    textColor: Colors.white,
                                    fullWidth: false,
                                  ),
                                  CustomElevatedButton(
                                    text: 'Ask',
                                    onPressed: () {
                                      Get.to(() =>
                                          ChatScreen());
                                    },
                                    backgroundColor:
                                    Colors.white,
                                    textColor: Colors.black,
                                    fullWidth: false,
                                  ),
                                  CustomElevatedButton(
                                    text: 'Profile',
                                    onPressed: () {
                                      if (company != null) {
                                        Get.to(() =>
                                            CompanyProfileScreen(
                                                company:
                                                company));
                                      }
                                    },
                                    backgroundColor:
                                    Colors.white,
                                    textColor: Colors.black,
                                    fullWidth: false,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}