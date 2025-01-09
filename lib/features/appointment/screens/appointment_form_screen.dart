import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/app_theme.dart';
import '../../professional/models/professional.dart';
import '../models/appointment.dart';

class AppointmentFormScreen extends StatefulWidget {
  final Professional professional;

  const AppointmentFormScreen({
    super.key,
    required this.professional,
  });

  @override
  State<AppointmentFormScreen> createState() => _AppointmentFormScreenState();
}

class _AppointmentFormScreenState extends State<AppointmentFormScreen> {
  final _formKey = GlobalKey<FormState>();
  final _firstNameController = TextEditingController();
  final _lastNameController = TextEditingController();
  DateTime? _selectedDate;
  TimeOfDay? _selectedTime;
  String? _selectedService;
  final _allergiesController = TextEditingController();
  String? _inspirationPhotoUrl;
  bool _isAtSalon = true; // Par défaut, RDV au salon
  LatLng? _selectedLocation;
  final _addressController = TextEditingController();
  final _personalNoteController = TextEditingController();
  PaymentMethod _selectedPaymentMethod = PaymentMethod.card;

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(const Duration(days: 90)),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppTheme.primaryColor,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
      // Sélectionner l'heure après la date
      _selectTime();
    }
  }

  Future<void> _selectTime() async {
    final TimeOfDay? result = await showModalBottomSheet<TimeOfDay>(
      context: context,
      backgroundColor: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (BuildContext context) {
        // Créneaux horaires de 9h à 19h avec intervalles de 30 minutes
        final List<TimeOfDay> timeSlots = [];
        for (int hour = 9; hour < 19; hour++) {
          timeSlots.add(TimeOfDay(hour: hour, minute: 0));
          timeSlots.add(TimeOfDay(hour: hour, minute: 30));
        }

        return Container(
          height: 400.h,
          padding: EdgeInsets.all(16.r),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Choisir un horaire',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
              SizedBox(height: 16.h),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 2.5,
                    crossAxisSpacing: 10.w,
                    mainAxisSpacing: 10.h,
                  ),
                  itemCount: timeSlots.length,
                  itemBuilder: (context, index) {
                    final time = timeSlots[index];
                    final isSelected = _selectedTime != null &&
                        _selectedTime!.hour == time.hour &&
                        _selectedTime!.minute == time.minute;

                    return InkWell(
                      onTap: () {
                        Navigator.pop(context, time);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppTheme.primaryColor
                              : AppTheme.primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8.r),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          time.format(context),
                          style: TextStyle(
                            color: isSelected ? Colors.white : AppTheme.primaryColor,
                            fontWeight: isSelected
                                ? FontWeight.bold
                                : FontWeight.normal,
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
      },
    );

    if (result != null) {
      setState(() {
        _selectedTime = result;
      });
    }
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      setState(() {
        _inspirationPhotoUrl = image.path;
      });
    }
  }

  Future<void> _selectLocation() async {
    // TODO: Implémenter la sélection de l'emplacement sur la carte
    // Utiliser un package comme google_maps_flutter pour permettre à l'utilisateur
    // de sélectionner son emplacement
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Prendre rendez-vous'),
        backgroundColor: Colors.transparent,
        elevation: 0,
        foregroundColor: Colors.white,
      ),
      extendBodyBehindAppBar: true,
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Color(0xFFE0D0FF), // Violet très clair
              Color(0xFFF1EBFF), // Violet clair chromé
              Color(0xFFE8E1FF), // Violet clair brillant
              Color(0xFFEEE6FF), // Violet clair métallique
            ],
          ),
        ),
        child: Form(
          key: _formKey,
          child: ListView(
            padding: EdgeInsets.all(16.r),
            children: [
              SizedBox(height: 60.h), // Espace pour l'AppBar
              // Conteneur principal avec effet glassmorphism
              Container(
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.7),
                  borderRadius: BorderRadius.circular(20.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.purple.withOpacity(0.1),
                      blurRadius: 20,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                padding: EdgeInsets.all(20.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // En-tête stylisé
                    Container(
                      margin: EdgeInsets.only(bottom: 24.h),
                      child: Text(
                        'Détails du rendez-vous',
                        style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF6B4E9E), // Violet foncé
                          shadows: [
                            Shadow(
                              color: Colors.purple.withOpacity(0.2),
                              blurRadius: 2,
                              offset: const Offset(1, 1),
                            ),
                          ],
                        ),
                      ),
                    ),

                    // Nom et prénom
                    Row(
                      children: [
                        Expanded(
                          child: TextFormField(
                            controller: _firstNameController,
                            decoration: InputDecoration(
                              labelText: 'Prénom',
                              prefixIcon: Icon(Icons.person_outline, color: Color(0xFF6B4E9E)),
                              labelStyle: TextStyle(color: Color(0xFF6B4E9E)),
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.9),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.r),
                                borderSide: BorderSide.none,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.r),
                                borderSide: BorderSide(
                                  color: Color(0xFFE0D0FF),
                                  width: 1.5,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.r),
                                borderSide: BorderSide(
                                  color: Color(0xFF6B4E9E),
                                  width: 1.5,
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Veuillez entrer votre prénom';
                              }
                              return null;
                            },
                          ),
                        ),
                        SizedBox(width: 16.w),
                        Expanded(
                          child: TextFormField(
                            controller: _lastNameController,
                            decoration: InputDecoration(
                              labelText: 'Nom',
                              prefixIcon: Icon(Icons.person_outline, color: Color(0xFF6B4E9E)),
                              labelStyle: TextStyle(color: Color(0xFF6B4E9E)),
                              filled: true,
                              fillColor: Colors.white.withOpacity(0.9),
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.r),
                                borderSide: BorderSide.none,
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.r),
                                borderSide: BorderSide(
                                  color: Color(0xFFE0D0FF),
                                  width: 1.5,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12.r),
                                borderSide: BorderSide(
                                  color: Color(0xFF6B4E9E),
                                  width: 1.5,
                                ),
                              ),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Veuillez entrer votre nom';
                              }
                              return null;
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16.h),

                    // Date et heure
                    InkWell(
                      onTap: _selectDate,
                      child: InputDecorator(
                        decoration: InputDecoration(
                          labelText: 'Date et heure',
                          prefixIcon: Icon(Icons.calendar_today, color: Color(0xFF6B4E9E)),
                          labelStyle: TextStyle(color: Color(0xFF6B4E9E)),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.9),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: BorderSide(
                              color: Color(0xFFE0D0FF),
                              width: 1.5,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: BorderSide(
                              color: Color(0xFF6B4E9E),
                              width: 1.5,
                            ),
                          ),
                        ),
                        child: Text(
                          _selectedDate != null && _selectedTime != null
                              ? '${DateFormat('dd/MM/yyyy').format(_selectedDate!)} à ${_selectedTime!.format(context)}'
                              : 'Sélectionner une date et une heure',
                        ),
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // Service
                    DropdownButtonFormField<String>(
                      value: _selectedService,
                      decoration: InputDecoration(
                        labelText: 'Prestation',
                        prefixIcon: Icon(Icons.spa, color: Color(0xFF6B4E9E)),
                        labelStyle: TextStyle(color: Color(0xFF6B4E9E)),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.9),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide(
                            color: Color(0xFFE0D0FF),
                            width: 1.5,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide(
                            color: Color(0xFF6B4E9E),
                            width: 1.5,
                          ),
                        ),
                      ),
                      items: widget.professional.services.map((service) {
                        return DropdownMenuItem(
                          value: service,
                          child: Text(service),
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedService = value;
                        });
                      },
                      validator: (value) {
                        if (value == null) {
                          return 'Veuillez sélectionner une prestation';
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: 16.h),

                    // Allergies
                    TextFormField(
                      controller: _allergiesController,
                      decoration: InputDecoration(
                        labelText: 'Allergies (facultatif)',
                        prefixIcon: Icon(Icons.warning_amber, color: Color(0xFF6B4E9E)),
                        labelStyle: TextStyle(color: Color(0xFF6B4E9E)),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.9),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide(
                            color: Color(0xFFE0D0FF),
                            width: 1.5,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide(
                            color: Color(0xFF6B4E9E),
                            width: 1.5,
                          ),
                        ),
                      ),
                      maxLines: 2,
                    ),
                    SizedBox(height: 16.h),

                    // Photo d'inspiration
                    InkWell(
                      onTap: _pickImage,
                      child: InputDecorator(
                        decoration: InputDecoration(
                          labelText: 'Photo d\'inspiration (facultatif)',
                          prefixIcon: Icon(Icons.image, color: Color(0xFF6B4E9E)),
                          labelStyle: TextStyle(color: Color(0xFF6B4E9E)),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.9),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: BorderSide.none,
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: BorderSide(
                              color: Color(0xFFE0D0FF),
                              width: 1.5,
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: BorderSide(
                              color: Color(0xFF6B4E9E),
                              width: 1.5,
                            ),
                          ),
                        ),
                        child: _inspirationPhotoUrl != null
                            ? Image.asset(
                                _inspirationPhotoUrl!,
                                height: 100.h,
                                fit: BoxFit.cover,
                              )
                            : Text(
                                'Ajouter une photo',
                                style: TextStyle(
                                  color: Colors.grey[600],
                                ),
                              ),
                      ),
                    ),
                    SizedBox(height: 16.h),

                    // Lieu du rendez-vous
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(20.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.purple.withOpacity(0.1),
                            blurRadius: 20,
                            spreadRadius: 5,
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(20.r),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Lieu du rendez-vous',
                            style: TextStyle(
                              fontSize: 16.sp,
                              fontWeight: FontWeight.bold,
                              color: Color(0xFF6B4E9E), // Violet foncé
                              shadows: [
                                Shadow(
                                  color: Colors.purple.withOpacity(0.2),
                                  blurRadius: 2,
                                  offset: const Offset(1, 1),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 12.h),
                          Row(
                            children: [
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      _isAtSalon = true;
                                      _selectedLocation = null;
                                      _addressController.clear();
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(12.r),
                                    decoration: BoxDecoration(
                                      color: _isAtSalon
                                          ? AppTheme.primaryColor
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(8.r),
                                      border: Border.all(
                                        color: _isAtSalon
                                            ? AppTheme.primaryColor
                                            : Colors.grey[300]!,
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        Icon(
                                          Icons.store,
                                          color: _isAtSalon
                                              ? Colors.white
                                              : Colors.grey[600],
                                          size: 24.sp,
                                        ),
                                        SizedBox(height: 8.h),
                                        Text(
                                          'Au salon',
                                          style: TextStyle(
                                            color: _isAtSalon
                                                ? Colors.white
                                                : Colors.grey[600],
                                            fontWeight: _isAtSalon
                                                ? FontWeight.bold
                                                : FontWeight.normal,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              SizedBox(width: 16.w),
                              Expanded(
                                child: InkWell(
                                  onTap: () {
                                    setState(() {
                                      _isAtSalon = false;
                                    });
                                  },
                                  child: Container(
                                    padding: EdgeInsets.all(12.r),
                                    decoration: BoxDecoration(
                                      color: !_isAtSalon
                                          ? AppTheme.primaryColor
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(8.r),
                                      border: Border.all(
                                        color: !_isAtSalon
                                            ? AppTheme.primaryColor
                                            : Colors.grey[300]!,
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        Icon(
                                          Icons.home,
                                          color: !_isAtSalon
                                              ? Colors.white
                                              : Colors.grey[600],
                                          size: 24.sp,
                                        ),
                                        SizedBox(height: 8.h),
                                        Text(
                                          'À domicile',
                                          style: TextStyle(
                                            color: !_isAtSalon
                                                ? Colors.white
                                                : Colors.grey[600],
                                            fontWeight: !_isAtSalon
                                                ? FontWeight.bold
                                                : FontWeight.normal,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    // Adresse si à domicile
                    if (!_isAtSalon) ...[
                      SizedBox(height: 16.h),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.7),
                          borderRadius: BorderRadius.circular(20.r),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.purple.withOpacity(0.1),
                              blurRadius: 20,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        padding: EdgeInsets.all(20.r),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Votre adresse',
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF6B4E9E), // Violet foncé
                                shadows: [
                                  Shadow(
                                    color: Colors.purple.withOpacity(0.2),
                                    blurRadius: 2,
                                    offset: const Offset(1, 1),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 12.h),
                            TextFormField(
                              controller: _addressController,
                              decoration: InputDecoration(
                                labelText: 'Entrez votre adresse',
                                prefixIcon: Icon(Icons.location_on, color: Color(0xFF6B4E9E)),
                                labelStyle: TextStyle(color: Color(0xFF6B4E9E)),
                                filled: true,
                                fillColor: Colors.white.withOpacity(0.9),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                  borderSide: BorderSide.none,
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                  borderSide: BorderSide(
                                    color: Color(0xFFE0D0FF),
                                    width: 1.5,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(12.r),
                                  borderSide: BorderSide(
                                    color: Color(0xFF6B4E9E),
                                    width: 1.5,
                                  ),
                                ),
                              ),
                              validator: !_isAtSalon
                                  ? (value) {
                                      if (value == null || value.isEmpty) {
                                        return 'Veuillez entrer votre adresse';
                                      }
                                      return null;
                                    }
                                  : null,
                            ),
                            SizedBox(height: 12.h),
                            SizedBox(
                              width: double.infinity,
                              child: ElevatedButton.icon(
                                onPressed: _selectLocation,
                                icon: const Icon(Icons.map),
                                label: const Text('Sélectionner sur la carte'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppTheme.primaryColor,
                                  padding: EdgeInsets.symmetric(vertical: 12.h),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8.r),
                                  ),
                                ),
                              ),
                            ),
                            if (_selectedLocation != null) ...[
                              SizedBox(height: 12.h),
                              Container(
                                height: 150.h,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8.r),
                                  border: Border.all(color: Colors.grey[300]!),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8.r),
                                  child: GoogleMap(
                                    initialCameraPosition: CameraPosition(
                                      target: _selectedLocation!,
                                      zoom: 15,
                                    ),
                                    markers: {
                                      Marker(
                                        markerId: const MarkerId('selected_location'),
                                        position: _selectedLocation!,
                                      ),
                                    },
                                    zoomControlsEnabled: false,
                                    mapToolbarEnabled: false,
                                    myLocationButtonEnabled: false,
                                  ),
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ],

                    // Note personnelle
                    TextFormField(
                      controller: _personalNoteController,
                      decoration: InputDecoration(
                        labelText: 'Note personnelle (facultatif)',
                        prefixIcon: Icon(Icons.note, color: Color(0xFF6B4E9E)),
                        labelStyle: TextStyle(color: Color(0xFF6B4E9E)),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.9),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide(
                            color: Color(0xFFE0D0FF),
                            width: 1.5,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide(
                            color: Color(0xFF6B4E9E),
                            width: 1.5,
                          ),
                        ),
                      ),
                      maxLines: 3,
                    ),
                    SizedBox(height: 16.h),

                    // Mode de paiement
                    DropdownButtonFormField<PaymentMethod>(
                      value: _selectedPaymentMethod,
                      decoration: InputDecoration(
                        labelText: 'Mode de paiement',
                        prefixIcon: Icon(Icons.payment, color: Color(0xFF6B4E9E)),
                        labelStyle: TextStyle(color: Color(0xFF6B4E9E)),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.9),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide.none,
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide(
                            color: Color(0xFFE0D0FF),
                            width: 1.5,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide(
                            color: Color(0xFF6B4E9E),
                            width: 1.5,
                          ),
                        ),
                      ),
                      items: PaymentMethod.values.map((method) {
                        return DropdownMenuItem(
                          value: method,
                          child: Row(
                            children: [
                              Icon(
                                method.icon,
                                color: AppTheme.primaryColor,
                                size: 20.sp,
                              ),
                              SizedBox(width: 12.w),
                              Text(method.displayName),
                            ],
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != null) {
                          setState(() {
                            _selectedPaymentMethod = value;
                          });
                        }
                      },
                    ),
                    SizedBox(height: 32.h),

                    // Bouton de validation avec dégradé
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 32.h),
                      width: double.infinity,
                      height: 56.h,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16.r),
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFF9D84E8), // Violet moyen
                            Color(0xFF8A6FE8), // Violet
                            Color(0xFF7B5FE8), // Violet foncé
                          ],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFF9D84E8).withOpacity(0.3),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            if (_selectedDate == null || _selectedTime == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Veuillez sélectionner une date et une heure'),
                                ),
                              );
                              return;
                            }

                            if (!_isAtSalon && _selectedLocation == null) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Veuillez sélectionner votre adresse'),
                                ),
                              );
                              return;
                            }

                            // TODO: Créer le rendez-vous et l'envoyer au backend
                            final appointment = Appointment(
                              firstName: _firstNameController.text,
                              lastName: _lastNameController.text,
                              dateTime: DateTime(
                                _selectedDate!.year,
                                _selectedDate!.month,
                                _selectedDate!.day,
                                _selectedTime!.hour,
                                _selectedTime!.minute,
                              ),
                              service: _selectedService!,
                              allergies: _allergiesController.text.isEmpty
                                  ? null
                                  : _allergiesController.text,
                              inspirationPhotoUrl: _inspirationPhotoUrl,
                              isAtHome: !_isAtSalon,
                              location: _selectedLocation,
                              personalNote: _personalNoteController.text.isEmpty
                                  ? null
                                  : _personalNoteController.text,
                              paymentMethod: _selectedPaymentMethod,
                            );

                            // Afficher une confirmation
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text('Rendez-vous pris avec succès !'),
                                backgroundColor: Colors.green,
                              ),
                            );

                            // Retourner à l'écran précédent
                            Navigator.pop(context);
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16.r),
                          ),
                          padding: EdgeInsets.zero,
                          minimumSize: Size(double.infinity, 56.h),
                        ),
                        child: Container(
                          width: double.infinity,
                          alignment: Alignment.center,
                          child: Text(
                            'Confirmer le rendez-vous',
                            style: TextStyle(
                              fontSize: 18.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
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
        ),
      ),
    );
  }

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _allergiesController.dispose();
    _personalNoteController.dispose();
    super.dispose();
  }
}
