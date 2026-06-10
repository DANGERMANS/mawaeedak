import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

/// إدارة الصلاحيات - الأدمن
class AdminPermissionsScreen extends StatefulWidget {
  const AdminPermissionsScreen({super.key});

  @override
  State<AdminPermissionsScreen> createState() => _AdminPermissionsScreenState();
}

class _AdminPermissionsScreenState extends State<AdminPermissionsScreen> {
  final List<_PermissionItem> _permissions = [
    _PermissionItem(
      id: '1',
      name: 'المدير العام',
      permissions: ['all'],
      description: 'صلاحيات كاملة',
      color: AppColors.error,
    ),
    _PermissionItem(
      id: '2',
      name: 'المشرف',
      permissions: ['users', 'events', 'notifications'],
      description: 'إدارة المستخدمين والأحداث',
      color: const Color(0xFF7B68EE),
    ),
    _PermissionItem(
      id: '3',
      name: 'المحرر',
      permissions: ['content', 'news'],
      description: 'إدارة المحتوى والأخبار',
      color: AppColors.gold,
    ),
    _PermissionItem(
      id: '4',
      name: 'المستخدم',
      permissions: ['view'],
      description: 'عرض فقط',
      color: AppColors.brown,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إدارة الصلاحيات'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addPermission,
        backgroundColor: AppColors.gold,
        child: const Icon(Icons.add),
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(AppSpacing.md),
        itemCount: _permissions.length,
        itemBuilder: (context, index) {
          final permission = _permissions[index];
          return _PermissionCard(
            permission: permission,
            onEdit: () => _editPermission(permission),
            onDelete: () => _deletePermission(permission.id),
          );
        },
      ),
    );
  }

  void _addPermission() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('إضافة صلاحية جديدة')),
    );
  }

  void _editPermission(_PermissionItem permission) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('تعديل ${permission.name}')),
    );
  }

  void _deletePermission(String id) {
    setState(() => _permissions.removeWhere((p) => p.id == id));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('تم حذف الصلاحية')),
    );
  }
}

class _PermissionItem {
  final String id;
  final String name;
  final List<String> permissions;
  final String description;
  final Color color;

  const _PermissionItem({
    required this.id,
    required this.name,
    required this.permissions,
    required this.description,
    required this.color,
  });
}

class _PermissionCard extends StatelessWidget {
  final _PermissionItem permission;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _PermissionCard({
    required this.permission,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: permission.color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppRadius.md),
                  ),
                  child: Icon(Icons.security, color: permission.color),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(permission.name,
                          style: Theme.of(context).textTheme.titleMedium),
                      Text(permission.description,
                          style: Theme.of(context).textTheme.bodyMedium),
                    ],
                  ),
                ),
                PopupMenuButton<String>(
                  onSelected: (value) {
                    if (value == 'edit') onEdit();
                    if (value == 'delete') onDelete();
                  },
                  itemBuilder: (context) => [
                    const PopupMenuItem(value: 'edit', child: Text('تعديل')),
                    const PopupMenuItem(
                      value: 'delete',
                      child:
                          Text('حذف', style: TextStyle(color: AppColors.error)),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: permission.permissions.map((p) {
                return Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.sm,
                    vertical: 4,
                  ),
                  decoration: BoxDecoration(
                    color: permission.color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                  ),
                  child: Text(
                    p,
                    style: TextStyle(color: permission.color, fontSize: 12),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}