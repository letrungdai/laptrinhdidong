import 'package:flutter/material.dart';

// --- 1. ÁP DỤNG OOP: Tạo Class mô hình dữ liệu ---
class PaymentMethod {
  final String id;
  final String name;
  final IconData icon; // Nếu bạn dùng ảnh thì đổi thành String assetPath
  final Color color;

  PaymentMethod({
    required this.id,
    required this.name,
    required this.icon,
    required this.color,
  });
}

void main() {
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: PaymentSelectionScreen(),
    ),
  );
}

class PaymentSelectionScreen extends StatefulWidget {
  const PaymentSelectionScreen({super.key});

  @override
  State<PaymentSelectionScreen> createState() => _PaymentSelectionScreenState();
}

class _PaymentSelectionScreenState extends State<PaymentSelectionScreen> {
  // Danh sách các đối tượng thanh toán (Data)
  final List<PaymentMethod> methods = [
    PaymentMethod(
      id: 'paypal',
      name: 'PayPal',
      icon: Icons.paypal,
      color: Colors.blue.shade800,
    ),
    PaymentMethod(
      id: 'google',
      name: 'GooglePay',
      icon: Icons.g_mobiledata,
      color: Colors.red,
    ),
    PaymentMethod(
      id: 'apple',
      name: 'ApplePay',
      icon: Icons.apple,
      color: Colors.black,
    ),
  ];

  // Biến lưu trạng thái lựa chọn (Nullable)
  // Ban đầu chưa chọn gì cả nên giá trị là null
  PaymentMethod? _selectedMethod;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text("Thanh toán", style: TextStyle(color: Colors.black)),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            // --- PHẦN 1: MÀN HÌNH HIỂN THỊ TRẠNG THÁI ---
            Expanded(
              flex: 1,
              child: Center(
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: _selectedMethod == null
                      ? Column(
                          key: const ValueKey(1),
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: const [
                            Icon(
                              Icons.account_balance_wallet,
                              size: 80,
                              color: Colors.grey,
                            ),
                            SizedBox(height: 10),
                            Text(
                              "Vui lòng chọn phương thức",
                              style: TextStyle(color: Colors.grey),
                            ),
                          ],
                        )
                      : Column(
                          key: const ValueKey(
                            2,
                          ), // Key để tạo hiệu ứng chuyển đổi
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              _selectedMethod!
                                  .icon, // Dùng dấu ! vì chắc chắn đã chọn
                              size: 100,
                              color: _selectedMethod!.color,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              _selectedMethod!.name,
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                ),
              ),
            ),

            // --- PHẦN 2: DANH SÁCH LỰA CHỌN (Dùng OOP để render) ---
            Expanded(
              flex: 1,
              child: Column(
                children: [
                  // Dùng map để duyệt qua danh sách đối tượng và tạo giao diện
                  ...methods.map((method) {
                    bool isSelected = _selectedMethod == method;
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedMethod = method; // Cập nhật trạng thái
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.symmetric(vertical: 8),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade50,
                          border: Border.all(
                            color: isSelected
                                ? Colors.blue
                                : Colors.grey.shade300,
                            width: isSelected ? 2 : 1,
                          ),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            // Radio Button giả lập
                            Icon(
                              isSelected
                                  ? Icons.radio_button_checked
                                  : Icons.radio_button_off,
                              color: isSelected ? Colors.blue : Colors.grey,
                            ),
                            const SizedBox(width: 16),
                            Text(
                              method.name,
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            const Spacer(),
                            Icon(method.icon, color: method.color),
                          ],
                        ),
                      ),
                    );
                  }).toList(),

                  const Spacer(),

                  // --- PHẦN 3: NÚT CONTINUE ---
                  // Chỉ hiện nút Continue khi đã chọn (_selectedMethod khác null)
                  if (_selectedMethod != null)
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12),
                          ),
                        ),
                        onPressed: () {
                          // Xử lý khi bấm tiếp tục
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Đã chọn thanh toán qua ${_selectedMethod!.name}",
                              ),
                            ),
                          );
                        },
                        child: const Text(
                          "Continue",
                          style: TextStyle(fontSize: 18, color: Colors.white),
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
