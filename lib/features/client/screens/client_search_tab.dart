import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import '../../../core/theme/app_theme.dart';
import '../../professional/models/professional.dart';
import 'service_providers_screen.dart';

class ClientSearchTab extends StatefulWidget {
  const ClientSearchTab({super.key});

  @override
  State<ClientSearchTab> createState() => _ClientSearchTabState();
}

class _ClientSearchTabState extends State<ClientSearchTab> {
  final TextEditingController _searchController = TextEditingController();
  final List<Professional> _searchResults = Professional.getDummyProfessionals();
  String _searchQuery = '';

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query.toLowerCase();
    });
  }

  @override
  Widget build(BuildContext context) {
    final filteredResults = _searchQuery.isEmpty
        ? _searchResults
        : _searchResults.where((professional) {
            return professional.name.toLowerCase().contains(_searchQuery) ||
                professional.title.toLowerCase().contains(_searchQuery) ||
                professional.services.any((service) =>
                    service.toLowerCase().contains(_searchQuery));
          }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Rechercher',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.w),
            child: TextField(
              controller: _searchController,
              onChanged: _onSearchChanged,
              decoration: InputDecoration(
                hintText: 'Rechercher un service ou un professionnel',
                prefixIcon: Icon(Icons.search, color: Colors.grey),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12.r),
                  borderSide: BorderSide(color: AppTheme.primaryColor),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              itemCount: filteredResults.length,
              itemBuilder: (context, index) {
                final professional = filteredResults[index];
                return Card(
                  margin: EdgeInsets.only(bottom: 16.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: ListTile(
                    contentPadding: EdgeInsets.all(16.w),
                    leading: CircleAvatar(
                      backgroundImage: NetworkImage(professional.profileImage),
                      radius: 24.r,
                    ),
                    title: Text(
                      professional.name,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.sp,
                      ),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 4.h),
                        Text(
                          professional.title,
                          style: TextStyle(
                            color: Colors.grey[600],
                            fontSize: 14.sp,
                          ),
                        ),
                        SizedBox(height: 4.h),
                        Text(
                          professional.services.join(', '),
                          style: TextStyle(
                            color: AppTheme.primaryColor,
                            fontSize: 12.sp,
                          ),
                        ),
                      ],
                    ),
                    trailing: Icon(
                      Icons.chevron_right,
                      color: Colors.grey[400],
                    ),
                    onTap: () {
                      // Navigate to professional profile
                    },
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
