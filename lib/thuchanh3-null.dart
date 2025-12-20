import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: UserProfileScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class UserProfileScreen extends StatefulWidget {
  const UserProfileScreen({super.key});

  @override
  State<UserProfileScreen> createState() => _UserProfileScreenState();
}

class _UserProfileScreenState extends State<UserProfileScreen> {
  // 1. Khai báo Nullable (?)
  // Tên bắt buộc (Non-nullable)
  String fullName = "Nguyễn Văn A";

  // Bio và Avatar có thể chưa có (Nullable)
  String? bio;
  String? avatarUrl;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Ví dụ Nullable Flutter")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // VÍ DỤ VỀ ?. và ??
            // Nếu avatarUrl null -> dùng Icon mặc định
            // Nếu có -> hiển thị ảnh
            CircleAvatar(
              radius: 50,
              backgroundColor: Colors.blue.shade100,
              // Sử dụng toán tử 3 ngôi (logic giống ?:)
              backgroundImage: avatarUrl != null
                  ? NetworkImage(avatarUrl!)
                  : null,
              child: avatarUrl == null
                  ? const Icon(Icons.person, size: 50, color: Colors.blue)
                  : null,
            ),

            const SizedBox(height: 20),

            Text(
              fullName,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            // VÍ DỤ VỀ ?? (Null-coalescing)
            // Nếu bio là null, hiển thị chuỗi mặc định bên phải
            Text(
              bio ?? "Người dùng này chưa cập nhật tiểu sử.",
              style: TextStyle(
                color: bio == null ? Colors.grey : Colors.black,
                fontStyle: bio == null ? FontStyle.italic : FontStyle.normal,
              ),
            ),

            const SizedBox(height: 30),

            // Nút mô phỏng lấy dữ liệu
            ElevatedButton(
              onPressed: () {
                setState(() {
                  // Giả lập dữ liệu trả về
                  bio = "Sinh viên UTH đam mê lập trình Flutter!";
                  avatarUrl =
                      "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg";
                });
              },
              child: const Text("Tải dữ liệu (Gán giá trị)"),
            ),

            const SizedBox(height: 10),

            // Nút Reset về Null
            OutlinedButton(
              onPressed: () {
                setState(() {
                  bio = null;
                  avatarUrl = null;
                });
              },
              child: const Text("Reset về Null"),
            ),

            const SizedBox(height: 20),

            // VÍ DỤ VỀ ! (Bang Operator)
            // Chỉ dùng khi CHẮC CHẮN biến không null
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.redAccent,
              ),
              onPressed: () {
                if (bio != null) {
                  // Dùng dấu ! để khẳng định bio chắc chắn có giá trị để in độ dài
                  print("Độ dài tiểu sử: ${bio!.length}");

                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Độ dài bio là: ${bio!.length} ký tự"),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Bio đang null, không thể dùng dấu !"),
                    ),
                  );
                }
              },
              child: const Text(
                "Thử dùng dấu ! (Bang Operator)",
                style: TextStyle(color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
