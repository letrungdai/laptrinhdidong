import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'UI Components',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          foregroundColor: Colors.blue,
          elevation: 0,
          centerTitle: true,
          titleTextStyle: TextStyle(
            color: Colors.blue,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
          iconTheme: IconThemeData(color: Colors.blue),
        ),
      ),
      home: const MenuScreen(),
    );
  }
}

// ======================= 1. MÀN HÌNH MENU CHÍNH =======================
class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("UI Components List")),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildHeader("Display"),
          _buildNavButton(
            context,
            "Text",
            "Displays text",
            const TextDetailScreen(),
          ),
          _buildNavButton(
            context,
            "Image",
            "Displays an image",
            const ImageDetailScreen(),
          ),

          const SizedBox(height: 20),
          _buildHeader("Input"),
          _buildNavButton(
            context,
            "TextField",
            "Input field for text",
            const TextFieldScreen(),
          ),
          _buildNavButton(
            context,
            "PasswordField",
            "Input field for passwords",
            const TextFieldScreen(isPassword: true),
          ),

          const SizedBox(height: 20),
          _buildHeader("Layout"),
          _buildNavButton(
            context,
            "Column",
            "Arranges elements vertically",
            const ColumnLayoutScreen(),
          ),
          _buildNavButton(
            context,
            "Row",
            "Arranges elements horizontally",
            const RowLayoutScreen(),
          ),

          const SizedBox(height: 20),
          // --- NÚT ĐẶC BIỆT "TỰ TÌM HIỂU" (ĐÃ SỬA) ---
          Container(
            decoration: BoxDecoration(
              color: const Color(0xFFF8D7DA), // Màu hồng nhạt
              borderRadius: BorderRadius.circular(10),
            ),
            child: ListTile(
              title: const Text(
                "Tự tìm hiểu",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF721C24),
                ),
              ),
              subtitle: const Text(
                "Buttons, Switch, Checkbox, Slider...",
                style: TextStyle(color: Color(0xFF721C24)),
              ),
              // --- SỬA LOGIC ONTAP TẠI ĐÂY ---
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const ExtraUIScreen(),
                  ),
                );
              },
              // ------------------------------
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        title,
        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
      ),
    );
  }

  Widget _buildNavButton(
    BuildContext context,
    String title,
    String sub,
    Widget page,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: const Color(0xFFBBDEFB),
        borderRadius: BorderRadius.circular(10),
      ),
      child: ListTile(
        title: Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        subtitle: Text(sub),
        trailing: const Icon(
          Icons.arrow_forward_ios,
          size: 16,
          color: Colors.blue,
        ),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page),
          );
        },
      ),
    );
  }
}

// ======================= 2. MÀN HÌNH TEXT DETAIL =======================
class TextDetailScreen extends StatelessWidget {
  const TextDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Text Detail")),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: RichText(
            textAlign: TextAlign.center,
            text: const TextSpan(
              style: TextStyle(fontSize: 28, color: Colors.black),
              children: [
                TextSpan(text: "The quick "),
                TextSpan(
                  text: "Brown",
                  style: TextStyle(
                    color: Colors.orange,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(text: "\nfox j u m p s "),
                TextSpan(
                  text: "over",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                TextSpan(text: "\nthe "),
                TextSpan(
                  text: "lazy dog.",
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ======================= 3. MÀN HÌNH IMAGES =======================
class ImageDetailScreen extends StatelessWidget {
  const ImageDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Images")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              "Ảnh từ Assets (Trong máy)",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                'assets/logo.png',
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 200,
                    width: double.infinity,
                    color: Colors.grey[300],
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: const [
                        Icon(Icons.warning, size: 40, color: Colors.orange),
                        SizedBox(height: 8),
                        Text(
                          "Chưa tìm thấy file 'assets/logo.png'",
                          textAlign: TextAlign.center,
                        ),
                        Text(
                          "Hãy xem lại Bước 1 & 2 hướng dẫn",
                          style: TextStyle(fontSize: 12),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 8),
            const Text(
              "Đường dẫn: assets/logo.png",
              style: TextStyle(fontSize: 12, color: Colors.blue),
            ),
            const SizedBox(height: 30),
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                'assets/banner.jpg',
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    height: 200,
                    width: double.infinity,
                    color: Colors.grey[200],
                    child: const Center(
                      child: Text("Vị trí cho ảnh thứ 2 (assets/banner.jpg)"),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 8),
            const Text("In app", style: TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }
}

// ======================= 4. MÀN HÌNH TEXTFIELD =======================
class TextFieldScreen extends StatefulWidget {
  final bool isPassword;
  const TextFieldScreen({Key? key, this.isPassword = false}) : super(key: key);

  @override
  State<TextFieldScreen> createState() => _TextFieldScreenState();
}

class _TextFieldScreenState extends State<TextFieldScreen> {
  String _displayText = "Tự động cập nhật dữ liệu theo textfield";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.isPassword ? "PasswordField" : "TextField"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            const SizedBox(height: 50),
            TextField(
              obscureText: widget.isPassword,
              decoration: InputDecoration(
                hintText: widget.isPassword
                    ? "Nhập mật khẩu"
                    : "Thông tin nhập",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
              ),
              onChanged: (text) {
                setState(() {
                  _displayText = text.isEmpty
                      ? "Tự động cập nhật dữ liệu theo textfield"
                      : text;
                });
              },
            ),
            const SizedBox(height: 30),
            if (!widget.isPassword)
              Text(
                _displayText,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.red,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// ======================= 5. MÀN HÌNH ROW LAYOUT =======================
class RowLayoutScreen extends StatelessWidget {
  const RowLayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Row Layout")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            crossAxisSpacing: 15,
            mainAxisSpacing: 15,
            childAspectRatio: 1.5,
          ),
          itemCount: 12,
          itemBuilder: (context, index) {
            return Container(
              decoration: BoxDecoration(
                color: index % 2 == 0
                    ? const Color(0xFF82B1FF)
                    : const Color(0xFF448AFF),
                borderRadius: BorderRadius.circular(10),
              ),
            );
          },
        ),
      ),
    );
  }
}

// ======================= 6. MÀN HÌNH COLUMN LAYOUT =======================
class ColumnLayoutScreen extends StatelessWidget {
  const ColumnLayoutScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Column Layout")),
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildBox(Colors.blue),
            _buildBox(Colors.blue[300]!),
            _buildBox(Colors.blue[100]!),
          ],
        ),
      ),
    );
  }

  Widget _buildBox(Color color) {
    return Container(
      width: 100,
      height: 100,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }
}

// ======================= 7. MÀN HÌNH TỰ TÌM HIỂU (MỚI THÊM) =======================
class ExtraUIScreen extends StatefulWidget {
  const ExtraUIScreen({Key? key}) : super(key: key);

  @override
  State<ExtraUIScreen> createState() => _ExtraUIScreenState();
}

class _ExtraUIScreenState extends State<ExtraUIScreen> {
  // Biến trạng thái
  bool _isSwitched = false;
  bool _isChecked = false;
  double _sliderValue = 20;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("More UI Components")),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- BUTTONS ---
            const Text(
              "1. Buttons (Nút bấm)",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            const SizedBox(height: 10),
            Center(
              child: Wrap(
                spacing: 10,
                children: [
                  ElevatedButton(
                    onPressed: () =>
                        _showSnackBar("Bạn vừa bấm ElevatedButton!"),
                    child: const Text("Elevated"),
                  ),
                  OutlinedButton(
                    onPressed: () =>
                        _showSnackBar("Bạn vừa bấm OutlinedButton!"),
                    child: const Text("Outlined"),
                  ),
                  TextButton(
                    onPressed: () => _showSnackBar("Bạn vừa bấm TextButton!"),
                    child: const Text("Text Only"),
                  ),
                ],
              ),
            ),

            const Divider(height: 40, thickness: 2),

            // --- SWITCH & CHECKBOX ---
            const Text(
              "2. Selection Controls",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            SwitchListTile(
              title: const Text("Chế độ ban đêm"),
              subtitle: Text(_isSwitched ? "Đang BẬT" : "Đang TẮT"),
              value: _isSwitched,
              onChanged: (bool value) {
                setState(() => _isSwitched = value);
              },
            ),
            CheckboxListTile(
              title: const Text("Đồng ý điều khoản"),
              value: _isChecked,
              onChanged: (bool? value) {
                setState(() => _isChecked = value ?? false);
              },
            ),

            const Divider(height: 40, thickness: 2),

            // --- SLIDER ---
            const Text(
              "3. Slider",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            Slider(
              value: _sliderValue,
              min: 0,
              max: 100,
              divisions: 10,
              label: _sliderValue.round().toString(),
              onChanged: (double value) {
                setState(() => _sliderValue = value);
              },
            ),
            Center(
              child: Text(
                "Giá trị: ${_sliderValue.round()}",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 1),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }
}
