import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shouf_masr/screens/chat_screen.dart';
import 'package:shouf_masr/screens/offer_details_screen.dart';
import '../widgets/traveler_bottom_nav.dart';
import '../widgets/components.dart';
import 'company_profile.dart';

class OffersScreen extends StatefulWidget {
  const OffersScreen({super.key});

  @override
  State<OffersScreen> createState() => _OffersScreenState();
}

class _OffersScreenState extends State<OffersScreen>
    with SingleTickerProviderStateMixin {
  int _tappedIndex = -1;

  // company data
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Image.asset(
            'assets/images/background.jpg',
            fit: BoxFit.cover,
            width: double.infinity,
            height: double.infinity,
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20),
              child: Column(
                children: [
                  const Center(
                    child: Text(
                      'Offers',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                        shadows: [
                          Shadow(
                            color: Colors.black45,
                            blurRadius: 4,
                            offset: Offset(1, 1),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Expanded(
                    child: ListView.builder(
                      padding: const EdgeInsets.only(bottom: 80),
                      itemCount: articles.length,
                      itemBuilder: (context, i) {
                        final article = articles[i];
                        return GestureDetector(
                          onTapDown: (_) => setState(() => _tappedIndex = i),
                          onTapUp: (_) => setState(() => _tappedIndex = -1),
                          onTapCancel: () => setState(() => _tappedIndex = -1),
                          child: AnimatedScale(
                            scale: _tappedIndex == i ? 0.97 : 1.0,
                            duration: const Duration(milliseconds: 150),
                            child: Container(
                              margin: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                color: Colors.white.withOpacity(0.9),
                                borderRadius: BorderRadius.circular(16),
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ClipRRect(
                                    borderRadius: const BorderRadius.vertical(top: Radius.circular(16)),
                                    child: Image.asset(
                                      article['image'],
                                      width: double.infinity,
                                      height: 200,
                                      fit: BoxFit.cover,
                                    )
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(14.0),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.center,
                                      children: [
                                        Text(article['title'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                        const SizedBox(height: 6),
                                        Text(article['author'], style: TextStyle(color: Colors.grey[700])),
                                        const SizedBox(height: 12),

                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          mainAxisSize: MainAxisSize.max,
                                          children: [
                                            // Days
                                            Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                const Icon(Icons.calendar_today, color: Colors.black54),
                                                const SizedBox(height: 4),
                                                Text(article['days'] ?? '-', style: const TextStyle(fontSize: 13)),
                                              ],
                                            ),
                                            // Price
                                            Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                const Icon(Icons.attach_money, color: Colors.black54),
                                                const SizedBox(height: 4),
                                                Text(article['price'] ?? '-', style: const TextStyle(fontSize: 13)),
                                              ],
                                            ),
                                            // Rating
                                            Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                const Icon(Icons.star, color: Colors.amber),
                                                const SizedBox(height: 4),
                                                Text((article['rating'] ?? '-').toString(), style: const TextStyle(fontSize: 13)),
                                              ],
                                            ),
                                          ],
                                        ),

                                        const SizedBox(height: 12),
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                          children: [
                                            CustomElevatedButton(
                                              text: 'Book Now',
                                              onPressed: () {
                                                Get.to(() => OfferDetailsScreen(article: article));
                                              },
                                              backgroundColor: const Color(0xFFcdcc00),
                                              textColor: Colors.white,
                                              fullWidth: false,
                                            ),
                                            CustomElevatedButton(
                                              text: 'Ask',
                                              onPressed: () {Get.to(() => ChatScreen());},
                                              backgroundColor: Colors.white,
                                              textColor: Colors.black,
                                              fullWidth: false,
                                            ),
                                            CustomElevatedButton(
                                              text: 'Profile',
                                              onPressed: () {
                                                final company = article['company'];
                                                if (company != null) {
                                                  Get.to(() => CompanyProfileScreen(company: company));
                                                }
                                              },
                                              backgroundColor: Colors.white,
                                              textColor: Colors.black,
                                              fullWidth: false,
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
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
          ),
          // Bottom Nav
          const Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: TravelerBottomNav(currentIndex: 1),
          ),
        ],
      ),
    );
  }
}
