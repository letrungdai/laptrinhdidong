import 'package:flutter/material.dart';
import 'dart:async'; // Dùng cho Timer ở Splash Screen

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'UTH SmartTasks',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: const SplashScreen(),
    );
  }
}

// ==========================================
// PHẦN 1: OOP - MODEL DATA
// Tạo Class để quản lý dữ liệu cho Onboarding
// ==========================================
class OnboardingContent {
  final String title;
  final String description;
  final String image; // Đường dẫn ảnh

  OnboardingContent({
    required this.title,
    required this.description,
    required this.image,
  });
}

// Danh sách dữ liệu (Giả lập OOP)
List<OnboardingContent> contents = [
  OnboardingContent(
    title: "Easy Time Management",
    description:
        "With management based on priority and daily tasks, it will give you convenience in managing and determining the tasks that must be done first.",
    image: "assets/images/img1.png", // Thay bằng ảnh thật của bạn
  ),
  OnboardingContent(
    title: "Increase Work Effectiveness",
    description:
        "Time management and the determination of more important tasks will give your job statistics better and always improve.",
    image: "assets/images/img2.png",
  ),
  OnboardingContent(
    title: "Reminder Notification",
    description:
        "The advantage of this application is that it also provides reminders for you so you don't forget to keep doing your assignments.",
    image: "assets/images/img3.png",
  ),
];

// ==========================================
// PHẦN 2: SPLASH SCREEN (Màn hình chờ)
// ==========================================
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    // Đợi 3 giây rồi chuyển sang màn hình Onboarding
    Timer(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const OnboardingScreen()),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Thay Icon này bằng Image.asset('assets/images/logo.png')
            const Icon(Icons.school, size: 100, color: Colors.blue),
            const SizedBox(height: 20),
            const Text(
              "UTH SmartTasks",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ==========================================
// PHẦN 3: ONBOARDING SCREEN (Navigation)
// ==========================================
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentIndex = 0;
  late PageController _controller;

  @override
  void initState() {
    _controller = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Nút Skip ở góc phải
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: () {
                  // Logic mới: Chuyển sang trang (slide) tiếp theo
                  _controller.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.easeIn,
                  );
                },
                child: const Text("Skip", style: TextStyle(color: Colors.grey)),
              ),
            ),
            // Phần hiển thị nội dung (PageView)
            Expanded(
              child: PageView.builder(
                controller: _controller,
                itemCount: contents.length,
                onPageChanged: (int index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                itemBuilder: (_, i) {
                  return Padding(
                    padding: const EdgeInsets.all(40),
                    child: Column(
                      children: [
                        // Ảnh minh họa
                        // Dùng Image.asset(contents[i].image) khi có ảnh thật
                        Image.asset(
                          contents[i].image, // Lấy đường dẫn từ List data
                          height: 250,
                          width: double.infinity,
                          fit: BoxFit.contain, // Giúp ảnh hiển thị trọn vẹn
                        ),
                        const SizedBox(height: 20),
                        // Tiêu đề
                        Text(
                          contents[i].title,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 15),
                        // Mô tả
                        Text(
                          contents[i].description,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // Phần điều hướng (Dots + Button)
            Container(
              margin: const EdgeInsets.only(bottom: 50),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  contents.length,
                  (index) => buildDot(index, context),
                ),
              ),
            ),

            // Nút Next hoặc Get Started
            Container(
              height: 50,
              width: double.infinity,
              margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25),
                  ),
                ),
                onPressed: () {
                  if (currentIndex == contents.length - 1) {
                    // Trang cuối -> Chuyển sang Home
                    print("Navigate to Home Screen");
                  } else {
                    // Chưa phải trang cuối -> Trang tiếp theo
                    _controller.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.easeIn,
                    );
                  }
                },
                child: Text(
                  currentIndex == contents.length - 1 ? "Get Started" : "Next",
                  style: const TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget vẽ dấu chấm tròn
  Container buildDot(int index, BuildContext context) {
    return Container(
      height: 10,
      width: currentIndex == index ? 25 : 10, // Dấu chấm dài ra khi active
      margin: const EdgeInsets.only(right: 5),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: currentIndex == index ? Colors.blue : Colors.grey[300],
      ),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Home Page")),
      body: const Center(
        child: Text(
          "Chào mừng bạn đến với UTH SmartTasks!",
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
