import 'package:flutter/material.dart';

// Ekranların içe aktarılması
import 'screens/01_layout_screen.dart';
import 'screens/02_markets_list_screen.dart';
import 'screens/03_transferm_from_screen.dart';

void main() {
  runApp(const DtmMasterApp());
}

class DtmMasterApp extends StatelessWidget {
  const DtmMasterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "DTM Flutter Sınıfı",
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF6366F1),
          brightness: Brightness.light,
        ),
      ),
      // Başlangıç ekranı olarak yönlendirici sınıfı çağırıyoruz
      home: const MainNavigatorScreen(), 
    );
  }
}

// Ekranlar arası geçişi sağlayacak Stateful Widget
class MainNavigatorScreen extends StatefulWidget {
  const MainNavigatorScreen({super.key});

  @override
  State<MainNavigatorScreen> createState() => _MainNavigatorScreenState();
}

class _MainNavigatorScreenState extends State<MainNavigatorScreen> {
  // Seçili olan sekmenin indeksi (0: Ana Sayfa, 1: Piyasalar, 2: Transfer)
  int _currentIndex = 0;

  // Gösterilecek ekranların listesi
  final List<Widget> _screens = [
    // 1. Ekran: LayoutStylingScreen (Kendi Scaffold'u olmadığı için burada sarıyoruz)
    const Scaffold(
      backgroundColor: Color(0xFFF8FAFC),
      body: SafeArea(
        child: LayoutStylingScreen(),
      ),
    ),
    // 2. Ekran: MarketsListScreen
    const MarketsListScreen(),
    // 3. Ekran: TransferFromScreen
    const TransferFromScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_currentIndex], // Seçili sekmeye göre ekranı göster
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: (index) {
          setState(() {
            _currentIndex = index; // Sekmeye tıklandığında indeksi güncelle
          });
        },
        selectedItemColor: const Color(0xFF4F46E5), // Seçili ikon rengi
        unselectedItemColor: Colors.grey, // Seçili olmayan ikon rengi
        backgroundColor: Colors.white,
        elevation: 10,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_rounded),
            label: 'Ana Sayfa',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.candlestick_chart_rounded),
            label: 'Piyasalar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.swap_horiz_rounded),
            label: 'Transfer',
          ),
        ],
      ),
    );
  }
}