import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../widgets/bottom_nav.dart';
import '../widgets/components.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
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
      initialDateRange: DateTimeRange(start: now, end: now.add(const Duration(days: 1))),
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
        _dateController.text = "${_formatDate(picked.start)} - ${_formatDate(picked.end)}";
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
            child: Image.network(
              'https://cdn-ai.onspace.ai/onspace/figma/ZC9x4trmvyQe3EwsqDQBdR/5320a810acd3f7b9e7bf278b1f459970e6fdb712.jpg',
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
                    child: Image.network(
                      'https://cdn-ai.onspace.ai/onspace/figma/ZC9x4trmvyQe3EwsqDQBdR/248cd0554d0da56d81aece5474bbcdfb9f21ec3a.png',
                      width: 160,
                      height: 55,
                    ),
                  ),
                  const SizedBox(height: 20),

                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.only(bottom: 80), // space for nav bar
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

                          // Destination
                          const _SectionTitle(icon: Icons.location_on, title: 'Destination in Egypt'),
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
                          CustomTextField(
                            controller: _destinationController,
                            label: "Destination",
                            hintText: "Enter specific destination",
                            keyboardType: TextInputType.name,
                            prefixIcon: Icons.location_on,
                            enabled: _isSpecificDestination,
                          ),
                          const SizedBox(height: 20),

                          // Travelers
                          const _SectionTitle(icon: Icons.people, title: 'Number of Travelers'),
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
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 20),

                          // Travel Dates
                          const _SectionTitle(icon: Icons.date_range, title: 'Travel Dates'),
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
                          const _SectionTitle(icon: Icons.attach_money, title: 'Budget Range'),
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

                          // offers button
                          Center(
                            child: CustomElevatedButton(
                              text: "Show Travel Offers",
                              onPressed: () => Get.toNamed('/offers'),
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

          // bottom nav
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: const BottomNav(currentIndex: 2),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final IconData icon;
  final String title;
  const _SectionTitle({required this.icon, required this.title, Key? key}) : super(key: key);

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
