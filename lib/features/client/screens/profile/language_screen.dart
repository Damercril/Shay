import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_theme.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  String _selectedLanguage = 'fr';

  final List<Map<String, String>> _languages = [
    {
      'code': 'fr',
      'name': 'Français',
      'nativeName': 'Français',
      'flag': '🇫🇷',
    },
    {
      'code': 'en',
      'name': 'Anglais',
      'nativeName': 'English',
      'flag': '🇬🇧',
    },
    {
      'code': 'es',
      'name': 'Espagnol',
      'nativeName': 'Español',
      'flag': '🇪🇸',
    },
    {
      'code': 'de',
      'name': 'Allemand',
      'nativeName': 'Deutsch',
      'flag': '🇩🇪',
    },
    {
      'code': 'it',
      'name': 'Italien',
      'nativeName': 'Italiano',
      'flag': '🇮🇹',
    },
    {
      'code': 'pt',
      'name': 'Portugais',
      'nativeName': 'Português',
      'flag': '🇵🇹',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Langue',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(16.w),
            child: Text(
              'Sélectionnez votre langue',
              style: TextStyle(
                fontSize: 16.sp,
                color: Colors.grey[600],
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: _languages.length,
              itemBuilder: (context, index) {
                final language = _languages[index];
                final isSelected = language['code'] == _selectedLanguage;

                return Card(
                  margin: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 4.h,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                    side: BorderSide(
                      color: isSelected
                          ? AppTheme.primaryColor
                          : Colors.transparent,
                      width: 2,
                    ),
                  ),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        _selectedLanguage = language['code']!;
                      });
                      // Implement language change logic here
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            'Langue changée en ${language['name']}',
                          ),
                          backgroundColor: Colors.green,
                        ),
                      );
                    },
                    borderRadius: BorderRadius.circular(12.r),
                    child: Padding(
                      padding: EdgeInsets.all(16.w),
                      child: Row(
                        children: [
                          Text(
                            language['flag']!,
                            style: TextStyle(fontSize: 24.sp),
                          ),
                          SizedBox(width: 16.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  language['name']!,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                Text(
                                  language['nativeName']!,
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Colors.grey[600],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          if (isSelected)
                            Icon(
                              Icons.check_circle,
                              color: AppTheme.primaryColor,
                              size: 24.w,
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
    );
  }
}
