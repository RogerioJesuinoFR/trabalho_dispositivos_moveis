import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:imc_app/services/auth_service.dart';
import 'package:imc_app/services/image_service.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? _image;
  String? _email;

  @override
  void initState() {
    super.initState();
    _loadProfile();
  }

  Future<void> _loadProfile() async {
    final user = await AuthService.getCurrentUser();
    final box = await Hive.openBox('profileBox');

    if (user != null) {
      final imagePath = box.get(user['email']);
      setState(() {
        _email = user['email'];
        if (imagePath != null) {
          _image = File(imagePath);
        }
      });
    }
  }

  Future<void> _pickImage() async {
    final image = await ImageService.pickImage();
    if (image != null) {
      final box = await Hive.openBox('profileBox');
      await box.put(_email, image.path);

      setState(() {
        _image = image;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Perfil')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _image == null
                ? const CircleAvatar(
                    radius: 60,
                    child: Icon(Icons.person, size: 60),
                  )
                : CircleAvatar(
                    radius: 60,
                    backgroundImage: FileImage(_image!),
                  ),
            const SizedBox(height: 20),
            Text(
              _email ?? '',
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: _pickImage,
              icon: const Icon(Icons.camera_alt),
              label: const Text('Tirar Foto'),
            ),
          ],
        ),
      ),
    );
  }
}
