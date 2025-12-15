import 'package:flutter/material.dart';

class Practice3Screen extends StatefulWidget {
  const Practice3Screen({super.key});

  @override
  State<Practice3Screen> createState() => _Practice3ScreenState();
}

class _Practice3ScreenState extends State<Practice3Screen> {
  // Controller để lấy dữ liệu từ 2 ô nhập
  final TextEditingController _controller1 = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();

  // Biến lưu kết quả
  double? _result;
  String _errorText = "";

  // Hàm tính toán chung
  void _calculate(String operator) {
    // 1. Lấy dữ liệu từ 2 ô
    String text1 = _controller1.text;
    String text2 = _controller2.text;

    // 2. Validate (Kiểm tra dữ liệu)
    if (text1.isEmpty || text2.isEmpty) {
      setState(() {
        _errorText = "Vui lòng nhập đủ 2 số";
        _result = null;
      });
      return;
    }

    // Chuyển sang số thực (double)
    double num1 = double.tryParse(text1) ?? 0;
    double num2 = double.tryParse(text2) ?? 0;
    double tempResult = 0;

    // 3. Thực hiện phép tính
    setState(() {
      _errorText = ""; // Xóa lỗi cũ
      switch (operator) {
        case '+':
          tempResult = num1 + num2;
          break;
        case '-':
          tempResult = num1 - num2;
          break;
        case '*':
          tempResult = num1 * num2;
          break;
        case '/':
          if (num2 == 0) {
            _errorText = "Không thể chia cho 0";
            _result = null;
            return;
          }
          tempResult = num1 / num2;
          break;
      }
      _result = tempResult;
    });
  }

  // Widget vẽ cái nút hình vuông màu sắc cho gọn code
  Widget _buildButton(String label, Color color, VoidCallback onPressed) {
    return Container(
      width: 60,
      height: 60,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(12),
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Calculator"), elevation: 0),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start, // Căn lề trái
          children: [
            // Ảnh logo (nếu có) hoặc tiêu đề
            const Center(
              child: Text(
                "Thực hành 03",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(height: 30),

            // Ô nhập số 1
            TextField(
              controller: _controller1,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Nhập số thứ nhất (a)",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 15,
                ),
              ),
            ),

            const SizedBox(height: 20),

            // Ô nhập số 2
            TextField(
              controller: _controller2,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "Nhập số thứ hai (b)",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                ),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 15,
                ),
              ),
            ),

            const SizedBox(height: 30),

            // Hàng chứa 4 nút phép tính
            Row(
              mainAxisAlignment:
                  MainAxisAlignment.spaceAround, // Căn đều các nút
              children: [
                _buildButton("+", Colors.red, () => _calculate('+')),
                _buildButton(
                  "-",
                  Colors.orange,
                  () => _calculate('-'),
                ), // Vàng cam cho dễ nhìn
                _buildButton("*", Colors.blue, () => _calculate('*')),
                _buildButton("/", Colors.black, () => _calculate('/')),
              ],
            ),

            const SizedBox(height: 30),

            // Khu vực hiển thị kết quả
            const Text(
              "Kết quả:",
              style: TextStyle(fontSize: 18, color: Colors.black54),
            ),

            const SizedBox(height: 10),

            if (_errorText.isNotEmpty)
              Text(
                _errorText,
                style: const TextStyle(color: Colors.red, fontSize: 18),
              )
            else if (_result != null)
              Text(
                "${_result!.toStringAsFixed(2)}", // Làm tròn 2 số thập phân nếu cần
                style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
