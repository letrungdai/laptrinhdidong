import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProfileScreen(),
    );
  }
}

class ProfileScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          child: Column(
            children: [
              // Hàng trên cùng chứa nút Back và Edit
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.black54),
                      onPressed: () {},
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey.shade300),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.edit_note, color: Colors.green),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 50),

              // --- SỬA Ở ĐÂY ---
              // Avatar hình tròn với ảnh của bạn
              const CircleAvatar(
                radius: 60,
                // Thay NetworkImage bằng AssetImage
                backgroundImage: AssetImage('assets/my_avatar.png'),
              ),

              // ----------------
              const SizedBox(height: 20),

              // Tên (Bạn có thể sửa tên mình ở đây luôn)
              const Text(
                'Johan Smith', // Sửa thành tên bạn nếu muốn
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),

              const SizedBox(height: 8),

              // Địa chỉ
              const Text(
                'California, USA', // Sửa thành địa chỉ bạn nếu muốn
                style: TextStyle(fontSize: 16, color: Colors.grey),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
