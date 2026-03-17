import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';

class GeofenceSetup extends StatefulWidget {
  const GeofenceSetup({super.key});

  @override
  State<GeofenceSetup> createState() => _GeofenceSetupState();
}

class _GeofenceSetupState extends State<GeofenceSetup> {
  double _radiusMeters = 120;
  bool _notifyOnEntry = true;
  bool _notifyOnExit = true;
  bool _strictMode = false;

  final List<Map<String, String>> _zones = [
    {'name': 'Main Block', 'location': 'North Gate Axis', 'status': 'Active'},
    {
      'name': 'Science Lab Wing',
      'location': 'Lab 1 - Lab 4 Corridor',
      'status': 'Active',
    },
    {'name': 'Sports Hall', 'location': 'South Compound', 'status': 'Draft'},
  ];

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        title: const Text('Geofence Setup'),
        backgroundColor: AppColors.darkNavy,
        foregroundColor: AppColors.white,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(size.width * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: double.infinity,
                padding: EdgeInsets.all(size.width * 0.045),
                decoration: BoxDecoration(
                  color: AppColors.lightBlueTint,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: AppColors.skyBlue.withOpacity(0.15),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const Icon(
                            Icons.sensors,
                            color: AppColors.skyBlue,
                          ),
                        ),
                        SizedBox(width: size.width * 0.03),
                        Expanded(
                          child: Text(
                            'Configure smart safety zones for automated attendance and movement alerts.',
                            style: TextStyle(
                              fontSize: size.width * 0.035,
                              color: AppColors.darkNavy,
                              height: 1.35,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: size.height * 0.012),
                    Text(
                      'Current default radius: ${_radiusMeters.round()}m',
                      style: TextStyle(
                        fontWeight: FontWeight.w600,
                        color: AppColors.darkNavy,
                        fontSize: size.width * 0.034,
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.022),
              Text(
                'Geofence Radius',
                style: TextStyle(
                  fontSize: size.width * 0.042,
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkNavy,
                ),
              ),
              Slider(
                value: _radiusMeters,
                min: 50,
                max: 300,
                divisions: 25,
                label: '${_radiusMeters.round()}m',
                activeColor: AppColors.skyBlue,
                onChanged: (value) => setState(() => _radiusMeters = value),
              ),
              SizedBox(height: size.height * 0.01),
              Text(
                'Notification Rules',
                style: TextStyle(
                  fontSize: size.width * 0.042,
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkNavy,
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: size.height * 0.01),
                decoration: BoxDecoration(
                  color: AppColors.lightGrey,
                  borderRadius: BorderRadius.circular(14),
                ),
                child: Column(
                  children: [
                    SwitchListTile(
                      value: _notifyOnEntry,
                      activeColor: AppColors.skyBlue,
                      title: const Text('Notify on entry'),
                      subtitle: const Text('Alert when students enter zone'),
                      onChanged:
                          (value) => setState(() => _notifyOnEntry = value),
                    ),
                    SwitchListTile(
                      value: _notifyOnExit,
                      activeColor: AppColors.skyBlue,
                      title: const Text('Notify on exit'),
                      subtitle: const Text('Alert when students leave zone'),
                      onChanged:
                          (value) => setState(() => _notifyOnExit = value),
                    ),
                    SwitchListTile(
                      value: _strictMode,
                      activeColor: AppColors.skyBlue,
                      title: const Text('Strict mode'),
                      subtitle: const Text(
                        'Escalate repeated exits to admin alerts',
                      ),
                      onChanged: (value) => setState(() => _strictMode = value),
                    ),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.02),
              Text(
                'Configured Zones',
                style: TextStyle(
                  fontSize: size.width * 0.042,
                  fontWeight: FontWeight.bold,
                  color: AppColors.darkNavy,
                ),
              ),
              SizedBox(height: size.height * 0.01),
              ..._zones.map((zone) {
                final isActive = zone['status'] == 'Active';
                final statusColor =
                    isActive ? AppColors.successGreen : AppColors.warningYellow;

                return Container(
                  width: double.infinity,
                  margin: const EdgeInsets.only(bottom: 10),
                  padding: EdgeInsets.all(size.width * 0.04),
                  decoration: BoxDecoration(
                    color: AppColors.lightGrey,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.location_on, color: AppColors.skyBlue),
                      SizedBox(width: size.width * 0.03),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              zone['name']!,
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: AppColors.darkNavy,
                                fontSize: size.width * 0.038,
                              ),
                            ),
                            Text(
                              zone['location']!,
                              style: TextStyle(
                                fontSize: size.width * 0.032,
                                color: AppColors.darkNavy.withOpacity(0.6),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: statusColor.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(16),
                        ),
                        child: Text(
                          zone['status']!,
                          style: TextStyle(
                            color: statusColor,
                            fontWeight: FontWeight.w600,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
              SizedBox(height: size.height * 0.01),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Geofence setup saved locally.'),
                      ),
                    );
                  },
                  icon: const Icon(Icons.save_outlined),
                  label: const Text('Save Geofence Configuration'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
