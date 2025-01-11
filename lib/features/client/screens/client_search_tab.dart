import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../core/theme/app_theme.dart';
import '../../professional/models/professional.dart';
import '../models/service_type.dart';
import 'service_providers_screen.dart';

class ClientSearchTab extends StatefulWidget {
  const ClientSearchTab({super.key});

  @override
  State<ClientSearchTab> createState() => _ClientSearchTabState();
}

class _ClientSearchTabState extends State<ClientSearchTab> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedLocation = '';
  double _maxDistance = 10.0;
  RangeValues _priceRange = const RangeValues(0, 200);
  double _minRating = 0.0;
  List<String> _selectedServices = [];
  List<Professional> _filteredProfessionals = [];
  bool _isLoading = false;
  ServiceType? _selectedCategory;

  @override
  void initState() {
    super.initState();
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    setState(() {
      _isLoading = true;
    });

    // Simuler un chargement des données
    await Future.delayed(const Duration(milliseconds: 500));
    _filteredProfessionals = Professional.getDummyProfessionals();

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    // Implémenter la logique de recherche
  }

  Widget _buildSearchHeader() {
    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Rechercher un service ou un prestataire...',
              prefixIcon: Icon(Icons.search, color: Colors.grey),
              filled: true,
              fillColor: Colors.grey[100],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide.none,
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            ),
            onChanged: _onSearchChanged,
          ),
          SizedBox(height: 16.h),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                _buildFilterChip(
                  icon: Icons.location_on,
                  label: _selectedLocation.isEmpty ? 'Lieu' : _selectedLocation,
                  onTap: _showLocationPicker,
                  isSelected: _selectedLocation.isNotEmpty,
                ),
                SizedBox(width: 8.w),
                _buildFilterChip(
                  icon: Icons.directions_car,
                  label: '${_maxDistance.toInt()} km',
                  onTap: _showDistanceFilter,
                  isSelected: _maxDistance < 50,
                ),
                SizedBox(width: 8.w),
                _buildFilterChip(
                  icon: Icons.euro,
                  label: 'Prix',
                  onTap: _showPriceFilter,
                  isSelected: _priceRange.start > 0 || _priceRange.end < 200,
                ),
                SizedBox(width: 8.w),
                _buildFilterChip(
                  icon: Icons.star,
                  label: _minRating > 0 ? '${_minRating.toStringAsFixed(1)}★' : 'Note',
                  onTap: _showRatingFilter,
                  isSelected: _minRating > 0,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFilterChip({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    required bool isSelected,
  }) {
    return FilterChip(
      label: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16.w),
          SizedBox(width: 4.w),
          Text(label),
        ],
      ),
      selected: isSelected,
      onSelected: (_) => onTap(),
      backgroundColor: Colors.grey[100],
      selectedColor: AppTheme.primaryColor.withOpacity(0.1),
      checkmarkColor: AppTheme.primaryColor,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
    );
  }

  Widget _buildCategorySelector() {
    return Container(
      height: 120.h,
      padding: EdgeInsets.symmetric(vertical: 16.h),
      child: ListView(
        scrollDirection: Axis.horizontal,
        padding: EdgeInsets.symmetric(horizontal: 16.w),
        children: ServiceType.all.map((category) {
          final isSelected = _selectedCategory == category;
          return GestureDetector(
            onTap: () {
              setState(() {
                _selectedCategory = isSelected ? null : category;
              });
            },
            child: Container(
              width: 100.w,
              margin: EdgeInsets.only(right: 16.w),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.r),
                image: DecorationImage(
                  image: NetworkImage(category.image),
                  fit: BoxFit.cover,
                  colorFilter: ColorFilter.mode(
                    Colors.black.withOpacity(isSelected ? 0.3 : 0.5),
                    BlendMode.darken,
                  ),
                ),
                boxShadow: isSelected
                    ? [
                        BoxShadow(
                          color: category.colors.first.withOpacity(0.3),
                          blurRadius: 8,
                          offset: const Offset(0, 4),
                        ),
                      ]
                    : null,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    category.name,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 16.sp,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }

  void _showLocationPicker() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.7,
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            Text(
              'Choisir un lieu',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.h),
            TextField(
              decoration: InputDecoration(
                hintText: 'Rechercher une adresse...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              onChanged: (value) {
                // TODO: Implémenter la recherche d'adresse
              },
            ),
            SizedBox(height: 16.h),
            ElevatedButton.icon(
              onPressed: () {
                // TODO: Implémenter la géolocalisation
                setState(() {
                  _selectedLocation = 'Ma position';
                });
                Navigator.pop(context);
              },
              icon: Icon(Icons.my_location),
              label: Text('Utiliser ma position actuelle'),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryColor,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 12.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showDistanceFilter() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      builder: (context) => Container(
        height: 200.h,
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            Text(
              'Distance maximale',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.h),
            Slider(
              value: _maxDistance,
              min: 1.0,
              max: 50.0,
              divisions: 49,
              label: '${_maxDistance.toInt()} km',
              onChanged: (value) {
                setState(() {
                  _maxDistance = value;
                });
              },
            ),
            SizedBox(height: 16.h),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryColor,
                minimumSize: Size(double.infinity, 48.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Text(
                'Appliquer',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showPriceFilter() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      builder: (context) => Container(
        height: 200.h,
        padding: EdgeInsets.all(16.w),
        child: Column(
          children: [
            Text(
              'Fourchette de prix',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.h),
            RangeSlider(
              values: _priceRange,
              min: 0,
              max: 200,
              divisions: 20,
              labels: RangeLabels(
                '${_priceRange.start.toInt()}€',
                '${_priceRange.end.toInt()}€',
              ),
              onChanged: (values) {
                setState(() {
                  _priceRange = values;
                });
              },
            ),
            SizedBox(height: 16.h),
            ElevatedButton(
              onPressed: () => Navigator.pop(context),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.primaryColor,
                minimumSize: Size(double.infinity, 48.h),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: Text(
                'Appliquer',
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showRatingFilter() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      builder: (context) => Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Note minimale',
              style: TextStyle(
                fontSize: 18.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 16.h),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(5, (index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _minRating = index + 1.0;
                    });
                    Navigator.pop(context);
                  },
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 4.w),
                    child: Icon(
                      index < _minRating ? Icons.star : Icons.star_border,
                      color: Colors.amber,
                      size: 32.w,
                    ),
                  ),
                );
              }),
            ),
            SizedBox(height: 16.h),
            Text(
              '${_minRating.toStringAsFixed(1)} étoiles minimum',
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }

  Widget _buildResults() {
    if (_isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    if (_filteredProfessionals.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.search_off,
              size: 64.w,
              color: Colors.grey,
            ),
            SizedBox(height: 16.h),
            Text(
              'Aucun résultat trouvé',
              style: TextStyle(
                fontSize: 18.sp,
                color: Colors.grey[600],
              ),
            ),
            SizedBox(height: 8.h),
            Text(
              'Essayez de modifier vos filtres',
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      itemCount: _filteredProfessionals.length,
      itemBuilder: (context, index) {
        final professional = _filteredProfessionals[index];
        return Card(
          margin: EdgeInsets.only(bottom: 16.h),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.r),
          ),
          elevation: 2,
          child: InkWell(
            onTap: () {
              // TODO: Naviguer vers le profil du professionnel
            },
            borderRadius: BorderRadius.circular(12.r),
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30.r,
                    backgroundImage: NetworkImage(professional.profileImage),
                  ),
                  SizedBox(width: 16.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          professional.name,
                          style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          professional.title,
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: Colors.grey[600],
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Row(
                          children: [
                            if (professional.reviewCount > 0) ...[
                              Icon(
                                Icons.star,
                                color: Colors.amber,
                                size: 16.w,
                              ),
                              SizedBox(width: 4.w),
                              Text(
                                professional.rating.toStringAsFixed(1),
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              Text(
                                ' (${professional.reviewCount})',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.grey,
                                ),
                              ),
                              SizedBox(width: 8.w),
                            ],
                            Icon(
                              Icons.location_on,
                              color: Colors.grey,
                              size: 16.w,
                            ),
                            SizedBox(width: 4.w),
                            Text(
                              '${professional.getDistanceFrom(48.8566, 2.3522).toStringAsFixed(1)} km',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: Colors.grey,
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
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SafeArea(
            bottom: false,
            child: _buildSearchHeader(),
          ),
          _buildCategorySelector(),
          Expanded(
            child: _buildResults(),
          ),
        ],
      ),
    );
  }
}
