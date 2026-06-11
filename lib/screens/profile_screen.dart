import 'package:flutter/material.dart';
import '../core/theme.dart';
import '../services/user_service.dart';
import 'login.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _bioController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: UserService.instance.username);
    _emailController = TextEditingController(text: UserService.instance.email);
    _bioController = TextEditingController(text: UserService.instance.bio);
  }

  void _saveProfile() {
    UserService.instance.username = _nameController.text;
    UserService.instance.email = _emailController.text;
    UserService.instance.bio = _bioController.text;
    
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Profile updated successfully")),
    );
  }

  void _logout() {
    UserService.instance.clear();
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => const LoginScreen()),
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
        actions: [
          IconButton(
            icon: const Icon(Icons.check, color: AppTheme.primaryAccent),
            onPressed: _saveProfile,
          )
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            const CircleAvatar(
              backgroundImage: NetworkImage('data:image/jpeg;base64,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'),
              radius: 50
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _nameController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: "Name",
                labelStyle: const TextStyle(color: Colors.grey),
                filled: true,
                fillColor: AppTheme.cardColor,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _emailController,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: "Email",
                labelStyle: const TextStyle(color: Colors.grey),
                filled: true,
                fillColor: AppTheme.cardColor,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _bioController,
              maxLines: 3,
              style: const TextStyle(color: Colors.white),
              decoration: InputDecoration(
                labelText: "Bio (Additional Info)",
                labelStyle: const TextStyle(color: Colors.grey),
                filled: true,
                fillColor: AppTheme.cardColor,
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12), borderSide: BorderSide.none),
              ),
            ),
            const SizedBox(height: 48),
            ElevatedButton.icon(
              onPressed: _logout,
              icon: const Icon(Icons.logout, color: Colors.white),
              label: const Text("Logout"),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.redColor,
                minimumSize: const Size(double.infinity, 50),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
