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
      title: 'List Demo',
      theme: ThemeData(primarySwatch: Colors.blue, useMaterial3: true),
      home: const HomeScreen(),
    );
  }
}

// --- MÀN HÌNH CHÍNH (CHỌN LOẠI LIST) ---
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Choose List Type',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blue,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Nút MÀU XANH: Dùng ListView thường (Chỉ nên dùng cho list ngắn)
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF4CAF50), // Màu xanh lá
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const StandardListScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    'ListView Standard (1,000,000 items)',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Nút MÀU VÀNG: Dùng ListView.builder (Dùng cho list siêu dài)
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFFFF9800), // Màu vàng cam
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const BuilderListScreen(),
                      ),
                    );
                  },
                  child: const Text(
                    'ListView.builder (1,000,000 items)',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --- MÀN HÌNH 1: DÙNG LISTVIEW THƯỜNG (STANDARD) ---
class StandardListScreen extends StatelessWidget {
  const StandardListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // SỬA LẠI: Chỉ tạo 100 item.
    // Nếu để 10,000,000 ở đây máy sẽ bị treo cứng vì phải vẽ hết 1 lần.
    List<Widget> listItems = List.generate(
      1000000,
      (index) => _buildItemCard(index),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Standard (Hạn chế dùng nhiều)'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
      ),
      // ListView này render toàn bộ listItems ngay lập tức
      body: ListView(padding: const EdgeInsets.all(10), children: listItems),
    );
  }
}

// --- MÀN HÌNH 2: DÙNG LISTVIEW.BUILDER (LAZY LOADING) ---
class BuilderListScreen extends StatelessWidget {
  const BuilderListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Builder (Hiệu năng cao)'),
        backgroundColor: Colors.orange,
        foregroundColor: Colors.white,
      ),
      // ListView.builder chỉ tạo widget khi người dùng cuộn tới nó
      // Nên có thể chạy mượt mà với 1 triệu item
      body: ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: 1000000, // 1 TRIỆU PHẦN TỬ
        itemBuilder: (context, index) {
          return _buildItemCard(index);
        },
      ),
    );
  }
}

// --- HÀM VẼ GIAO DIỆN CHO 1 ITEM (Dùng chung) ---
Widget _buildItemCard(int index) {
  return Card(
    color: Colors.blue.shade50,
    margin: const EdgeInsets.symmetric(vertical: 5),
    elevation: 0,
    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
    child: ListTile(
      leading: CircleAvatar(
        backgroundColor: Colors.blue,
        child: Text(
          '${index + 1}',
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      title: Text(
        'Item #${index + 1}',
        style: const TextStyle(fontWeight: FontWeight.bold),
      ),
      subtitle: const Text(
        'The only way to do great work is to love what you do.',
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      trailing: const Icon(
        Icons.arrow_forward_ios,
        size: 14,
        color: Colors.grey,
      ),
      onTap: () {
        debugPrint('Bấm vào item số ${index + 1}');
      },
    ),
  );
}
