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
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // 1. Khai báo biến trạng thái để lưu nội dung hiển thị
  String _centerText = "Hello";

  // 2. Hàm xử lý sự kiện khi nhấn nút
  void _handleButtonPress() {
    setState(() {
      // Thay đổi nội dung biến text
      _centerText = "I'm\nNguyen Van A";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // SafeArea giúp nội dung không bị che bởi tai thỏ (notch) của iPhone
      body: SafeArea(
        child: Center(
          child: Column(
            // Căn chỉnh các phần tử cách đều nhau theo chiều dọc
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              // --- TextView 1: Tiêu đề ---
              const Text(
                'My First App',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),

              // --- TextView 2: Nội dung thay đổi ---
              Text(
                _centerText, // Sử dụng biến đã khai báo
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 20, color: Colors.black),
              ),

              // --- Button: Nút bấm ---
              ElevatedButton(
                onPressed: _handleButtonPress, // Gọi hàm khi nhấn
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue[800], // Màu nền xanh đậm
                  foregroundColor: Colors.white, // Màu chữ trắng
                  padding: const EdgeInsets.symmetric(
                    horizontal: 50,
                    vertical: 15,
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10), // Bo góc nút
                  ),
                ),
                child: const Text(
                  'Say Hi!',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
