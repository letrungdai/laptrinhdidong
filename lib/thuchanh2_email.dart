import 'package:flutter/material.dart';

class Practice2EmailScreen extends StatefulWidget {
  const Practice2EmailScreen({super.key});

  @override
  State<Practice2EmailScreen> createState() => _Practice2EmailScreenState();
}

class _Practice2EmailScreenState extends State<Practice2EmailScreen> {
  // Controller để quản lý nội dung nhập
  final TextEditingController _emailController = TextEditingController();

  // Biến để lưu thông báo (lỗi hoặc thành công)
  String? _message;
  Color _messageColor = Colors.red; // Mặc định là màu đỏ

  void _checkEmail() {
    // Lấy nội dung từ ô nhập
    String email = _emailController.text;

    setState(() {
      if (email.isEmpty) {
        // Trường hợp 1: Rỗng
        _message = "Email không hợp lệ";
        _messageColor = Colors.red;
      } else if (!email.contains('@')) {
        // Trường hợp 2: Không chứa ký tự @
        _message = "Email không đúng định dạng";
        _messageColor = Colors.red;
      } else {
        // Trường hợp 3: Hợp lệ
        _message = "Bạn đã nhập email hợp lệ";
        _messageColor = Colors.green; // Đổi màu xanh cho thông báo thành công
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // AppBar đơn giản màu trắng giống thiết kế
      appBar: AppBar(
        title: const Text("Email", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(height: 40),

            // Tiêu đề "Thực hành 02"
            const Text(
              "Thực hành 02",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 30),

            // Ô nhập Email
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                hintText: "Email",
                hintStyle: TextStyle(color: Colors.grey[400]),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: const BorderSide(color: Colors.grey),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 15,
                ),
              ),
            ),

            // Khu vực hiển thị thông báo lỗi/thành công
            // Chỉ hiện khi _message khác null (có nội dung)
            if (_message != null)
              Padding(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                child: Row(
                  children: [
                    Text(
                      _message!,
                      style: TextStyle(
                        color: _messageColor,
                        // In đậm nếu là thông báo thành công cho nổi bật
                        fontWeight: _messageColor == Colors.green
                            ? FontWeight.bold
                            : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),

            const SizedBox(height: 20),

            // Nút Kiểm tra
            SizedBox(
              width: double.infinity, // Nút rộng full màn hình
              child: ElevatedButton(
                onPressed: _checkEmail,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue, // Màu nền xanh
                  foregroundColor: Colors.white, // Màu chữ trắng
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      25,
                    ), // Bo tròn nhiều như hình
                  ),
                ),
                child: const Text(
                  "Kiểm tra",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
