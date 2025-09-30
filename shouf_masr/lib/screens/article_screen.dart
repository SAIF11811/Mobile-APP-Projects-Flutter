import 'package:flutter/material.dart';

class ArticleScreen extends StatelessWidget {
  final Map<String, String> article;

  const ArticleScreen({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey.shade100,
      appBar: AppBar(
        elevation: 3,
        title: Text(
          "Article Details",
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hero image
            Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(24),
                    bottomRight: Radius.circular(24),
                  ),
                  child: Image.asset(
                    article["image"]!,
                    height: 400,
                    width: double.infinity,
                    fit: BoxFit.cover,
                  )
                ),
                Positioned(
                  bottom: 16,
                  left: 16,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.6),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      article["author"] ?? "",
                      style: const TextStyle(
                          color: Colors.white, fontStyle: FontStyle.italic),
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),

            // Title
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                article["title"] ?? "",
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  height: 1.3,
                ),
              ),
            ),
            const SizedBox(height: 12),

            // Description
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                _getDescription(article["title"] ?? ""),
                style: TextStyle(
                  fontSize: 16,
                  height: 1.6,
                  color: Colors.grey.shade800,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Highlights Section
            _buildSectionTitle("Highlights"),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                children: _getHighlights(article["title"] ?? "")
                    .map((h) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("📍 ",
                          style: TextStyle(fontSize: 18)),
                      Expanded(
                        child: Text(
                          h,
                          style: const TextStyle(
                              fontSize: 16, height: 1.4),
                        ),
                      ),
                    ],
                  ),
                ))
                    .toList(),
              ),
            ),
            const SizedBox(height: 24),

            // Why Visit Section
            _buildSectionTitle("Why Visit?"),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                _getWhyVisit(article["title"] ?? ""),
                style: const TextStyle(fontSize: 16, height: 1.6),
              ),
            ),
            const SizedBox(height: 24),

            // Travel Tips
            _buildSectionTitle("Travel Tips"),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _getTips(article["title"] ?? "")
                    .map((t) => Padding(
                  padding: const EdgeInsets.symmetric(vertical: 6.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("✅ ",
                          style: TextStyle(fontSize: 16)),
                      Expanded(
                        child: Text(
                          t,
                          style: const TextStyle(fontSize: 15),
                        ),
                      ),
                    ],
                  ),
                ))
                    .toList(),
              ),
            ),
            const SizedBox(height: 24),

            // Best Time to Visit
            _buildSectionTitle("Best Time to Visit"),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                _getBestTime(article["title"] ?? ""),
                style: const TextStyle(fontSize: 16, height: 1.6),
              ),
            ),
            const SizedBox(height: 30),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 6),
      child: Text(
        title,
        style: const TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black87),
      ),
    );
  }

  // Content
  String _getDescription(String title) {
    switch (title) {
      case "Unveiling the Mysteries of the Pyramids":
        return "The Pyramids of Giza remain the most iconic symbol of Ancient Egypt. "
            "These monumental tombs were built for Pharaohs over 4,500 years ago "
            "and continue to amaze historians and travelers alike.";
      case "Walking Through the Temples of Luxor":
        return "Luxor is often called the world's largest open-air museum. "
            "Its temples and monuments reflect the glory of the New Kingdom of Egypt.";
      case "A Timeless Journey Sailing the Nile":
        return "The Nile River is the lifeblood of Egypt. Cruising its waters "
            "offers a glimpse into local life, fertile lands, and ancient temples.";
      case "Discovering Peace at Siwa Oasis":
        return "Hidden deep in the Western Desert, Siwa Oasis is a mystical retreat "
            "surrounded by palm groves, springs, and desert dunes.";
      case "Exploring the Underwater Wonders of the Red Sea":
        return "The Red Sea offers world-class diving and snorkeling experiences, "
            "with coral reefs teeming with marine life and crystal-clear waters.";
      case "Inside the Egyptian Museum of Cairo":
        return "Located in Tahrir Square, the Egyptian Museum houses more than "
            "120,000 artifacts, including treasures of King Tutankhamun.";
      default:
        return "Egypt is full of wonders, from deserts to temples and seas.";
    }
  }

  List<String> _getHighlights(String title) {
    switch (title) {
      case "Unveiling the Mysteries of the Pyramids":
        return ["Great Pyramid of Giza", "The Sphinx", "Pyramid of Khafre"];
      case "Walking Through the Temples of Luxor":
        return ["Karnak Temple", "Luxor Temple", "Avenue of Sphinxes"];
      case "A Timeless Journey Sailing the Nile":
        return ["Felucca rides", "Aswan High Dam", "Nile sunset views"];
      case "Discovering Peace at Siwa Oasis":
        return ["Cleopatra’s Spring", "Shali Fortress", "Great Sand Sea"];
      case "Exploring the Underwater Wonders of the Red Sea":
        return ["Coral reefs", "Sharm El-Sheikh diving", "Hurghada beaches"];
      case "Inside the Egyptian Museum of Cairo":
        return [
          "Tutankhamun’s treasures",
          "Royal Mummies Hall",
          "Ancient artifacts"
        ];
      default:
        return ["Explore history", "Visit breathtaking landmarks"];
    }
  }

  String _getWhyVisit(String title) {
    switch (title) {
      case "Unveiling the Mysteries of the Pyramids":
        return "To stand before one of the Seven Wonders of the Ancient World.";
      case "Walking Through the Temples of Luxor":
        return "Because it is the heart of Egypt’s ancient heritage.";
      case "A Timeless Journey Sailing the Nile":
        return "To see how the Nile shaped civilization for thousands of years.";
      case "Discovering Peace at Siwa Oasis":
        return "For its healing salt lakes and tranquil desert landscapes.";
      case "Exploring the Underwater Wonders of the Red Sea":
        return "To enjoy one of the most beautiful marine ecosystems in the world.";
      case "Inside the Egyptian Museum of Cairo":
        return "Because it’s home to the most complete collection of Ancient Egyptian artifacts.";
      default:
        return "Egypt offers a journey through time, nature, and culture like no other.";
    }
  }

  List<String> _getTips(String title) {
    switch (title) {
      case "Unveiling the Mysteries of the Pyramids":
        return ["Go early morning to avoid crowds.", "Hire a certified guide.", "Carry water and sunscreen."];
      case "Walking Through the Temples of Luxor":
        return ["Visit at sunrise or sunset for cooler weather.", "Don’t miss the evening light show.", "Wear comfortable shoes."];
      case "A Timeless Journey Sailing the Nile":
        return ["Choose a traditional felucca for authenticity.", "Pack light cotton clothes.", "Bring binoculars for birdwatching."];
      case "Discovering Peace at Siwa Oasis":
        return ["Respect local customs.", "Try Siwan dates and olives.", "Explore by bicycle or donkey cart."];
      case "Exploring the Underwater Wonders of the Red Sea":
        return ["Bring snorkeling gear if not diving.", "Book certified dive operators.", "Best diving visibility in summer."];
      case "Inside the Egyptian Museum of Cairo":
        return ["Get a guided tour for better understanding.", "Avoid weekends for smaller crowds.", "Check out the Royal Mummies Hall."];
      default:
        return ["Plan ahead and enjoy responsibly."];
    }
  }

  String _getBestTime(String title) {
    switch (title) {
      case "Unveiling the Mysteries of the Pyramids":
      case "Walking Through the Temples of Luxor":
      case "Inside the Egyptian Museum of Cairo":
        return "October to April, when the weather is cooler.";
      case "A Timeless Journey Sailing the Nile":
        return "October to March, ideal for cruises.";
      case "Discovering Peace at Siwa Oasis":
        return "Autumn and spring, avoiding summer heat.";
      case "Exploring the Underwater Wonders of the Red Sea":
        return "Year-round, but April–October offers best visibility.";
      default:
        return "Egypt is a year-round destination, but cooler months are more comfortable.";
    }
  }
}
