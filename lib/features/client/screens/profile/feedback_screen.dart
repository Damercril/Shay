import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_theme.dart';

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final _formKey = GlobalKey<FormState>();
  String _selectedType = 'Suggestion';
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final List<String> _attachments = [];

  final List<String> _feedbackTypes = [
    'Suggestion',
    'Bug',
    'Amélioration',
    'Autre',
  ];

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _submitFeedback() {
    if (_formKey.currentState!.validate()) {
      // TODO: Implement feedback submission
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Merci pour votre retour !'),
          backgroundColor: AppTheme.primaryColor,
        ),
      );
      Navigator.pop(context);
    }
  }

  Widget _buildTypeSelector() {
    return Container(
      height: 40.h,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: _feedbackTypes.length,
        itemBuilder: (context, index) {
          final type = _feedbackTypes[index];
          final isSelected = type == _selectedType;

          return Padding(
            padding: EdgeInsets.only(right: 8.w),
            child: ChoiceChip(
              label: Text(type),
              selected: isSelected,
              onSelected: (selected) {
                if (selected) {
                  setState(() {
                    _selectedType = type;
                  });
                }
              },
              selectedColor: AppTheme.primaryColor,
              labelStyle: TextStyle(
                color: isSelected ? Colors.white : Colors.black,
                fontSize: 14.sp,
              ),
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Suggestions',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.w),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Type de retour',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 8.h),
                _buildTypeSelector(),
                SizedBox(height: 24.h),

                // Title
                TextFormField(
                  controller: _titleController,
                  decoration: InputDecoration(
                    labelText: 'Titre',
                    hintText: 'Résumez votre suggestion en quelques mots',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer un titre';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.h),

                // Description
                TextFormField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    labelText: 'Description',
                    hintText: 'Décrivez votre suggestion en détail',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                    alignLabelWithHint: true,
                  ),
                  maxLines: 5,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Veuillez entrer une description';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 24.h),

                // Attachments
                Text(
                  'Pièces jointes',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                SizedBox(height: 8.h),
                Container(
                  height: 100.h,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey[300]!),
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                  child: _attachments.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.attach_file,
                                color: Colors.grey[400],
                                size: 24.w,
                              ),
                              SizedBox(height: 8.h),
                              Text(
                                'Ajoutez des captures d\'écran ou des fichiers',
                                style: TextStyle(
                                  fontSize: 14.sp,
                                  color: Colors.grey[600],
                                ),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          scrollDirection: Axis.horizontal,
                          padding: EdgeInsets.all(8.w),
                          itemCount: _attachments.length + 1,
                          itemBuilder: (context, index) {
                            if (index == _attachments.length) {
                              return Container(
                                width: 80.w,
                                margin: EdgeInsets.only(right: 8.w),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Colors.grey[300]!,
                                  ),
                                  borderRadius: BorderRadius.circular(8.r),
                                ),
                                child: IconButton(
                                  icon: const Icon(Icons.add),
                                  onPressed: () {
                                    // Add attachment
                                  },
                                ),
                              );
                            }

                            return Container(
                              width: 80.w,
                              margin: EdgeInsets.only(right: 8.w),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.grey[300]!,
                                ),
                                borderRadius: BorderRadius.circular(8.r),
                              ),
                              child: Stack(
                                children: [
                                  Center(
                                    child: Icon(
                                      Icons.insert_drive_file,
                                      color: Colors.grey[400],
                                    ),
                                  ),
                                  Positioned(
                                    top: 4.h,
                                    right: 4.w,
                                    child: IconButton(
                                      icon: const Icon(
                                        Icons.close,
                                        size: 16,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _attachments.removeAt(index);
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                ),
                SizedBox(height: 32.h),

                // Submit button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _submitFeedback,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryColor,
                      padding: EdgeInsets.symmetric(vertical: 16.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text(
                      'Envoyer',
                      style: TextStyle(
                        fontSize: 16.sp,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
