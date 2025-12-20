import 'package:flutter/material.dart';

// --- 1. MODEL CLASS (OOP) ---
class Book {
  String id;
  String title;
  bool isBorrowed; // Trạng thái mượn: true = đã mượn

  Book({required this.id, required this.title, this.isBorrowed = false});
}

class User {
  String id;
  String name;

  User({required this.id, required this.name});
}

// --- 2. MAIN APP ---
void main() => runApp(
  const MaterialApp(debugShowCheckedModeBanner: false, home: LibraryScreen()),
);

class LibraryScreen extends StatefulWidget {
  const LibraryScreen({super.key});

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  // Dữ liệu giả lập (Mock Data)
  List<User> users = [
    User(id: '1', name: 'Nguyễn Văn A'),
    User(id: '2', name: 'Trần Thị B'),
    User(id: '3', name: 'Lê Văn C'),
  ];

  List<Book> books = [
    Book(id: '1', title: 'Lập trình Flutter cơ bản'),
    Book(id: '2', title: 'Clean Architecture'),
    Book(id: '3', title: 'Dart Programming'),
    Book(id: '4', title: 'Design Patterns'),
    Book(id: '5', title: 'UI/UX cho Mobile'),
  ];

  // Trạng thái hiện tại
  late User currentUser;

  @override
  void initState() {
    super.initState();
    currentUser = users[0]; // Mặc định chọn người đầu tiên
  }

  // Hàm đổi người dùng ngẫu nhiên để demo
  void changeUser() {
    setState(() {
      int currentIndex = users.indexOf(currentUser);
      int nextIndex = (currentIndex + 1) % users.length;
      currentUser = users[nextIndex];
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Column(
          children: [
            Text(
              "Hệ thống",
              style: TextStyle(fontSize: 14, color: Colors.grey),
            ),
            Text(
              "Quản lý Thư viện",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // --- PHẦN 1: THÔNG TIN NHÂN VIÊN ---
            const Text(
              "Nhân viên",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 12,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      currentUser.name,
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                const SizedBox(width: 10),
                ElevatedButton(
                  onPressed: changeUser,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade900,
                  ),
                  child: const Text(
                    "Đổi",
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // --- PHẦN 2: DANH SÁCH SÁCH ---
            const Text(
              "Danh sách sách",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: books.length,
                itemBuilder: (context, index) {
                  final book = books[index];
                  return Card(
                    elevation: 2,
                    margin: const EdgeInsets.only(bottom: 10),
                    child: CheckboxListTile(
                      activeColor: Colors.red, // Màu giống design khi check
                      title: Text(
                        book.title,
                        style: TextStyle(
                          decoration: book.isBorrowed
                              ? TextDecoration.lineThrough
                              : null,
                          color: book.isBorrowed ? Colors.grey : Colors.black,
                        ),
                      ),
                      value: book.isBorrowed,
                      onChanged: (bool? value) {
                        setState(() {
                          book.isBorrowed = value!; // Cập nhật trạng thái mượn
                        });

                        // Hiển thị thông báo (Toast/SnackBar) như yêu cầu đề bài "hiển thị thông tin sách"
                        if (value == true) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                "Nhân viên ${currentUser.name} đã mượn: ${book.title}",
                              ),
                              duration: const Duration(seconds: 1),
                            ),
                          );
                        }
                      },
                      secondary: const Icon(Icons.book, color: Colors.blue),
                    ),
                  );
                },
              ),
            ),

            // Nút Thêm ở dưới cùng
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {}, // Chưa có chức năng cụ thể
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue.shade800,
                ),
                child: const Text(
                  "Thêm",
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
      // --- PHẦN 3: BOTTOM NAVIGATION ---
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Quản lý"),
          BottomNavigationBarItem(icon: Icon(Icons.list), label: "DS Sách"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Nhân viên"),
        ],
      ),
    );
  }
}
