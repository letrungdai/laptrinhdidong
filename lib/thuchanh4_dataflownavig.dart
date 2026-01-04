import 'package:flutter/material.dart';

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ForgotPasswordScreen(), // Màn hình đầu tiên
    ),
  );
}

// ==========================================
// MÀN HÌNH 1: FORGOT PASSWORD
// Nhiệm vụ: Nhập Email -> Chuyền Email sang màn 2
// ==========================================
class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  // Controller để lấy dữ liệu từ ô nhập liệu
  final TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Logo giả lập (thay bằng Image.asset nếu muốn)
            const Icon(Icons.school, size: 80, color: Colors.blue),
            const SizedBox(height: 20),
            const Text(
              "UTH SmartTasks",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 30),

            const Text(
              "Forgot Password?",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const Text(
              "Enter your Email, we will send you a verification code.",
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            // Ô nhập Email
            TextField(
              controller: _emailController,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.email_outlined),
                hintText: "Your Email",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 20),

            // Nút Next
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                onPressed: () {
                  // Lấy dữ liệu email
                  String email = _emailController.text;

                  // CHUYỂN MÀN HÌNH VÀ TRUYỀN DỮ LIỆU (DATA FLOW)
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          VerifyCodeScreen(email: email), // Truyền email vào
                    ),
                  );
                },
                child: const Text(
                  "Next",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// MÀN HÌNH 2: VERIFY CODE
// Nhiệm vụ: Nhận Email, Nhập Code -> Chuyền (Email + Code) sang màn 3
// ==========================================
class VerifyCodeScreen extends StatelessWidget {
  // Khai báo biến để nhận dữ liệu từ màn hình trước
  final String email;

  // Constructor bắt buộc phải có email
  VerifyCodeScreen({super.key, required this.email});

  final TextEditingController _codeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.school, size: 60, color: Colors.blue),
            const Text(
              "UTH SmartTasks",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 30),

            const Text(
              "Verify Code",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            // Hiển thị email đã nhận được để người dùng kiểm tra
            Text(
              "Enter the code we just sent to $email",
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            // Ô nhập Code (đơn giản hóa thành 1 ô thay vì 5 ô nhỏ)
            TextField(
              controller: _codeController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Enter Code (e.g. 12345)",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                onPressed: () {
                  String code = _codeController.text;

                  // Truyền tiếp cả Email và Code sang màn hình 3
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          ResetPasswordScreen(email: email, code: code),
                    ),
                  );
                },
                child: const Text(
                  "Next",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// MÀN HÌNH 3: RESET PASSWORD
// Nhiệm vụ: Nhận (Email + Code), Nhập Pass -> Chuyền tất cả sang màn 4
// ==========================================
class ResetPasswordScreen extends StatelessWidget {
  final String email;
  final String code;

  const ResetPasswordScreen({
    super.key,
    required this.email,
    required this.code,
  });

  @override
  Widget build(BuildContext context) {
    // Controller cho mật khẩu
    final TextEditingController passController = TextEditingController();
    final TextEditingController confirmPassController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.school, size: 60, color: Colors.blue),
            const Text(
              "UTH SmartTasks",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 30),

            const Text(
              "Create new password",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const Text(
              "Your new password must be different from previously used password",
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),

            TextField(
              controller: passController,
              obscureText: true, // Ẩn mật khẩu
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.lock_outline),
                hintText: "Password",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: confirmPassController,
              obscureText: true,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.lock_outline),
                hintText: "Confirm Password",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
            ),
            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                onPressed: () {
                  String password = passController.text;

                  // Truyền TẤT CẢ dữ liệu sang màn hình cuối cùng để xác nhận
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ConfirmScreen(
                        email: email,
                        code: code,
                        password: password,
                      ),
                    ),
                  );
                },
                child: const Text(
                  "Next",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// MÀN HÌNH 4: CONFIRMATION (VERIFICATION)
// Nhiệm vụ: Hiển thị lại toàn bộ dữ liệu đã nhận được
// ==========================================
class ConfirmScreen extends StatelessWidget {
  final String email;
  final String code;
  final String password;

  const ConfirmScreen({
    super.key,
    required this.email,
    required this.code,
    required this.password,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackButton(color: Colors.black),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.school, size: 60, color: Colors.blue),
            const Text(
              "UTH SmartTasks",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
            const SizedBox(height: 30),

            const Text(
              "Confirm",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const Text("We are here to help you!", textAlign: TextAlign.center),
            const SizedBox(height: 30),

            // Hiển thị các dữ liệu đã nhận được (Read-only)
            _buildInfoCard(Icons.email, email),
            const SizedBox(height: 10),
            _buildInfoCard(Icons.numbers, code),
            const SizedBox(height: 10),
            _buildInfoCard(Icons.lock, password),

            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
                onPressed: () {
                  // LỆNH QUAY VỀ MÀN HÌNH A (Làm mới lại từ đầu)
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ForgotPasswordScreen(),
                    ), // Quay về màn A
                    (route) =>
                        false, // Xóa sạch lịch sử (B, C, D sẽ bị xóa khỏi bộ nhớ)
                  );
                },
                child: const Text(
                  "Submit (Back to Home)",
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget phụ để hiển thị thông tin cho đẹp
  Widget _buildInfoCard(IconData icon, String text) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.grey),
          const SizedBox(width: 15),
          Text(text, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
