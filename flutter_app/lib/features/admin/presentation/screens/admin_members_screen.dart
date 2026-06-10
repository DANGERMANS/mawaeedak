import 'package:flutter/material.dart';
import '../../../../core/theme/app_theme.dart';

/// إدارة الأعضاء - الأدمن
class AdminMembersScreen extends StatefulWidget {
  const AdminMembersScreen({super.key});

  @override
  State<AdminMembersScreen> createState() => _AdminMembersScreenState();
}

class _AdminMembersScreenState extends State<AdminMembersScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';

  final List<_MemberItem> _members = [
    _MemberItem(
      id: '1',
      name: 'أحمد محمد',
      email: 'ahmed@example.com',
      role: 'admin',
      status: 'active',
      joinDate: '2026-01-15',
    ),
    _MemberItem(
      id: '2',
      name: 'فاطمة علي',
      email: 'fatima@example.com',
      role: 'user',
      status: 'active',
      joinDate: '2026-02-20',
    ),
    _MemberItem(
      id: '3',
      name: 'محمد خالد',
      email: 'mohammed@example.com',
      role: 'user',
      status: 'inactive',
      joinDate: '2026-03-10',
    ),
    _MemberItem(
      id: '4',
      name: 'سارة أحمد',
      email: 'sara@example.com',
      role: 'moderator',
      status: 'active',
      joinDate: '2026-04-05',
    ),
  ];

  List<_MemberItem> get _filteredMembers {
    if (_searchQuery.isEmpty) return _members;
    return _members.where((m) =>
        m.name.toLowerCase().contains(_searchQuery.toLowerCase()) ||
        m.email.toLowerCase().contains(_searchQuery.toLowerCase())).toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('إدارة الأعضاء'),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _addMember,
        backgroundColor: AppColors.gold,
        child: const Icon(Icons.person_add),
      ),
      body: Column(
        children: [
          // Search
          Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'البحث عن عضو...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: _searchQuery.isNotEmpty
                    ? IconButton(
                        icon: const Icon(Icons.clear),
                        onPressed: () {
                          _searchController.clear();
                          setState(() => _searchQuery = '');
                        },
                      )
                    : null,
              ),
              onChanged: (value) => setState(() => _searchQuery = value),
            ),
          ),

          // Members List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
              itemCount: _filteredMembers.length,
              itemBuilder: (context, index) {
                final member = _filteredMembers[index];
                return _MemberCard(
                  member: member,
                  onEdit: () => _editMember(member),
                  onDelete: () => _deleteMember(member.id),
                  onToggleStatus: () => _toggleStatus(member.id),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _addMember() {
    _showMemberForm();
  }

  void _editMember(_MemberItem member) {
    _showMemberForm(member: member);
  }

  void _deleteMember(String id) {
    setState(() {
      _members.removeWhere((m) => m.id == id);
    });
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('تم حذف العضو'),
        backgroundColor: AppColors.error,
      ),
    );
  }

  void _toggleStatus(String id) {
    setState(() {
      final index = _members.indexWhere((m) => m.id == id);
      if (index != -1) {
        _members[index] = _MemberItem(
          id: _members[index].id,
          name: _members[index].name,
          email: _members[index].email,
          role: _members[index].role,
          status: _members[index].status == 'active' ? 'inactive' : 'active',
          joinDate: _members[index].joinDate,
        );
      }
    });
  }

  void _showMemberForm({_MemberItem? member}) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) => _MemberFormSheet(member: member),
    );
  }
}

class _MemberItem {
  final String id;
  final String name;
  final String email;
  final String role;
  final String status;
  final String joinDate;

  const _MemberItem({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.status,
    required this.joinDate,
  });
}

class _MemberCard extends StatelessWidget {
  final _MemberItem member;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback onToggleStatus;

  const _MemberCard({
    required this.member,
    required this.onEdit,
    required this.onDelete,
    required this.onToggleStatus,
  });

  Color get _roleColor {
    switch (member.role) {
      case 'admin':
        return AppColors.error;
      case 'moderator':
        return const Color(0xFF7B68EE);
      default:
        return AppColors.brown;
    }
  }

  String get _roleLabel {
    switch (member.role) {
      case 'admin':
        return 'مدير';
      case 'moderator':
        return 'مشرف';
      default:
        return 'مستخدم';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: AppColors.gold.withOpacity(0.1),
              child: Text(
                member.name[0],
                style: const TextStyle(
                  color: AppColors.gold,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    member.name,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  Text(
                    member.email,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.sm,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: _roleColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(AppRadius.sm),
                        ),
                        child: Text(
                          _roleLabel,
                          style: TextStyle(color: _roleColor, fontSize: 12),
                        ),
                      ),
                      const SizedBox(width: AppSpacing.sm),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppSpacing.sm,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: member.status == 'active'
                              ? AppColors.success.withOpacity(0.1)
                              : AppColors.error.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(AppRadius.sm),
                        ),
                        child: Text(
                          member.status == 'active' ? 'نشط' : 'غير نشط',
                          style: TextStyle(
                            color: member.status == 'active'
                                ? AppColors.success
                                : AppColors.error,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            PopupMenuButton<String>(
              onSelected: (value) {
                switch (value) {
                  case 'edit':
                    onEdit();
                    break;
                  case 'status':
                    onToggleStatus();
                    break;
                  case 'delete':
                    onDelete();
                    break;
                }
              },
              itemBuilder: (context) => [
                const PopupMenuItem(value: 'edit', child: Text('تعديل')),
                PopupMenuItem(
                  value: 'status',
                  child: Text(member.status == 'active' ? 'تعطيل' : 'تفعيل'),
                ),
                const PopupMenuItem(
                  value: 'delete',
                  child: Text('حذف', style: TextStyle(color: AppColors.error)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _MemberFormSheet extends StatefulWidget {
  final _MemberItem? member;

  const _MemberFormSheet({this.member});

  @override
  State<_MemberFormSheet> createState() => _MemberFormSheetState();
}

class _MemberFormSheetState extends State<_MemberFormSheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _emailController;
  String _selectedRole = 'user';

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.member?.name);
    _emailController = TextEditingController(text: widget.member?.email);
    _selectedRole = widget.member?.role ?? 'user';
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Form(
          key: _formKey,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                widget.member == null ? 'إضافة عضو' : 'تعديل عضو',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: AppSpacing.lg),
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'الاسم'),
                validator: (v) => v?.isEmpty == true ? 'مطلوب' : null,
              ),
              const SizedBox(height: AppSpacing.md),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(labelText: 'البريد الإلكتروني'),
                keyboardType: TextInputType.emailAddress,
                validator: (v) {
                  if (v?.isEmpty == true) return 'مطلوب';
                  if (!v!.contains('@')) return 'بريد غير صحيح';
                  return null;
                },
              ),
              const SizedBox(height: AppSpacing.md),
              DropdownButtonFormField<String>(
                value: _selectedRole,
                decoration: const InputDecoration(labelText: 'الصلاحية'),
                items: const [
                  DropdownMenuItem(value: 'user', child: Text('مستخدم')),
                  DropdownMenuItem(value: 'moderator', child: Text('مشرف')),
                  DropdownMenuItem(value: 'admin', child: Text('مدير')),
                ],
                onChanged: (v) => setState(() => _selectedRole = v!),
              ),
              const SizedBox(height: AppSpacing.lg),
              ElevatedButton(
                onPressed: _submit,
                child: Text(widget.member == null ? 'إضافة' : 'حفظ'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('تم حفظ العضو'),
          backgroundColor: AppColors.success,
        ),
      );
    }
  }
}