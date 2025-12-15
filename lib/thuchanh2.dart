import 'package:flutter/material.dart';

class PracticeScreen extends StatefulWidget {
  const PracticeScreen({super.key});

  @override
  State<PracticeScreen> createState() => _PracticeScreenState();
}

class _PracticeScreenState extends State<PracticeScreen> {
  // Controller để lấy dữ liệu từ ô nhập
  final TextEditingController _numberController = TextEditingController();

  // Biến lưu trạng thái thông báo lỗi
  String? _errorMessage;

  // Danh sách các số sẽ được tạo ra
  List<int> _generatedList = [];

  // Hàm xử lý khi nhấn nút "Tạo"
  void _handleCreate() {
    // 1. Lấy dữ liệu từ ô nhập
    String input = _numberController.text;

    // 2. Kiểm tra dữ liệu (Validate)
    // int.tryParse sẽ trả về null nếu không phải là số
    int? number = int.tryParse(input);

    setState(() {
      if (number == null || number < 0) {
        // Trường hợp nhập sai (chữ, ký tự đặc biệt, hoặc để trống)
        _errorMessage = "Dữ liệu bạn nhập không hợp lệ";
        _generatedList = []; // Xóa danh sách cũ nếu có
      } else {
        // Trường hợp nhập đúng số
        _errorMessage = null; // Xóa thông báo lỗi
        // Tạo danh sách từ 1 đến số vừa nhập
        _generatedList = List.generate(number, (index) => index + 1);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Number", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // Tiêu đề
            const Text(
              "Thực hành 02",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Khu vực nhập liệu và nút bấm
            Row(
              children: [
                // Ô nhập liệu (TextField)
                Expanded(
                  child: TextField(
                    controller: _numberController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      hintText: "Nhập vào số lượng",
                      hintStyle: TextStyle(color: Colors.grey[400]),
                      contentPadding: const EdgeInsets.symmetric(
                        horizontal: 15,
                        vertical: 10,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                        borderSide: const BorderSide(color: Colors.grey),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 10),

                // Nút Tạo (Button)
                ElevatedButton(
                  onPressed: _handleCreate,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue, // Màu nền nút
                    foregroundColor: Colors.white, // Màu chữ
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 15,
                    ),
                  ),
                  child: const Text("Tạo"),
                ),
              ],
            ),

            // Khu vực hiển thị lỗi (nếu có)
            if (_errorMessage != null)
              Padding(
                padding: const EdgeInsets.only(top: 10),
                child: Text(
                  _errorMessage!,
                  style: const TextStyle(
                    color: Colors.red,
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),

            const SizedBox(height: 20),

            // Khu vực hiển thị danh sách kết quả
            Expanded(
              child: ListView.builder(
                itemCount: _generatedList.length,
                itemBuilder: (context, index) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 10),
                    padding: const EdgeInsets.symmetric(vertical: 15),
                    decoration: BoxDecoration(
                      color: Colors.red, // Màu nền item theo thiết kế
                      borderRadius: BorderRadius.circular(20), // Bo tròn góc
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      "${_generatedList[index]}",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
