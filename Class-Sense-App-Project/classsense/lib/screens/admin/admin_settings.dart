import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../utils/app_colors.dart';
import '../../utils/app_routes.dart';

class AdminSettings extends StatefulWidget {
  const AdminSettings({super.key});

  @override
  State<AdminSettings> createState() => _AdminSettingsState();
}

class _AdminSettingsState extends State<AdminSettings> {
  bool _pushAlerts = true;
  bool _emailSummaries = true;
  bool _smsAlerts = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final user = FirebaseAuth.instance.currentUser;

    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(size.width * 0.05),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _AnimatedIn(
              index: 0,
              child: Text(
                'Admin Settings',
                style: TextStyle(
                  fontSize: size.width * 0.065,
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkNavy,
                ),
              ),
            ),
            SizedBox(height: size.height * 0.02),
            _AnimatedIn(
              index: 1,
              child: _buildProfileCard(size, user),
            ),
            SizedBox(height: size.height * 0.025),
            _AnimatedIn(
              index: 2,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle(size, 'School Profile'),
                  _buildInfoCard(
                    size,
                    children: const [
                      _InfoRow(label: 'School', value: 'Harmony Secondary'),
                      _InfoRow(label: 'District', value: 'Ikeja North'),
                      _InfoRow(label: 'Term', value: '2026 - Term 2'),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: size.height * 0.02),
            _AnimatedIn(
              index: 3,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle(size, 'Notification Preferences'),
                  _buildInfoCard(
                    size,
                    children: [
                      SwitchListTile(
                        value: _pushAlerts,
                        onChanged: (value) => setState(() => _pushAlerts = value),
                        title: const Text('Push Alerts'),
                        subtitle:
                            const Text('Notify admins about attendance spikes.'),
                        activeColor: AppColors.skyBlue,
                      ),
                      SwitchListTile(
                        value: _emailSummaries,
                        onChanged: (value) =>
                            setState(() => _emailSummaries = value),
                        title: const Text('Email Summaries'),
                        subtitle:
                            const Text('Weekly engagement reports via email.'),
                        activeColor: AppColors.skyBlue,
                      ),
                      SwitchListTile(
                        value: _smsAlerts,
                        onChanged: (value) => setState(() => _smsAlerts = value),
                        title: const Text('Emergency SMS'),
                        subtitle:
                            const Text('SMS for geofence breach alerts.'),
                        activeColor: AppColors.skyBlue,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: size.height * 0.02),
            _AnimatedIn(
              index: 4,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle(size, 'Security & Access'),
                  _buildInfoCard(
                    size,
                    children: const [
                      ListTile(
                        leading: Icon(Icons.lock_outline),
                        title: Text('Reset Password'),
                        subtitle: Text('Force password update for all users.'),
                      ),
                      ListTile(
                        leading: Icon(Icons.devices),
                        title: Text('Device Management'),
                        subtitle: Text('View active devices and sessions.'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: size.height * 0.02),
            _AnimatedIn(
              index: 5,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionTitle(size, 'Data & Privacy'),
                  _buildInfoCard(
                    size,
                    children: const [
                      ListTile(
                        leading: Icon(Icons.shield_outlined),
                        title: Text('Privacy Controls'),
                        subtitle: Text('Manage data retention and consent.'),
                      ),
                      ListTile(
                        leading: Icon(Icons.backup_outlined),
                        title: Text('Export Reports'),
                        subtitle: Text('Download attendance and engagement data.'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            SizedBox(height: size.height * 0.03),
            _AnimatedIn(
              index: 6,
              child: SizedBox(
                width: double.infinity,
                height: size.height * 0.065,
                child: ElevatedButton.icon(
                  onPressed: () async {
                    await FirebaseAuth.instance.signOut();
                    if (context.mounted) {
                      Navigator.pushReplacementNamed(context, AppRoutes.login);
                    }
                  },
                  icon: const Icon(Icons.logout),
                  label: const Text('Logout'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.alertRed,
                    foregroundColor: AppColors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 0,
                  ),
                ),
              ),
            ),
            SizedBox(height: size.height * 0.02),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileCard(Size size, User? user) {
    return Container(
      padding: EdgeInsets.all(size.width * 0.04),
      decoration: BoxDecoration(
        color: AppColors.lightBlueTint,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          CircleAvatar(
            radius: size.width * 0.08,
            backgroundColor: AppColors.darkNavy,
            child: Icon(
              Icons.admin_panel_settings,
              size: size.width * 0.08,
              color: AppColors.white,
            ),
          ),
          SizedBox(width: size.width * 0.04),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  user?.displayName ?? 'Admin',
                  style: TextStyle(
                    fontSize: size.width * 0.045,
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkNavy,
                  ),
                ),
                Text(
                  user?.email ?? 'admin@classsense.com',
                  style: TextStyle(
                    // ignore: deprecated_member_use
                    color: AppColors.darkNavy.withOpacity(0.6),
                    fontSize: size.width * 0.032,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
            decoration: BoxDecoration(
              // ignore: deprecated_member_use
              color: AppColors.alertRed.withOpacity(0.15),
              borderRadius: BorderRadius.circular(20),
            ),
            child: const Text(
              'Admin',
              style: TextStyle(
                color: AppColors.alertRed,
                fontWeight: FontWeight.w600,
                fontSize: 12,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(Size size, String title) {
    return Text(
      title,
      style: TextStyle(
        fontSize: size.width * 0.04,
        fontWeight: FontWeight.bold,
        color: AppColors.darkNavy,
      ),
    );
  }

  Widget _buildInfoCard(Size size, {required List<Widget> children}) {
    return Container(
      margin: EdgeInsets.only(top: size.height * 0.01),
      decoration: BoxDecoration(
        color: AppColors.lightGrey,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(children: children),
    );
  }
}

class _AnimatedIn extends StatelessWidget {
  final int index;
  final Widget child;

  const _AnimatedIn({
    required this.index,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 300 + (index * 80)),
      curve: Curves.easeOut,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, (1 - value) * 12),
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                color: AppColors.darkNavy,
              ),
            ),
          ),
          Text(
            value,
            style: TextStyle(
              color: AppColors.darkNavy.withOpacity(0.6),
            ),
          ),
        ],
      ),
    );
  }
}
