import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../core/theme/app_theme.dart';
import '../../professional/models/professional.dart';
import '../../appointment/screens/appointment_form_screen.dart';
import '../../professional/screens/professional_profile_screen.dart';
import '../models/service_type.dart';
import '../../chat/screens/chat_screen.dart';
import 'dart:math';

class ServiceProvidersScreen extends StatefulWidget {
  final ServiceType service;

  const ServiceProvidersScreen({
    super.key,
    required this.service,
  });

  @override
  State<ServiceProvidersScreen> createState() => _ServiceProvidersScreenState();
}

class _ServiceProvidersScreenState extends State<ServiceProvidersScreen> {
  List<Map<String, dynamic>> _providers = [];
  bool _isLoading = true;
  String _searchQuery = '';
  double _maxDistance = 10.0;
  String _selectedLocation = '';
  List<String> _selectedServices = [];
  final TextEditingController _searchController = TextEditingController();

  List<Map<String, dynamic>> get _filteredProviders {
    return _providers.where((provider) {
      // Filtre par recherche
      if (_searchQuery.isNotEmpty) {
        final String name = provider['name'].toLowerCase();
        final String description = provider['description'].toLowerCase();
        final String searchLower = _searchQuery.toLowerCase();
        if (!name.contains(searchLower) && !description.contains(searchLower)) {
          return false;
        }
      }

      // Filtre par services
      if (_selectedServices.isNotEmpty) {
        final services = provider['professional'].services;
        if (!_selectedServices.any((service) => services.contains(service))) {
          return false;
        }
      }

      // Filtre par distance
      final distance = double.parse(provider['professional']
          .getDistanceFrom(48.8566, 2.3522) // Paris coordinates
          .toStringAsFixed(1));
      if (distance > _maxDistance) {
        return false;
      }

      return true;
    }).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    _loadProviders();
  }

  Future<void> _loadProviders() async {
    final professionals = Professional.getDummyProfessionals();
    
    _providers = professionals.map((professional) => {
      'name': professional.name,
      'image': professional.profileImage,
      'description': professional.title,
      'price': '${professional.servicesPrices.values.first.toStringAsFixed(0)}€',
      'professional': professional,
    }).toList();

    setState(() {
      _isLoading = false;
    });
  }

  void _showReviews(Map<String, dynamic> provider) {
    if (provider['professional'].reviewCount == 0) return;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16.r)),
      ),
      builder: (context) => Container(
        height: MediaQuery.of(context).size.height * 0.9,
        padding: EdgeInsets.only(
          top: 8.h,
          left: 16.w,
          right: 16.w,
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 8.h),
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2.r),
              ),
            ),
            Expanded(
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                        SizedBox(height: 16.h),
                        CircleAvatar(
                          radius: 40.r,
                          backgroundImage: NetworkImage(provider['image']),
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          provider['name'],
                          style: TextStyle(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          provider['description'],
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.grey[600],
                          ),
                        ),
                        SizedBox(height: 8.h),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.star, color: Colors.amber, size: 24.sp),
                            SizedBox(width: 4.w),
                            Text(
                              provider['professional'].rating.toStringAsFixed(1),
                              style: TextStyle(
                                fontSize: 20.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              ' (${provider['professional'].reviewCount} avis)',
                              style: TextStyle(
                                fontSize: 16.sp,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 24.h),
                        // TODO: Implémenter l'affichage des avis réels
                        Divider(height: 32.h),
                      ],
                    ),
                  ),
                  SliverPadding(
                    padding: EdgeInsets.only(bottom: 16.h),
                    sliver: SliverList(
                      delegate: SliverChildBuilderDelegate(
                        (context, index) => Container(),
                        childCount: 0,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildRatingStats(List<dynamic> reviews) {
    Map<String, double> averages = {
      'service': 0,
      'punctuality': 0,
      'price': 0,
      'cleanliness': 0,
    };

    for (var review in reviews) {
      var ratings = review['ratings'];
      averages.forEach((key, value) {
        averages[key] = value + ratings[key];
      });
    }

    averages.forEach((key, value) {
      averages[key] = value / reviews.length;
    });

    return Column(
      children: [
        _buildRatingBar('Service', averages['service']!),
        SizedBox(height: 8.h),
        _buildRatingBar('Ponctualité', averages['punctuality']!),
        SizedBox(height: 8.h),
        _buildRatingBar('Prix', averages['price']!),
        SizedBox(height: 8.h),
        _buildRatingBar('Propreté', averages['cleanliness']!),
      ],
    );
  }

  Widget _buildRatingBar(String label, double rating) {
    return Row(
      children: [
        SizedBox(
          width: 100.w,
          child: Text(
            label,
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey[600],
            ),
          ),
        ),
        Expanded(
          child: Stack(
            children: [
              Container(
                height: 8.h,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(4.r),
                ),
              ),
              FractionallySizedBox(
                widthFactor: rating / 5,
                child: Container(
                  height: 8.h,
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor,
                    borderRadius: BorderRadius.circular(4.r),
                  ),
                ),
              ),
            ],
          ),
        ),
        SizedBox(width: 8.w),
        Text(
          rating.toStringAsFixed(1),
          style: TextStyle(
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildReviewCard(Map<String, dynamic> review) {
    final ratings = review['ratings'] as Map<String, dynamic>;
    final averageRating = (ratings['service'] + ratings['punctuality'] + ratings['price'] + ratings['cleanliness']) / 4;

    return Card(
      margin: EdgeInsets.only(bottom: 16.h),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Padding(
        padding: EdgeInsets.all(16.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  review['userName'],
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  review['date'],
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            SizedBox(height: 8.h),
            Row(
              children: [
                ...List.generate(5, (index) {
                  return Icon(
                    index < averageRating ? Icons.star : Icons.star_border,
                    color: Colors.amber,
                    size: 20.sp,
                  );
                }),
                SizedBox(width: 8.w),
                Text(
                  averageRating.toStringAsFixed(1),
                  style: TextStyle(
                    fontSize: 14.sp,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
              ],
            ),
            SizedBox(height: 12.h),
            // Afficher les notes individuelles
            Wrap(
              spacing: 16.w,
              children: [
                _buildMiniRating('Service', ratings['service']),
                _buildMiniRating('Ponctualité', ratings['punctuality']),
                _buildMiniRating('Prix', ratings['price']),
                _buildMiniRating('Propreté', ratings['cleanliness']),
              ],
            ),
            if (review['comment'] != null && review['comment'].isNotEmpty) ...[
              SizedBox(height: 12.h),
              Text(
                review['comment'],
                style: TextStyle(
                  fontSize: 14.sp,
                  color: Colors.grey[800],
                ),
              ),
            ],
            if (review['photos'] != null && review['photos'].isNotEmpty) ...[
              SizedBox(height: 12.h),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: (review['photos'] as List).map<Widget>((photo) => Container(
                    width: 80.w,
                    height: 80.w,
                    margin: EdgeInsets.only(right: 8.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.r),
                      image: DecorationImage(
                        image: NetworkImage(photo),
                        fit: BoxFit.cover,
                      ),
                    ),
                  )).toList(),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildMiniRating(String label, double rating) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          label + ': ',
          style: TextStyle(
            fontSize: 12.sp,
            color: Colors.grey[600],
          ),
        ),
        Icon(
          Icons.star,
          color: Colors.amber,
          size: 14.sp,
        ),
        Text(
          rating.toStringAsFixed(1),
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }

  Future<void> _showAppointmentSheet(BuildContext context, Map<String, dynamic> provider) async {
    await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AppointmentFormScreen(
          professional: provider['professional'],
        ),
      ),
    );
  }

  void _showProviderProfile(Map<String, dynamic> provider) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProfessionalProfileScreen(
          professional: provider['professional'],
        ),
      ),
    );
  }

  Widget _buildSearchFilters() {
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
          // Barre de recherche
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Rechercher un prestataire...',
              prefixIcon: Icon(Icons.search, color: Colors.grey),
              filled: true,
              fillColor: Colors.grey[100],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide.none,
              ),
              contentPadding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
            ),
            onChanged: (value) {
              setState(() {
                _searchQuery = value;
              });
            },
          ),
          SizedBox(height: 16.h),
          // Filtres
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                // Filtre de localisation
                FilterChip(
                  label: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.location_on, size: 16.w),
                      SizedBox(width: 4.w),
                      Text(_selectedLocation.isEmpty ? 'Lieu' : _selectedLocation),
                    ],
                  ),
                  selected: _selectedLocation.isNotEmpty,
                  onSelected: (bool selected) {
                    _showLocationPicker();
                  },
                  backgroundColor: Colors.grey[100],
                  selectedColor: AppTheme.primaryColor.withOpacity(0.1),
                  checkmarkColor: AppTheme.primaryColor,
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                ),
                SizedBox(width: 8.w),
                // Filtre de distance
                FilterChip(
                  label: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(Icons.directions_car, size: 16.w),
                      SizedBox(width: 4.w),
                      Text('${_maxDistance.toInt()} km'),
                    ],
                  ),
                  selected: _maxDistance < 10.0,
                  onSelected: (bool selected) {
                    _showDistanceFilter();
                  },
                  backgroundColor: Colors.grey[100],
                  selectedColor: AppTheme.primaryColor.withOpacity(0.1),
                  checkmarkColor: AppTheme.primaryColor,
                  padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                ),
                SizedBox(width: 8.w),
                // Filtre de services
                ...widget.service.services.map((service) => Padding(
                  padding: EdgeInsets.only(right: 8.w),
                  child: FilterChip(
                    label: Text(service),
                    selected: _selectedServices.contains(service),
                    onSelected: (bool selected) {
                      setState(() {
                        if (selected) {
                          _selectedServices.add(service);
                        } else {
                          _selectedServices.remove(service);
                        }
                      });
                    },
                    backgroundColor: Colors.grey[100],
                    selectedColor: AppTheme.primaryColor.withOpacity(0.1),
                    checkmarkColor: AppTheme.primaryColor,
                    padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                  ),
                )).toList(),
              ],
            ),
          ),
        ],
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
            // TODO: Ajouter la liste des résultats
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
                foregroundColor: Colors.white,
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200.h,
            pinned: true,
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_new, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                widget.service.name,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 20.sp,
                  fontWeight: FontWeight.bold,
                  shadows: [
                    Shadow(
                      offset: Offset(0, 1),
                      blurRadius: 3.0,
                      color: Colors.black.withOpacity(0.5),
                    ),
                  ],
                ),
              ),
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    widget.service.image,
                    fit: BoxFit.cover,
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          Colors.transparent,
                          Colors.black.withOpacity(0.7),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: _buildSearchFilters(),
          ),
          _isLoading
              ? SliverFillRemaining(
                  child: Center(child: CircularProgressIndicator()),
                )
              : SliverPadding(
                  padding: EdgeInsets.all(16.w),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        final provider = _filteredProviders[index];
                        return GestureDetector(
                          onTap: () => _showProviderProfile(provider),
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 12.w, vertical: 16.h),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15.r),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withAlpha(20),
                                  blurRadius: 12,
                                  offset: const Offset(0, 6),
                                ),
                              ],
                            ),
                            child: Column(
                              children: [
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Container(
                                      width: 80.w,
                                      height: 80.w,
                                      margin: EdgeInsets.all(10.w),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10.r),
                                        image: DecorationImage(
                                          image: NetworkImage(provider['image']),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.all(10.w),
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Text(
                                                    provider['name'],
                                                    style: TextStyle(
                                                      fontSize: 15.sp,
                                                      fontWeight: FontWeight.bold,
                                                      color: AppTheme.textColor,
                                                    ),
                                                    maxLines: 1,
                                                    overflow: TextOverflow.ellipsis,
                                                  ),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
                                                  decoration: BoxDecoration(
                                                    color: Colors.grey[200],
                                                    borderRadius: BorderRadius.circular(12.r),
                                                  ),
                                                  child: Text(
                                                    '${(1 + Random().nextDouble() * 2).toStringAsFixed(1)} km',
                                                    style: TextStyle(
                                                      fontSize: 13.sp,
                                                      color: Colors.grey[600],
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 4.h),
                                            Text(
                                              provider['description'],
                                              style: TextStyle(
                                                fontSize: 13.sp,
                                                color: Colors.grey[600],
                                              ),
                                              maxLines: 2,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            SizedBox(height: 6.h),
                                            Row(
                                              children: [
                                                if (provider['professional'].reviewCount > 0) ...[
                                                  Row(
                                                    children: [
                                                      Icon(
                                                        Icons.star,
                                                        color: Colors.amber,
                                                        size: 14.w,
                                                      ),
                                                      SizedBox(width: 2.w),
                                                      Text(
                                                        provider['professional'].rating.toStringAsFixed(1),
                                                        style: TextStyle(
                                                          fontSize: 13.sp,
                                                          fontWeight: FontWeight.bold,
                                                          color: AppTheme.textColor,
                                                        ),
                                                      ),
                                                      Text(
                                                        ' (${provider['professional'].reviewCount} avis)',
                                                        style: TextStyle(
                                                          fontSize: 12.sp,
                                                          color: Colors.grey[600],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                if (provider['professional'].portfolioImages.isNotEmpty)
                                  Container(
                                    height: 100.h,
                                    margin: EdgeInsets.symmetric(vertical: 8.h),
                                    child: ListView.builder(
                                      padding: EdgeInsets.symmetric(horizontal: 10.w),
                                      scrollDirection: Axis.horizontal,
                                      itemCount: provider['professional'].portfolioImages.length,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) => Dialog(
                                                child: Container(
                                                  width: double.infinity,
                                                  height: 300.h,
                                                  decoration: BoxDecoration(
                                                    image: DecorationImage(
                                                      image: NetworkImage(provider['professional'].portfolioImages[index]),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                          child: Container(
                                            width: 100.w,
                                            margin: EdgeInsets.only(right: 8.w),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(8.r),
                                              image: DecorationImage(
                                                image: NetworkImage(provider['professional'].portfolioImages[index]),
                                                fit: BoxFit.cover,
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                Padding(
                                  padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 8.h),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: ElevatedButton.icon(
                                          onPressed: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => ChatScreen(
                                                  professional: provider['professional'],
                                                ),
                                              ),
                                            );
                                          },
                                          icon: Icon(Icons.chat_bubble_outline, size: 18.w),
                                          label: Text(
                                            'Message',
                                            style: TextStyle(
                                              fontSize: 13.sp,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: Colors.grey[100],
                                            foregroundColor: AppTheme.textColor,
                                            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(8.r),
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 10.w),
                                      Expanded(
                                        child: ElevatedButton(
                                          onPressed: () => _showAppointmentSheet(context, provider),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: AppTheme.primaryColor,
                                            foregroundColor: Colors.white,
                                            padding: EdgeInsets.symmetric(vertical: 12.h),
                                            shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(8.r),
                                            ),
                                          ),
                                          child: Text(
                                            'Prendre RDV',
                                            style: TextStyle(
                                              fontSize: 14.sp,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                      childCount: _filteredProviders.length,
                    ),
                  ),
                ),
        ],
      ),
    );
  }
}
