import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:image_picker/image_picker.dart';
import '../../../core/theme/app_theme.dart';
import 'pro_edit_service.dart';
import 'pro_add_service.dart';

class ProServicesTab extends StatefulWidget {
  const ProServicesTab({super.key});

  @override
  State<ProServicesTab> createState() => _ProServicesTabState();
}

class _ProServicesTabState extends State<ProServicesTab> {
  final List<Map<String, dynamic>> services = [
    {
      'id': 1,
      'name': 'Coupe + Barbe',
      'price': 35,
      'duration': 45,
      'description': 'Coupe de cheveux et taille de barbe avec finitions soignées',
      'category': 'Coiffure',
      'isActive': true,
      'images': [
        'https://images.unsplash.com/photo-1621605815971-fbc98d665033',
        'https://images.unsplash.com/photo-1622296089720-56fe4febf16f',
      ],
    },
    {
      'id': 2,
      'name': 'Brushing',
      'price': 25,
      'duration': 30,
      'description': 'Brushing et coiffage selon vos préférences',
      'category': 'Coiffure',
      'isActive': true,
      'images': [
        'https://images.unsplash.com/photo-1560869713-da86a9ec4623',
      ],
    },
    {
      'id': 3,
      'name': 'Coloration',
      'price': 55,
      'duration': 90,
      'description': 'Coloration complète avec soin protecteur',
      'category': 'Coiffure',
      'isActive': true,
      'images': [],
    },
    {
      'id': 4,
      'name': 'Manucure',
      'price': 30,
      'duration': 45,
      'description': 'Soin des ongles et pose de vernis',
      'category': 'Manucure',
      'isActive': false,
      'images': [],
    },
    {
      'id': 5,
      'name': 'Massage relaxant',
      'price': 65,
      'duration': 60,
      'description': 'Massage complet du corps aux huiles essentielles',
      'category': 'Massage',
      'isActive': true,
      'images': [],
    },
  ];

  final ImagePicker _picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Mes Services',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppTheme.primaryColor,
                AppTheme.primaryColor.withOpacity(0.8),
              ],
            ),
          ),
        ),
      ),
      body: ListView.builder(
        padding: EdgeInsets.all(16.w),
        itemCount: services.length,
        itemBuilder: (context, index) {
          return _buildServiceCard(services[index]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ProAddService(),
            ),
          );

          if (result != null) {
            setState(() {
              services.add(result);
            });
          }
        },
        child: Container(
          width: 60.w,
          height: 60.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppTheme.primaryColor,
                AppTheme.primaryColor.withOpacity(0.8),
              ],
            ),
          ),
          child: const Icon(
            Icons.add,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  void _editService(Map<String, dynamic> service) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProEditService(service: service),
      ),
    );

    if (result != null) {
      setState(() {
        final index = services.indexWhere((s) => s['id'] == result['id']);
        if (index != -1) {
          services[index] = result;
        }
      });
    }
  }

  Widget _buildServiceCard(Map<String, dynamic> service) {
    return Container(
      margin: EdgeInsets.only(bottom: 16.h),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [Colors.white, Colors.grey.shade50],
        ),
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 5,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          if (service['images'] != null && (service['images'] as List).isNotEmpty)
            Stack(
              children: [
                SizedBox(
                  height: 200.h,
                  child: Swiper(
                    itemBuilder: (BuildContext context, int index) {
                      final imagePath = service['images'][index];
                      return Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(12.r),
                          ),
                          image: DecorationImage(
                            image: _getImageProvider(imagePath),
                            fit: BoxFit.cover,
                          ),
                        ),
                      );
                    },
                    itemCount: (service['images'] as List).length,
                    pagination: SwiperPagination(
                      builder: DotSwiperPaginationBuilder(
                        activeColor: AppTheme.primaryColor,
                        color: Colors.white.withOpacity(0.8),
                      ),
                    ),
                    control: SwiperControl(
                      color: AppTheme.primaryColor,
                    ),
                  ),
                ),
                Positioned(
                  right: 8.w,
                  bottom: 8.h,
                  child: FloatingActionButton.small(
                    onPressed: () => _addPhotos(service),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            AppTheme.primaryColor,
                            AppTheme.primaryColor.withOpacity(0.8),
                          ],
                        ),
                      ),
                      child: Icon(
                        Icons.add_a_photo,
                        color: Colors.white,
                        size: 20.sp,
                      ),
                    ),
                  ),
                ),
              ],
            )
          else
            Stack(
              children: [
                Container(
                  height: 200.h,
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(12.r),
                    ),
                  ),
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.image,
                          size: 48.sp,
                          color: AppTheme.primaryColor.withOpacity(0.5),
                        ),
                        SizedBox(height: 8.h),
                        Text(
                          'Aucune image',
                          style: TextStyle(
                            color: AppTheme.primaryColor.withOpacity(0.5),
                            fontSize: 14.sp,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  right: 8.w,
                  bottom: 8.h,
                  child: FloatingActionButton.small(
                    onPressed: () => _addPhotos(service),
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [
                            AppTheme.primaryColor,
                            AppTheme.primaryColor.withOpacity(0.8),
                          ],
                        ),
                      ),
                      child: Icon(
                        Icons.add_a_photo,
                        color: Colors.white,
                        size: 20.sp,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ListTile(
            contentPadding: EdgeInsets.all(16.w),
            leading: Container(
              width: 48.w,
              height: 48.w,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppTheme.primaryColor.withOpacity(0.2),
                    AppTheme.primaryColor.withOpacity(0.1),
                  ],
                ),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.spa,
                color: AppTheme.primaryColor,
                size: 24.sp,
              ),
            ),
            title: Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        service['name'],
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 4.h),
                      Text(
                        '${service['price']}€ • ${service['duration']} min',
                        style: TextStyle(
                          fontSize: 14.sp,
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 8.w,
                    vertical: 4.h,
                  ),
                  decoration: BoxDecoration(
                    color: service['isActive'] == true
                        ? Colors.green.withOpacity(0.1)
                        : Colors.grey.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: Text(
                    service['isActive'] == true ? 'Actif' : 'Inactif',
                    style: TextStyle(
                      color: service['isActive'] == true
                          ? Colors.green
                          : Colors.grey,
                      fontSize: 12.sp,
                    ),
                  ),
                ),
              ],
            ),
            subtitle: service['description'] != null
                ? Padding(
                    padding: EdgeInsets.only(top: 8.h),
                    child: Text(
                      service['description'],
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.grey[600],
                      ),
                    ),
                  )
                : null,
          ),
          Container(
            decoration: BoxDecoration(
              border: Border(
                top: BorderSide(
                  color: Colors.grey.withOpacity(0.2),
                ),
              ),
            ),
            child: Row(
              children: [
                Expanded(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => _editService(service),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.edit,
                              color: AppTheme.primaryColor,
                              size: 20.sp,
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              'Modifier',
                              style: TextStyle(
                                color: AppTheme.primaryColor,
                                fontWeight: FontWeight.w500,
                                fontSize: 14.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Container(
                  width: 1,
                  height: 24.h,
                  color: Colors.grey.withOpacity(0.2),
                ),
                Expanded(
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () => _deleteService(service),
                      child: Padding(
                        padding: EdgeInsets.symmetric(vertical: 12.h),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.delete_outline,
                              color: Colors.red,
                              size: 20.sp,
                            ),
                            SizedBox(width: 8.w),
                            Text(
                              'Supprimer',
                              style: TextStyle(
                                color: Colors.red,
                                fontWeight: FontWeight.w500,
                                fontSize: 14.sp,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  ImageProvider _getImageProvider(String path) {
    if (path.startsWith('http')) {
      return NetworkImage(path);
    } else {
      return FileImage(File(path));
    }
  }

  Future<void> _addPhotos(Map<String, dynamic> service) async {
    try {
      final List<XFile>? images = await _picker.pickMultiImage();
      
      if (images != null && images.isNotEmpty) {
        setState(() {
          if (service['images'] == null) {
            service['images'] = [];
          }
          service['images'].addAll(
            images.map((image) => image.path).toList(),
          );
        });
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erreur lors de l\'ajout des images: $e'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  void _deleteService(Map<String, dynamic> service) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Supprimer le service'),
        content: Text('Êtes-vous sûr de vouloir supprimer ${service['name']} ?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(
              'Annuler',
              style: TextStyle(color: Colors.grey),
            ),
          ),
          TextButton(
            onPressed: () {
              setState(() {
                services.removeWhere((s) => s['id'] == service['id']);
              });
              Navigator.pop(context);
            },
            child: Text(
              'Supprimer',
              style: TextStyle(color: Colors.red),
            ),
          ),
        ],
      ),
    );
  }
}
