import 'package:flutter/material.dart';
import 'auth_service(tuan7).dart';
import 'profile_screen(tuan7).dart';

class LoginScreen extends StatelessWidget {
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Logo (Dùng Icon hoặc Image)
              Container(
                height: 120,
                width: 120,
                decoration: BoxDecoration(
                  color: Colors.blue.shade50,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "UTH",
                      style: TextStyle(
                        fontSize: 30,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal,
                      ),
                    ),
                    Text(
                      "UNIVERSITY",
                      style: TextStyle(fontSize: 10, color: Colors.teal),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20),
              Text(
                "SmartTasks",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
              SizedBox(height: 40),
              Text(
                "Welcome",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Text(
                "Ready to explore? Log in to get started.",
                style: TextStyle(color: Colors.grey),
              ),
              SizedBox(height: 40),

              // Nút Đăng nhập Google
              ElevatedButton.icon(
                onPressed: () async {
                  // Gọi hàm đăng nhập
                  final user = await _authService.signInWithGoogle();
                  if (user != null) {
                    // Thông báo thành công
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "Đăng nhập thành công: ${user.displayName}",
                        ),
                      ),
                    );
                    // Điều hướng sang trang Profile
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfileScreen(user: user),
                      ),
                    );
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text("Đăng nhập thất bại!")),
                    );
                  }
                },
                icon: Icon(
                  Icons.login,
                  color: Colors.blue,
                ), // Thay bằng icon Google nếu có asset
                label: Text(
                  "SIGN IN WITH GOOGLE",
                  style: TextStyle(color: Colors.blue),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  side: BorderSide(color: Colors.grey.shade300),
                  padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
                  minimumSize: Size(double.infinity, 50),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
