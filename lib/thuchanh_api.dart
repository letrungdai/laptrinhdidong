import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ProductScreen(),
    );
  }
}

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  // Các biến để lưu dữ liệu riêng lẻ
  String name = "Đang tải...";
  String description = "";
  double price = 0.0;
  String imgURL = "";
  bool isLoading = true; // Biến kiểm tra xem đã tải xong chưa

  @override
  void initState() {
    super.initState();
    fetchProductData();
  }

  Future<void> fetchProductData() async {
    final url = Uri.parse(
      'https://mock.apidog.com/m1/890655-872447-default/v2/product',
    );

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final decodedData = jsonDecode(utf8.decode(response.bodyBytes));

        setState(() {
          // Gán dữ liệu từ JSON vào các biến riêng
          // Lưu ý: Tên key phải khớp với cái bạn thấy trong ảnh ('name', 'des', 'price', 'imgURL')
          name = decodedData['name'] ?? "Tên sản phẩm lỗi";
          description = decodedData['des'] ?? "Không có mô tả";
          price = (decodedData['price'] is int)
              ? (decodedData['price'] as int).toDouble()
              : decodedData['price'];
          imgURL = decodedData['imgURL'] ?? "";

          isLoading = false; // Đã tải xong
        });
      } else {
        setState(() {
          name = "Lỗi tải: ${response.statusCode}";
          isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        name = "Lỗi kết nối!";
        description = e.toString();
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chi tiết sản phẩm"),
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            ) // Xoay vòng tròn khi đang tải
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. Hiển thị Ảnh
                  Center(
                    child: imgURL.isNotEmpty
                        ? Image.network(
                            imgURL,
                            height: 200,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(
                                  Icons.broken_image,
                                  size: 100,
                                  color: Colors.grey,
                                ),
                          )
                        : const Icon(
                            Icons.image,
                            size: 100,
                            color: Colors.grey,
                          ),
                  ),
                  const SizedBox(height: 20),

                  // 2. Hiển thị Tên
                  Text(
                    name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),

                  // 3. Hiển thị Giá
                  Text(
                    "Giá: \$${price.toString()}",
                    style: const TextStyle(
                      fontSize: 20,
                      color: Colors.red,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 16),

                  // 4. Hiển thị Mô tả
                  const Text(
                    "Mô tả:",
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    description,
                    style: const TextStyle(fontSize: 16, color: Colors.black54),
                  ),
                ],
              ),
            ),
    );
  }
}
