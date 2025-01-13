import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_theme.dart';
import 'live_chat_screen.dart';
import 'help_center_screen.dart';
import 'feedback_screen.dart';

class HelpSupportScreen extends StatelessWidget {
  const HelpSupportScreen({super.key});

  Widget _buildFAQItem(String question, String answer) {
    return ExpansionTile(
      title: Text(
        question,
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
      children: [
        Padding(
          padding: EdgeInsets.all(16.w),
          child: Text(
            answer,
            style: TextStyle(
              fontSize: 14.sp,
              color: Colors.grey[600],
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildContactOption({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return ListTile(
      leading: Icon(icon, color: AppTheme.primaryColor),
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        subtitle,
        style: TextStyle(
          fontSize: 14.sp,
          color: Colors.grey[600],
        ),
      ),
      trailing: Icon(
        Icons.chevron_right,
        color: Colors.grey[400],
      ),
      onTap: onTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Aide & Support',
          style: TextStyle(
            fontSize: 20.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Contact Section
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Text(
                'Nous contacter',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.symmetric(horizontal: 16.w),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                children: [
                  _buildContactOption(
                    icon: Icons.chat_bubble_outline,
                    title: 'Chat en direct',
                    subtitle: 'Discutez avec notre équipe',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const LiveChatScreen(),
                        ),
                      );
                    },
                  ),
                  Divider(height: 1, color: Colors.grey[200]),
                  _buildContactOption(
                    icon: Icons.email_outlined,
                    title: 'Email',
                    subtitle: 'support@shayniss.com',
                    onTap: () {
                      // Implement email contact
                    },
                  ),
                  Divider(height: 1, color: Colors.grey[200]),
                  _buildContactOption(
                    icon: Icons.phone_outlined,
                    title: 'Téléphone',
                    subtitle: '+33 1 23 45 67 89',
                    onTap: () {
                      // Implement phone call
                    },
                  ),
                ],
              ),
            ),

            // FAQ Section
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Text(
                'Questions fréquentes',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.symmetric(horizontal: 16.w),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                children: [
                  _buildFAQItem(
                    'Comment prendre rendez-vous ?',
                    'Pour prendre rendez-vous, sélectionnez un professionnel dans la liste, choisissez une date et une heure disponible, puis confirmez votre réservation.',
                  ),
                  _buildFAQItem(
                    'Comment annuler un rendez-vous ?',
                    'Vous pouvez annuler un rendez-vous jusqu\'à 24h avant l\'heure prévue. Allez dans la section "Mes rendez-vous", sélectionnez le rendez-vous à annuler et cliquez sur "Annuler".',
                  ),
                  _buildFAQItem(
                    'Comment payer mes services ?',
                    'Nous acceptons les paiements par carte bancaire et PayPal. Vous pouvez ajouter vos moyens de paiement dans la section "Moyens de paiement" de votre profil.',
                  ),
                  _buildFAQItem(
                    'Comment modifier mes informations personnelles ?',
                    'Accédez à votre profil, puis cliquez sur "Informations personnelles". Vous pourrez y modifier vos coordonnées et autres informations.',
                  ),
                  _buildFAQItem(
                    'Comment contacter un professionnel ?',
                    'Vous pouvez contacter un professionnel via la messagerie intégrée de l\'application après avoir pris rendez-vous avec lui.',
                  ),
                ],
              ),
            ),

            // Support Center
            Padding(
              padding: EdgeInsets.all(16.w),
              child: Text(
                'Centre de support',
                style: TextStyle(
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey[800],
                ),
              ),
            ),
            Card(
              margin: EdgeInsets.symmetric(horizontal: 16.w),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Column(
                children: [
                  _buildContactOption(
                    icon: Icons.article_outlined,
                    title: 'Centre d\'aide',
                    subtitle: 'Consultez notre documentation',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const HelpCenterScreen(),
                        ),
                      );
                    },
                  ),
                  Divider(height: 1, color: Colors.grey[200]),
                  _buildContactOption(
                    icon: Icons.video_library_outlined,
                    title: 'Tutoriels vidéo',
                    subtitle: 'Apprenez à utiliser l\'application',
                    onTap: () {
                      // Navigate to video tutorials
                    },
                  ),
                  Divider(height: 1, color: Colors.grey[200]),
                  _buildContactOption(
                    icon: Icons.feedback_outlined,
                    title: 'Suggestions',
                    subtitle: 'Donnez-nous votre avis',
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const FeedbackScreen(),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(height: 24.h),
          ],
        ),
      ),
    );
  }
}
