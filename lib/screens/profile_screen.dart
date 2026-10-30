import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_styles.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Header
              Container(
                width: double.infinity,
                color: Colors.white,
                padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                child: Column(
                  children: [
                    const Text(
                      'Profil',
                      style: TextStyle(
                        fontFamily: AppStyles.fontFamily,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Avatar
                    Container(
                      width: 90,
                      height: 90,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                          colors: [AppColors.primary, AppColors.primaryDark],
                        ),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: AppColors.primary.withValues(alpha: 0.4),
                            blurRadius: 16,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: const Icon(Icons.person_rounded,
                          size: 48, color: Colors.white),
                    ),
                    const SizedBox(height: 14),
                    const Text(
                      'Ahmad',
                      style: TextStyle(
                        fontFamily: AppStyles.fontFamily,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: AppColors.textPrimary,
                      ),
                    ),
                    const SizedBox(height: 4),
                    const Text(
                      'ahmad@email.com',
                      style: TextStyle(
                        fontFamily: AppStyles.fontFamily,
                        fontSize: 14,
                        color: AppColors.textSecondary,
                      ),
                    ),
                    const SizedBox(height: 16),
                    OutlinedButton.icon(
                      onPressed: () {},
                      icon: const Icon(Icons.edit_rounded,
                          size: 16, color: AppColors.primary),
                      label: const Text(
                        'Edit Profil',
                        style: TextStyle(
                          fontFamily: AppStyles.fontFamily,
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: AppColors.primary,
                        ),
                      ),
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: AppColors.primary),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 8),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10)),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 12),

              // Stats row
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  children: [
                    _statCard(
                      icon: Icons.note_rounded,
                      value: '5',
                      label: 'Catatan',
                      color: AppColors.primary,
                      bgColor: AppColors.primaryLight,
                    ),
                    const SizedBox(width: 12),
                    _statCard(
                      icon: Icons.archive_rounded,
                      value: '0',
                      label: 'Diarsipkan',
                      color: AppColors.warning,
                      bgColor: const Color(0xFFFEF3C7),
                    ),
                    const SizedBox(width: 12),
                    _statCard(
                      icon: Icons.star_rounded,
                      value: '1',
                      label: 'Penting',
                      color: AppColors.error,
                      bgColor: const Color(0xFFFEE2E2),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 16),

              // Menu
              _menuGroup(context, [
                _menuItem(
                  icon: Icons.notifications_outlined,
                  label: 'Notifikasi',
                  onTap: () {},
                ),
                _menuItem(
                  icon: Icons.color_lens_outlined,
                  label: 'Tema',
                  onTap: () {},
                ),
                _menuItem(
                  icon: Icons.language_rounded,
                  label: 'Bahasa',
                  trailing: const Text(
                    'Indonesia',
                    style: TextStyle(
                      fontFamily: AppStyles.fontFamily,
                      fontSize: 13,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  onTap: () {},
                ),
                _menuItem(
                  icon: Icons.backup_outlined,
                  label: 'Cadangkan Data',
                  onTap: () {},
                ),
                _menuItem(
                  icon: Icons.help_outline_rounded,
                  label: 'Bantuan',
                  onTap: () {},
                  showDivider: false,
                ),
              ]),

              const SizedBox(height: 16),

              // Logout
              _menuGroup(context, [
                _menuItem(
                  icon: Icons.logout_rounded,
                  label: 'Keluar',
                  iconColor: AppColors.error,
                  textColor: AppColors.error,
                  showArrow: false,
                  showDivider: false,
                  onTap: () => _showLogoutDialog(context),
                ),
              ]),

              const SizedBox(height: 16),

              const Text(
                'CatatanKu v1.0.0',
                style: TextStyle(
                  fontFamily: AppStyles.fontFamily,
                  fontSize: 12,
                  color: AppColors.textHint,
                ),
              ),

              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Keluar',
            style: TextStyle(
                fontFamily: AppStyles.fontFamily,
                fontWeight: FontWeight.w600)),
        content: const Text('Apakah kamu yakin ingin keluar?',
            style: TextStyle(fontFamily: AppStyles.fontFamily)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Batal',
                style: TextStyle(
                    fontFamily: AppStyles.fontFamily,
                    color: AppColors.textSecondary)),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(ctx);
              Navigator.pushReplacementNamed(context, '/login');
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
            child: const Text('Keluar',
                style: TextStyle(
                    fontFamily: AppStyles.fontFamily, color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _menuGroup(BuildContext context, List<Widget> children) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(children: children),
    );
  }

  Widget _statCard({
    required IconData icon,
    required String value,
    required String label,
    required Color color,
    required Color bgColor,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(height: 8),
            Text(value,
                style: TextStyle(
                  fontFamily: AppStyles.fontFamily,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: color,
                )),
            Text(label,
                style: const TextStyle(
                  fontFamily: AppStyles.fontFamily,
                  fontSize: 11,
                  color: AppColors.textSecondary,
                )),
          ],
        ),
      ),
    );
  }

  Widget _menuItem({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
    Color? iconColor,
    Color? textColor,
    Widget? trailing,
    bool showArrow = true,
    bool showDivider = true,
  }) {
    return Column(
      children: [
        ListTile(
          onTap: onTap,
          leading: Container(
            width: 36,
            height: 36,
            decoration: BoxDecoration(
              color: (iconColor ?? AppColors.primary).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 20, color: iconColor ?? AppColors.primary),
          ),
          title: Text(
            label,
            style: TextStyle(
              fontFamily: AppStyles.fontFamily,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: textColor ?? AppColors.textPrimary,
            ),
          ),
          trailing: trailing ??
              (showArrow
                  ? const Icon(Icons.chevron_right_rounded,
                      color: AppColors.textSecondary, size: 20)
                  : null),
          contentPadding:
              const EdgeInsets.symmetric(horizontal: 16, vertical: 2),
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12)),
        ),
        if (showDivider)
          const Divider(
              height: 1,
              indent: 68,
              endIndent: 16,
              color: AppColors.divider),
      ],
    );
  }
}
