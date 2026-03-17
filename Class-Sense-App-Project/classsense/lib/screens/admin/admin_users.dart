import 'package:flutter/material.dart';
import '../../utils/app_colors.dart';
import '../../widgets/status_badge.dart';

class AdminUsers extends StatefulWidget {
  const AdminUsers({super.key});

  @override
  State<AdminUsers> createState() => _AdminUsersState();
}

class _AdminUsersState extends State<AdminUsers> {
  int _selectedFilter = 0;

  final List<Map<String, String>> _users = [
    {
      'name': 'John Doe',
      'email': 'john@mail.com',
      'role': 'Teacher',
      'status': 'Active',
    },
    {
      'name': 'Jane Smith',
      'email': 'jane@mail.com',
      'role': 'Student',
      'status': 'Active',
    },
    
    
  ];

  List<Map<String, String>> get _filteredUsers {
    if (_selectedFilter == 1) {
      return _users.where((user) => user['role'] == 'Teacher').toList();
    }
    if (_selectedFilter == 2) {
      return _users.where((user) => user['role'] == 'Student').toList();
    }
    return _users;
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.white,
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Add user coming soon.')),
          );
        },
        backgroundColor: AppColors.skyBlue,
        foregroundColor: AppColors.white,
        icon: const Icon(Icons.person_add),
        label: const Text('Add User'),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(size.width * 0.05),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _AnimatedIn(
                index: 0,
                child: Text(
                  'Manage Users',
                  style: TextStyle(
                    fontSize: size.width * 0.065,
                    fontWeight: FontWeight.bold,
                    color: AppColors.darkNavy,
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.015),
              _AnimatedIn(
                index: 1,
                child: TextField(
                  decoration: InputDecoration(
                    hintText: 'Search name or email',
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                    fillColor: AppColors.lightGrey,
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.015),
              _AnimatedIn(
                index: 2,
                child: Wrap(
                  spacing: 8,
                  children: [
                    _buildChip(0, 'All'),
                    _buildChip(1, 'Teachers'),
                    _buildChip(2, 'Students'),
                  ],
                ),
              ),
              SizedBox(height: size.height * 0.02),
              Expanded(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 250),
                  switchInCurve: Curves.easeOut,
                  switchOutCurve: Curves.easeIn,
                  child: ListView.separated(
                    key: ValueKey(_selectedFilter),
                    itemCount: _filteredUsers.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 10),
                    itemBuilder: (context, index) {
                      final user = _filteredUsers[index];
                      return _AnimatedIn(
                        index: index,
                        child: Container(
                          padding: EdgeInsets.all(size.width * 0.04),
                          decoration: BoxDecoration(
                            color: AppColors.lightGrey,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Row(
                            children: [
                              CircleAvatar(
                                backgroundColor: AppColors.darkNavy,
                                foregroundColor: AppColors.white,
                                child: Text(user['name']![0]),
                              ),
                              SizedBox(width: size.width * 0.04),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      user['name']!,
                                      style: TextStyle(
                                        fontWeight: FontWeight.w600,
                                        color: AppColors.darkNavy,
                                        fontSize: size.width * 0.04,
                                      ),
                                    ),
                                    Text(
                                      user['email']!,
                                      style: TextStyle(
                                        // ignore: deprecated_member_use
                                        color:
                                            AppColors.darkNavy.withOpacity(0.5),
                                        fontSize: size.width * 0.032,
                                      ),
                                    ),
                                    SizedBox(height: size.height * 0.005),
                                    Row(
                                      children: [
                                        _roleBadge(user['role']!),
                                        const SizedBox(width: 8),
                                        StatusBadge<String>(
                                          status: user['status']!,
                                          labelOf: (value) => value,
                                          colorOf: (value) =>
                                              value == 'Active'
                                                  ? AppColors.successGreen
                                                  : AppColors.alertRed,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              Icon(
                                Icons.more_vert,
                                color: AppColors.darkNavy.withOpacity(0.6),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildChip(int index, String label) {
    final bool isSelected = _selectedFilter == index;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      selectedColor: AppColors.skyBlue.withOpacity(0.15),
      labelStyle: TextStyle(
        color: isSelected ? AppColors.skyBlue : AppColors.darkNavy,
        fontWeight: FontWeight.w600,
      ),
      onSelected: (_) => setState(() => _selectedFilter = index),
    );
  }

  Widget _roleBadge(String role) {
    final color = role == 'Teacher' ? AppColors.skyBlue : AppColors.warningYellow;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        // ignore: deprecated_member_use
        color: color.withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        role,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.w600,
          fontSize: 12,
        ),
      ),
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
      duration: Duration(milliseconds: 250 + (index * 70)),
      curve: Curves.easeOut,
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, (1 - value) * 10),
            child: child,
          ),
        );
      },
      child: child,
    );
  }
}
