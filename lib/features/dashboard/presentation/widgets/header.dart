import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:masareefi/core/theming/colors.dart';

import '../../logic/dashboard_states.dart';

class DashboardHeader extends StatelessWidget {
  final DashboardLoaded state;
  final Function(String) onFilterChanged;
  final VoidCallback onLogoutTapped;

  const DashboardHeader({
    super.key,
    required this.state,
    required this.onFilterChanged,
    required this.onLogoutTapped,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 190.h,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.mainColor,
            AppColors.secondaryColor,
          ],
        ),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10.r),
          bottomRight: Radius.circular(10.r),
        ),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
        child: Column(
          children: [
            SizedBox(height: 8.h),
            // Header Row
            Row(
              children: [
                // Profile Image
                _buildProfileImage(),

                SizedBox(width: 8.w),

                // Welcome Text
                Expanded(
                  child: _buildWelcomeText(),
                ),

                // Filter Dropdown
                _buildFilterDropdown(),

                SizedBox(width: 8.w),

                // Direct Logout Button
                _buildLogoutButton(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileImage() {
    return Container(
      width: 42.w,
      height: 42.h,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
      ),
      child: ClipOval(
        child: Image.network(
          'https://images.unsplash.com/photo-1507003211169-0a1dd7228f2d?w=100&h=100&fit=crop&crop=face',
          fit: BoxFit.cover,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.2),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.person,
                color: Colors.white,
                size: 20.sp,
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildWelcomeText() {
    return Text(
      'أهلاً بك',
      style: TextStyle(
        fontSize: 14.sp,
        color: Colors.white,
        fontWeight: FontWeight.w500,
      ),
    );
  }

  Widget _buildFilterDropdown() {
    return Container(
      width: 100.w,
      height: 30.h,
      padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 1.h),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(8.r),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: state.selectedFilter,
          style: TextStyle(
            fontSize: 11.sp,
            color: Colors.white,
            fontWeight: FontWeight.w500,
          ),
          dropdownColor: AppColors.mainColor,
          icon: Icon(
            Icons.keyboard_arrow_down,
            size: 14.sp,
            color: Colors.white,
          ),
          items: [
            'هذا الشهر',
            'آخر 7 أيام',
            'هذا العام',
          ].map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(
                value,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 11.sp,
                ),
              ),
            );
          }).toList(),
          onChanged: (String? newValue) {
            if (newValue != null) {
              onFilterChanged(newValue);
            }
          },
        ),
      ),
    );
  }

  Widget _buildLogoutButton() {
    return GestureDetector(
      onTap: onLogoutTapped,
      child: Container(
        width: 40.w,
        height: 30.h,
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.2),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Icon(
          Icons.logout_rounded,
          color: Colors.white,
          size: 16.sp,
        ),
      ),
    );
  }
}
