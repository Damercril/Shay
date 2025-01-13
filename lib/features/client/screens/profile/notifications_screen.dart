import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_theme.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  // Notification settings
  bool _appointmentReminders = true;
  bool _promotions = true;
  bool _messages = true;
  bool _statusUpdates = true;
  bool _emailNotifications = true;
  bool _smsNotifications = false;
  bool _pushNotifications = true;

  // Sample notifications
  final List<Map<String, dynamic>> _notifications = [
    {
      'type': 'appointment',
      'title': 'Rappel de rendez-vous',
      'message': 'Votre rendez-vous avec Sarah Martin est demain à 14h00',
      'time': DateTime.now().subtract(const Duration(hours: 2)),
      'read': false,
    },
    {
      'type': 'promotion',
      'title': 'Offre spéciale',
      'message': '-20% sur tous les services de massage ce week-end !',
      'time': DateTime.now().subtract(const Duration(hours: 5)),
      'read': true,
    },
    {
      'type': 'message',
      'title': 'Nouveau message',
      'message': 'Marie Dubois vous a envoyé un message',
      'time': DateTime.now().subtract(const Duration(days: 1)),
      'read': false,
    },
    {
      'type': 'status',
      'title': 'Statut de réservation',
      'message': 'Votre réservation a été confirmée par Julie Bernard',
      'time': DateTime.now().subtract(const Duration(days: 2)),
      'read': true,
    },
  ];

  Widget _buildSettingSwitch({
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return ListTile(
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
      trailing: Switch(
        value: value,
        onChanged: onChanged,
        activeColor: AppTheme.primaryColor,
      ),
    );
  }

  IconData _getNotificationIcon(String type) {
    switch (type) {
      case 'appointment':
        return Icons.calendar_today;
      case 'promotion':
        return Icons.local_offer;
      case 'message':
        return Icons.message;
      case 'status':
        return Icons.notifications;
      default:
        return Icons.notifications;
    }
  }

  Color _getNotificationColor(String type) {
    switch (type) {
      case 'appointment':
        return Colors.blue;
      case 'promotion':
        return Colors.orange;
      case 'message':
        return Colors.green;
      case 'status':
        return Colors.purple;
      default:
        return Colors.grey;
    }
  }

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inMinutes < 60) {
      return 'Il y a ${difference.inMinutes} min';
    } else if (difference.inHours < 24) {
      return 'Il y a ${difference.inHours}h';
    } else if (difference.inDays < 7) {
      return 'Il y a ${difference.inDays}j';
    } else {
      return '${time.day}/${time.month}/${time.year}';
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            'Notifications',
            style: TextStyle(
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Notifications'),
              Tab(text: 'Paramètres'),
            ],
            labelColor: AppTheme.primaryColor,
            unselectedLabelColor: Colors.grey,
            indicatorColor: AppTheme.primaryColor,
          ),
        ),
        body: TabBarView(
          children: [
            // Notifications Tab
            _notifications.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.notifications_none,
                          size: 64.w,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 16.h),
                        Text(
                          'Aucune notification',
                          style: TextStyle(
                            fontSize: 16.sp,
                            color: Colors.grey[600],
                          ),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    itemCount: _notifications.length,
                    itemBuilder: (context, index) {
                      final notification = _notifications[index];
                      return Dismissible(
                        key: Key(notification['title']),
                        direction: DismissDirection.endToStart,
                        background: Container(
                          color: Colors.red,
                          alignment: Alignment.centerRight,
                          padding: EdgeInsets.only(right: 16.w),
                          child: const Icon(
                            Icons.delete,
                            color: Colors.white,
                          ),
                        ),
                        onDismissed: (direction) {
                          setState(() {
                            _notifications.removeAt(index);
                          });
                        },
                        child: Container(
                          color: notification['read']
                              ? null
                              : AppTheme.primaryColor.withOpacity(0.05),
                          child: ListTile(
                            leading: CircleAvatar(
                              backgroundColor: _getNotificationColor(
                                notification['type'],
                              ).withOpacity(0.1),
                              child: Icon(
                                _getNotificationIcon(notification['type']),
                                color: _getNotificationColor(notification['type']),
                              ),
                            ),
                            title: Text(
                              notification['title'],
                              style: TextStyle(
                                fontSize: 16.sp,
                                fontWeight: notification['read']
                                    ? FontWeight.normal
                                    : FontWeight.bold,
                              ),
                            ),
                            subtitle: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  notification['message'],
                                  style: TextStyle(
                                    fontSize: 14.sp,
                                    color: Colors.grey[600],
                                  ),
                                ),
                                SizedBox(height: 4.h),
                                Text(
                                  _formatTime(notification['time']),
                                  style: TextStyle(
                                    fontSize: 12.sp,
                                    color: Colors.grey[500],
                                  ),
                                ),
                              ],
                            ),
                            onTap: () {
                              setState(() {
                                notification['read'] = true;
                              });
                            },
                          ),
                        ),
                      );
                    },
                  ),

            // Settings Tab
            ListView(
              children: [
                Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Text(
                    'Types de notifications',
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
                      _buildSettingSwitch(
                        title: 'Rappels de rendez-vous',
                        subtitle: 'Notifications pour vos rendez-vous à venir',
                        value: _appointmentReminders,
                        onChanged: (value) {
                          setState(() {
                            _appointmentReminders = value;
                          });
                        },
                      ),
                      Divider(height: 1, color: Colors.grey[200]),
                      _buildSettingSwitch(
                        title: 'Promotions',
                        subtitle: 'Offres spéciales et réductions',
                        value: _promotions,
                        onChanged: (value) {
                          setState(() {
                            _promotions = value;
                          });
                        },
                      ),
                      Divider(height: 1, color: Colors.grey[200]),
                      _buildSettingSwitch(
                        title: 'Messages',
                        subtitle: 'Nouveaux messages des professionnels',
                        value: _messages,
                        onChanged: (value) {
                          setState(() {
                            _messages = value;
                          });
                        },
                      ),
                      Divider(height: 1, color: Colors.grey[200]),
                      _buildSettingSwitch(
                        title: 'Mises à jour de statut',
                        subtitle: 'Confirmations et modifications de réservation',
                        value: _statusUpdates,
                        onChanged: (value) {
                          setState(() {
                            _statusUpdates = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24.h),
                Padding(
                  padding: EdgeInsets.all(16.w),
                  child: Text(
                    'Canaux de notification',
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
                      _buildSettingSwitch(
                        title: 'Notifications par email',
                        subtitle: 'Recevoir des notifications par email',
                        value: _emailNotifications,
                        onChanged: (value) {
                          setState(() {
                            _emailNotifications = value;
                          });
                        },
                      ),
                      Divider(height: 1, color: Colors.grey[200]),
                      _buildSettingSwitch(
                        title: 'Notifications SMS',
                        subtitle: 'Recevoir des notifications par SMS',
                        value: _smsNotifications,
                        onChanged: (value) {
                          setState(() {
                            _smsNotifications = value;
                          });
                        },
                      ),
                      Divider(height: 1, color: Colors.grey[200]),
                      _buildSettingSwitch(
                        title: 'Notifications push',
                        subtitle: 'Recevoir des notifications sur l\'application',
                        value: _pushNotifications,
                        onChanged: (value) {
                          setState(() {
                            _pushNotifications = value;
                          });
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24.h),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
