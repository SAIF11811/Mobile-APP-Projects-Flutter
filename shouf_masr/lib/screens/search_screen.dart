import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
import 'package:shouf_masr/screens/available_offers_screen.dart';
import '../widgets/traveler_bottom_nav.dart';
import '../widgets/components.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _homeController = TextEditingController();
  final TextEditingController _adultController = TextEditingController();
  final TextEditingController _childController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _destinationController = TextEditingController();
  final TextEditingController _budgetController = TextEditingController();

  bool _isSpecificDestination = false;
  bool _isSpecificBudget = false;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    final tomorrow = now.add(const Duration(days: 1));
    _dateController.text = "${_formatDate(now)} - ${_formatDate(tomorrow)}";
  }

  String _formatDate(DateTime date) {
    return "${date.day}/${date.month}/${date.year}";
  }

  Future<void> _pickDateRange() async {
    final DateTime now = DateTime.now();
    final picked = await showDateRangePicker(
      context: context,
      firstDate: now,
      lastDate: DateTime(now.year + 2),
      initialDateRange: DateTimeRange(
        start: now,
        end: now.add(const Duration(days: 1)),
      ),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: const ColorScheme.light(
              primary: Color(0xFFcdcc00),
              onPrimary: Colors.white,
              onSurface: Colors.black87,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        _dateController.text =
            "${_formatDate(picked.start)} - ${_formatDate(picked.end)}";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFcdcc00),
      body: Stack(
        children: [
          // Background image
          Opacity(
            opacity: 0.25,
            child: Image.asset(
              'assets/images/background.jpg',
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  // Logo
                  Center(
                    child: Image.asset(
                      'assets/images/minilogo.png',
                      width: 160,
                      height: 55,
                    ),
                  ),
                  const SizedBox(height: 20),

                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.only(bottom: 80),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Title
                          Center(
                            child: Text(
                              'Plan your Trip to Egypt',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                shadows: [
                                  Shadow(
                                    color: Colors.black.withOpacity(0.4),
                                    blurRadius: 4,
                                    offset: const Offset(1, 1),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 25),

                          // Your location
                          const _SectionTitle(
                            icon: Icons.home,
                            title: 'Your Location',
                          ),
                          const SizedBox(height: 8),

                          CustomTextField(
                            controller: _homeController,
                            label: "Your Location",
                            hintText: "Enter your location",
                            keyboardType: TextInputType.text,
                            prefixIcon: Icons.home,
                          ),
                          const SizedBox(height: 20),

                          // Destination
                          const _SectionTitle(
                            icon: Icons.location_on,
                            title: 'Destination in Egypt',
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                child: CustomElevatedButton(
                                  text: "Open",
                                  selected: !_isSpecificDestination,
                                  onPressed: () {
                                    setState(() {
                                      _isSpecificDestination = false;
                                      _destinationController.clear();
                                    });
                                  },
                                  icon: Icons.public,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: CustomElevatedButton(
                                  text: "Specific",
                                  selected: _isSpecificDestination,
                                  onPressed: () {
                                    setState(() {
                                      _isSpecificDestination = true;
                                    });
                                  },
                                  icon: Icons.map,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),

                          // Destination with recommendations
                          DestinationTextField(
                            controller: _destinationController,
                            enabled: _isSpecificDestination,
                          ),
                          const SizedBox(height: 20),

                          // Travelers
                          const _SectionTitle(
                            icon: Icons.people,
                            title: 'Number of Travelers',
                          ),
                          const SizedBox(height: 8),

                          Row(
                            children: [
                              Expanded(
                                child: CustomTextField(
                                  controller: _adultController,
                                  label: "Adults",
                                  hintText: "Adults",
                                  keyboardType: TextInputType.number,
                                  prefixIcon: Icons.person,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: CustomTextField(
                                  controller: _childController,
                                  label: "Children",
                                  hintText: "Children",
                                  keyboardType: TextInputType.number,
                                  prefixIcon: Icons.child_care,
                                  inputFormatters: [
                                    FilteringTextInputFormatter.digitsOnly,
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),

                          // Travel Dates
                          const _SectionTitle(
                            icon: Icons.date_range,
                            title: 'Travel Dates',
                          ),
                          const SizedBox(height: 8),
                          GestureDetector(
                            onTap: _pickDateRange,
                            child: AbsorbPointer(
                              child: CustomTextField(
                                controller: _dateController,
                                label: "Travel Dates",
                                hintText: "Select travel dates",
                                prefixIcon: Icons.calendar_today,
                                readOnly: true,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),

                          // Budget
                          const _SectionTitle(
                            icon: Icons.attach_money,
                            title: 'Budget Range',
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                child: CustomElevatedButton(
                                  text: "Open",
                                  selected: !_isSpecificBudget,
                                  onPressed: () {
                                    setState(() {
                                      _isSpecificBudget = false;
                                      _budgetController.clear();
                                    });
                                  },
                                  icon: Icons.currency_exchange,
                                ),
                              ),
                              const SizedBox(width: 10),
                              Expanded(
                                child: CustomElevatedButton(
                                  text: "Specific",
                                  selected: _isSpecificBudget,
                                  onPressed: () {
                                    setState(() {
                                      _isSpecificBudget = true;
                                    });
                                  },
                                  icon: Icons.savings,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          CustomTextField(
                            controller: _budgetController,
                            label: "Budget",
                            hintText: "Enter your budget",
                            keyboardType: TextInputType.number,
                            prefixIcon: Icons.attach_money,
                            enabled: _isSpecificBudget,
                          ),
                          const SizedBox(height: 20),

                          // Offers button
                          Center(
                            child: CustomElevatedButton(
                              text: "Show Travel Offers",
                              onPressed: () {
                                Get.to(
                                  () => AvailableOffersScreen(
                                    home: _homeController.text,
                                    destination: _isSpecificDestination
                                        ? _destinationController.text
                                        : "Open",
                                    adults: _adultController.text,
                                    children: _childController.text,
                                    dates: _dateController.text,
                                    budget: _isSpecificBudget
                                        ? _budgetController.text
                                        : "Open",
                                  ),
                                );
                              },
                              fullWidth: true,
                              backgroundColor: const Color(0xFFcdcc00),
                              textColor: Colors.white,
                              icon: Icons.search,
                              iconRight: true,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Bottom nav
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: const TravelerBottomNav(currentIndex: 2),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final IconData icon;
  final String title;
  const _SectionTitle({required this.icon, required this.title, Key? key})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.white),
        const SizedBox(width: 6),
        Text(
          title,
          style: const TextStyle(
            fontSize: 15,
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}

// Custom destination field with recommendations
class DestinationTextField extends StatefulWidget {
  final TextEditingController controller;
  final bool enabled;
  const DestinationTextField({
    required this.controller,
    required this.enabled,
    Key? key,
  }) : super(key: key);

  @override
  State<DestinationTextField> createState() => _DestinationTextFieldState();
}

class _DestinationTextFieldState extends State<DestinationTextField> {
  final FocusNode _focusNode = FocusNode();
  final List<String> allDestinations = [
    "Cairo",
    "Luxor",
    "Aswan",
    "Sharm El-Sheikh",
    "Hurghada",
    "Alexandria",
    "Giza",
    "Siwa Oasis",
    "Dahab",
    "Marsa Alam",
    "Fayoum Oasis",
    "Abu Simbel",
    "Port Said",
    "Taba",
    "Nuweiba",
    "Ismailia",
    "Ras Sudr",
    "Minya",
    "Beni Suef",
    "Sohag",
    "Qena",
    "Kom Ombo",
    "Damietta",
    "Mansoura",
    "Zagazig",
    "Suez",
    "Al Arish",
    "Sinai",
    "El Alamein",
    "Marsa Matruh",
    "Alamein",
    "Banha",
    "Qalyub",
    "Dakhla Oasis",
    "Kharga Oasis",
    "Fayoum",
    "Safaga",
    "Quseir",
    "Sinai",
    "Ismailia",
    "Ras Sudr",
    "Minya",
    "Beni Suef",
    "Sohag",
    "Marsa Matrouh",
    "Alamein",
    "Damietta",
    "Zagazig",
    "Suez",
    "Mansoura",
  ];
  List<String> filteredDestinations = [];

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus && widget.enabled) {
        setState(() {
          filteredDestinations = allDestinations;
        });
      } else {
        setState(() {
          filteredDestinations = [];
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 6),
          child: TextFormField(
            controller: widget.controller,
            focusNode: _focusNode,
            enabled: widget.enabled,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: widget.enabled ? Colors.black87 : Colors.grey.shade500,
            ),
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.location_on,
                color: widget.enabled
                    ? Colors.grey.shade700
                    : Colors.grey.shade400,
              ),
              hintText: "Enter specific destination",
              filled: true,
              fillColor: widget.enabled
                  ? Colors.grey.shade50
                  : Colors.grey.shade200,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 18,
                horizontal: 16,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide(
                  color: Theme.of(context).colorScheme.primary,
                  width: 2,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(14),
                borderSide: BorderSide(color: Colors.grey.shade300),
              ),
            ),
            onChanged: (value) {
              setState(() {
                filteredDestinations = allDestinations
                    .where((d) => d.toLowerCase().contains(value.toLowerCase()))
                    .toList();
              });
            },
          ),
        ),

        // Suggestions dropdown
        if (filteredDestinations.isNotEmpty)
          Container(
            margin: const EdgeInsets.only(top: 4),
            padding: const EdgeInsets.symmetric(vertical: 4),
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.grey.shade300),
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.shade300,
                  blurRadius: 5,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            constraints: const BoxConstraints(maxHeight: 200),
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: filteredDestinations.length,
              itemBuilder: (context, index) {
                final destination = filteredDestinations[index];
                return ListTile(
                  title: Text(destination),
                  onTap: () {
                    widget.controller.text = destination;
                    _focusNode.unfocus();
                  },
                );
              },
            ),
          ),
      ],
    );
  }
}
