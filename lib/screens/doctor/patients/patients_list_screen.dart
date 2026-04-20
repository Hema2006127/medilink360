import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:go_router/go_router.dart';
import '../../../theme/app_colors.dart';
import '../../../theme/app_text_styles.dart';

class PatientsListScreen extends StatefulWidget {
  const PatientsListScreen({super.key});

  @override
  State<PatientsListScreen> createState() => _PatientsListScreenState();
}

class _PatientsListScreenState extends State<PatientsListScreen> with SingleTickerProviderStateMixin {
  int _selectedFilter = 0;
  String _searchQuery = '';
  final List<String> _filters = ['All', 'Recent', 'Critical', 'New'];

  final List<Map<String, dynamic>> _patients = [
    {
      'id': '101',
      'name': 'Ahmed Kamal',
      'age': '45 yrs',
      'gender': 'Male',
      'lastVisit': 'Oct 12, 2023',
      'status': 'Stable',
      'statusColor': AppColors.green,
      'image': 'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?auto=format&fit=crop&w=150&q=80',
    },
    {
      'id': '102',
      'name': 'Sara Ahmed',
      'age': '32 yrs',
      'gender': 'Female',
      'lastVisit': 'Oct 10, 2023',
      'status': 'Follow-up',
      'statusColor': AppColors.blue,
      'image': 'https://images.unsplash.com/photo-1494790108377-be9c29b29330?auto=format&fit=crop&w=150&q=80',
    },
    {
      'id': '103',
      'name': 'Tarek Fouad',
      'age': '58 yrs',
      'gender': 'Male',
      'lastVisit': 'Oct 05, 2023',
      'status': 'Critical',
      'statusColor': AppColors.red,
      'image': 'https://images.unsplash.com/photo-1599566150163-29194dcaad36?auto=format&fit=crop&w=150&q=80',
    },
    {
      'id': '104',
      'name': 'Mona Zaki',
      'age': '29 yrs',
      'gender': 'Female',
      'lastVisit': 'New Patient',
      'status': 'New',
      'statusColor': AppColors.purple,
      'image': 'https://images.unsplash.com/photo-1438761681033-6461ffad8d80?auto=format&fit=crop&w=150&q=80',
    },
    {
      'id': '105',
      'name': 'Youssef Ali',
      'age': '12 yrs',
      'gender': 'Male',
      'lastVisit': 'Sep 28, 2023',
      'status': 'Stable',
      'statusColor': AppColors.green,
      'image': 'https://images.unsplash.com/photo-1519085360753-af0119f7cbe7?auto=format&fit=crop&w=150&q=80',
    },
  ];

  late final AnimationController _animCtrl;

  @override
  void initState() {
    super.initState();
    _animCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    )..forward();
  }

  List<Map<String, dynamic>> get _filteredPatients {
    List<Map<String, dynamic>> filtered = _patients;

    String filterName = _filters[_selectedFilter];
    if (filterName == 'Critical') {
      filtered = filtered.where((p) => p['status'] == 'Critical').toList();
    } else if (filterName == 'New') {
      filtered = filtered.where((p) => p['status'] == 'New').toList();
    } else if (filterName == 'Recent') {
      filtered = filtered.where((p) => p['status'] == 'Follow-up' || p['status'] == 'Stable').toList();
    }

    if (_searchQuery.isNotEmpty) {
      filtered = filtered.where((p) =>
          p['name'].toString().toLowerCase().contains(_searchQuery.toLowerCase()) ||
          p['id'].toString().toLowerCase().contains(_searchQuery.toLowerCase())).toList();
    }

    return filtered;
  }

  @override
  void dispose() {
    _animCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ));

    return Scaffold(
      backgroundColor: AppColors.bg,
      appBar: _buildAppBar(),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 16),
                _buildSearchBar(),
                const SizedBox(height: 20),
                _buildFilters(),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    '${_filteredPatients.length} Patients',
                    style: AppTextStyles.h3.copyWith(fontSize: 16, color: AppColors.text2),
                  ),
                ),
                const SizedBox(height: 16),
                _buildPatientsList(),
                const SizedBox(height: 120), // Extra space for floating bottom nav
              ],
            ),
          ),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: AppColors.bg,
      elevation: 0,
      centerTitle: true,
      title: Text(
        'My Patients',
        style: AppTextStyles.h2.copyWith(fontSize: 20),
      ),
      actions: [
        IconButton(
          icon: const Icon(Icons.person_add_alt_1_rounded, color: AppColors.primary),
          onPressed: () {},
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Container(
        height: 56,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: AppColors.text.withValues(alpha: 0.03),
              blurRadius: 15,
              offset: const Offset(0, 8),
            )
          ],
          border: Border.all(color: AppColors.border),
        ),
        child: TextField(
          onChanged: (value) {
            setState(() {
              _searchQuery = value;
            });
            _animCtrl.forward(from: 0);
          },
          decoration: InputDecoration(
            hintText: 'Search patients by name or ID...',
            hintStyle: AppTextStyles.bodyMedium.copyWith(color: AppColors.text3),
            prefixIcon: const Icon(Icons.search_rounded, color: AppColors.text3),
            border: InputBorder.none,
            contentPadding: const EdgeInsets.symmetric(vertical: 18),
          ),
        ),
      ),
    );
  }

  Widget _buildFilters() {
    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _filters.length,
        itemBuilder: (context, index) {
          final isSelected = _selectedFilter == index;
          return GestureDetector(
            onTap: () {
              setState(() => _selectedFilter = index);
              _animCtrl.forward(from: 0);
            },
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutCubic,
              margin: const EdgeInsets.symmetric(horizontal: 4),
              padding: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: isSelected ? AppColors.primary : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected ? AppColors.primary : AppColors.border,
                ),
              ),
              child: Center(
                child: Text(
                  _filters[index],
                  style: AppTextStyles.bodyBold.copyWith(
                    color: isSelected ? Colors.white : AppColors.text2,
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildPatientsList() {
    final displayedPatients = _filteredPatients;
    
    if (displayedPatients.isEmpty) {
      return Padding(
        padding: const EdgeInsets.only(top: 40),
        child: Center(
          child: Text(
            'No patients found',
            style: AppTextStyles.bodyMedium.copyWith(color: AppColors.text3),
          ),
        ),
      );
    }

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: List.generate(displayedPatients.length, (index) {
          final patient = displayedPatients[index];
          
          return AnimatedBuilder(
            animation: _animCtrl,
            builder: (context, child) {
              final double start = (index * 0.1).clamp(0.0, 1.0);
              final double end = (start + 0.4).clamp(0.0, 1.0);
              final double progress = ((_animCtrl.value - start) / (end - start)).clamp(0.0, 1.0);
              final double curve = Curves.easeOutCubic.transform(progress);

              return Opacity(
                opacity: curve,
                child: Transform.translate(
                  offset: Offset(0, 20 * (1 - curve)),
                  child: child,
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(20),
                boxShadow: [
                  BoxShadow(
                    color: AppColors.text.withValues(alpha: 0.03),
                    blurRadius: 15,
                    offset: const Offset(0, 8),
                  )
                ],
                border: Border.all(color: AppColors.border),
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(20),
                  onTap: () {
                    // Navigate to the Patient Profile passing the ID
                    context.push('/doctor/patients/${patient['id']}');
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                              image: NetworkImage(patient['image']),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    patient['name'],
                                    style: AppTextStyles.bodyBold.copyWith(fontSize: 16),
                                  ),
                                  Icon(Icons.chevron_right_rounded, color: AppColors.text3),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Row(
                                children: [
                                  Text(
                                    'ID: ${patient['id']}',
                                    style: AppTextStyles.caption.copyWith(color: AppColors.text3),
                                  ),
                                  const SizedBox(width: 8),
                                  Container(
                                    width: 4,
                                    height: 4,
                                    decoration: const BoxDecoration(
                                      color: AppColors.text3,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    '${patient['gender']} • ${patient['age']}',
                                    style: AppTextStyles.caption.copyWith(color: AppColors.text3),
                                  ),
                                ],
                              ),
                              const SizedBox(height: 12),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Icon(Icons.history_rounded, size: 14, color: AppColors.text3),
                                      const SizedBox(width: 4),
                                      Text(
                                        patient['lastVisit'],
                                        style: AppTextStyles.caption.copyWith(color: AppColors.text2),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                    decoration: BoxDecoration(
                                      color: patient['statusColor'].withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Text(
                                      patient['status'],
                                      style: AppTextStyles.caption.copyWith(
                                        color: patient['statusColor'],
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
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
              ),
            ),
          );
        }),
      ),
    );
  }
}
