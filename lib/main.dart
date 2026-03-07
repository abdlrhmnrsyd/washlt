import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const PremiumLaundryApp());
}

class PremiumLaundryApp extends StatelessWidget {
  const PremiumLaundryApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WashIt Premium',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF4F46E5), // Indigo
          background: const Color(0xFFF3F4F6), // Cool Gray 100
        ),
        fontFamily: 'Segoe UI', // Fallback, works well on most platforms
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontWeight: FontWeight.w800,
            color: Color(0xFF111827),
          ),
          displayMedium: TextStyle(
            fontWeight: FontWeight.w800,
            color: Color(0xFF111827),
          ),
          displaySmall: TextStyle(
            fontWeight: FontWeight.w800,
            color: Color(0xFF111827),
          ),
          titleLarge: TextStyle(
            fontWeight: FontWeight.w700,
            color: Color(0xFF1F2937),
          ),
          titleMedium: TextStyle(
            fontWeight: FontWeight.w600,
            color: Color(0xFF374151),
          ),
          bodyLarge: TextStyle(
            fontWeight: FontWeight.w500,
            color: Color(0xFF4B5563),
          ),
          bodyMedium: TextStyle(
            fontWeight: FontWeight.w400,
            color: Color(0xFF6B7280),
          ),
        ),
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    const HomePage(),
    const OrderPage(),
    const NotificationPage(),
    const ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true, // Make body extend behind bottom nav
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: _buildFloatingBottomNav(),
    );
  }

  Widget _buildFloatingBottomNav() {
    return Container(
      margin: const EdgeInsets.only(left: 20, right: 20, bottom: 20),
      height: 70,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(35),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF4F46E5).withOpacity(0.15),
            blurRadius: 30,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(35),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _buildNavItem(
              Icons.home_rounded,
              Icons.home_outlined,
              0,
              "Beranda",
            ),
            _buildNavItem(
              Icons.receipt_long_rounded,
              Icons.receipt_long_outlined,
              1,
              "Pesanan",
            ),
            _buildNavItem(
              Icons.notifications_rounded,
              Icons.notifications_none_rounded,
              2,
              "Info",
            ),
            _buildNavItem(
              Icons.person_rounded,
              Icons.person_outline_rounded,
              3,
              "Profil",
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNavItem(
    IconData activeIcon,
    IconData inactiveIcon,
    int index,
    String label,
  ) {
    final isSelected = _currentIndex == index;
    return GestureDetector(
      onTap: () => setState(() => _currentIndex = index),
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected
              ? const Color(0xFF4F46E5).withOpacity(0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Row(
          children: [
            Icon(
              isSelected ? activeIcon : inactiveIcon,
              color: isSelected
                  ? const Color(0xFF4F46E5)
                  : Colors.grey.shade400,
              size: 26,
            ),
            if (isSelected) ...[
              const SizedBox(width: 8),
              Text(
                label,
                style: const TextStyle(
                  color: Color(0xFF4F46E5),
                  fontWeight: FontWeight.w700,
                  fontSize: 14,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

// ==========================================
// HOME PAGE
// ==========================================
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(bottom: 100), // padding for bottom nav
        child: Column(
          children: [
            _buildHeaderCurve(context),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  _buildSectionTitle('Layanan Premium'),
                  const SizedBox(height: 16),
                  _buildServicesGrid(),
                  const SizedBox(height: 30),
                  _buildSectionTitle('Penawaran Spesial'),
                  const SizedBox(height: 16),
                  _buildPromoCarousel(),
                  const SizedBox(height: 30),
                  _buildSectionTitle('Lacak Pesanan'),
                  const SizedBox(height: 16),
                  _buildActiveOrderCard(),
                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderCurve(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: MediaQuery.of(context).padding.top + 20,
        left: 20,
        right: 20,
        bottom: 30,
      ),
      decoration: const BoxDecoration(
        color: Color(0xFF4F46E5),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
        boxShadow: [
          BoxShadow(
            color: Color(0xFF4F46E5),
            blurRadius: 20,
            offset: Offset(0, 5),
            spreadRadius: -10,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Halo, Abdurrahman!",
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "Mau cuci apa hari ini?",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 2),
                ),
                child: const CircleAvatar(
                  radius: 24,
                  backgroundImage: NetworkImage(
                    'https://i.pravatar.cc/150?img=11',
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          // Search / Location Bar inside Header
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                const Icon(Icons.location_on_rounded, color: Color(0xFFEF4444)),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Lokasi Jemput",
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.grey.shade500,
                        ),
                      ),
                      const Text(
                        "Jl. Sudirman No. 45, Jakarta",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xFF1F2937),
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: const Color(0xFF4F46E5).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Icon(
                    Icons.edit_location_alt_rounded,
                    color: Color(0xFF4F46E5),
                    size: 18,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1F2937),
          ),
        ),
        const Text(
          "Lihat Semua",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: Color(0xFF4F46E5),
          ),
        ),
      ],
    );
  }

  Widget _buildServicesGrid() {
    final services = [
      {
        'title': 'Kiloan',
        'icon': Icons.local_laundry_service_rounded,
        'color': const Color(0xFF3B82F6),
      },
      {
        'title': 'Satuan',
        'icon': Icons.checkroom_rounded,
        'color': const Color(0xFF10B981),
      },
      {
        'title': 'Sepatu',
        'icon': Icons.snowshoeing_rounded,
        'color': const Color(0xFFF59E0B),
      },
      {
        'title': 'Karpet',
        'icon': Icons.layers_rounded,
        'color': const Color(0xFF8B5CF6),
      },
      {
        'title': 'Setrika',
        'icon': Icons.iron_rounded,
        'color': const Color(0xFFEC4899),
      },
      {
        'title': 'Kilat 6 Jam',
        'icon': Icons.bolt_rounded,
        'color': const Color(0xFFEF4444),
      },
    ];

    return GridView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 0.85,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
      ),
      itemCount: services.length,
      itemBuilder: (context, index) {
        final s = services[index];
        final Color sColor = s['color'] as Color;
        return _ServiceCard(
          title: s['title'] as String,
          icon: s['icon'] as IconData,
          color: sColor,
        );
      },
    );
  }

  Widget _buildPromoCarousel() {
    return SizedBox(
      height: 160,
      child: ListView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        clipBehavior: Clip.none,
        children: [
          _PromoCard(
            title: "Diskon 30%\nPengguna Baru",
            subtitle: "Gunakan kode: NEWBIE30",
            colorStart: const Color(0xFF8B5CF6),
            colorEnd: const Color(0xFF4F46E5),
            icon: Icons.discount_rounded,
          ),
          const SizedBox(width: 16),
          _PromoCard(
            title: "Gratis Ongkir\nSetiap Jumat",
            subtitle: "Tanpa min. transaksi",
            colorStart: const Color(0xFF10B981),
            colorEnd: const Color(0xFF047857),
            icon: Icons.local_shipping_rounded,
          ),
        ],
      ),
    );
  }

  Widget _buildActiveOrderCard() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFEF3C7),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(
                    Icons.dry_cleaning_rounded,
                    color: Color(0xFFD97706),
                    size: 28,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            "Order #WS-9021",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(0xFFEFF6FF),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Text(
                              "Sedang Dicuci",
                              style: TextStyle(
                                color: Color(0xFF3B82F6),
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        "Estimasi Selesai: Besok, 14:00",
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(height: 1, color: Colors.grey.shade100),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildTrackerStep("Jemput", true),
                _buildTrackerLine(true),
                _buildTrackerStep("Cuci", true),
                _buildTrackerLine(false),
                _buildTrackerStep("Setrika", false),
                _buildTrackerLine(false),
                _buildTrackerStep("Antar", false),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrackerStep(String title, bool isCompleted) {
    return Column(
      children: [
        Container(
          height: 24,
          width: 24,
          decoration: BoxDecoration(
            color: isCompleted ? const Color(0xFF4F46E5) : Colors.white,
            shape: BoxShape.circle,
            border: Border.all(
              color: isCompleted
                  ? const Color(0xFF4F46E5)
                  : Colors.grey.shade300,
              width: 2,
            ),
            boxShadow: isCompleted
                ? [
                    BoxShadow(
                      color: const Color(0xFF4F46E5).withOpacity(0.4),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ]
                : null,
          ),
          child: isCompleted
              ? const Icon(Icons.check_rounded, color: Colors.white, size: 14)
              : null,
        ),
        const SizedBox(height: 8),
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            fontWeight: isCompleted ? FontWeight.bold : FontWeight.w500,
            color: isCompleted ? const Color(0xFF1F2937) : Colors.grey.shade500,
          ),
        ),
      ],
    );
  }

  Widget _buildTrackerLine(bool isCompleted) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(bottom: 24), // alignment correction
        height: 2,
        color: isCompleted ? const Color(0xFF4F46E5) : Colors.grey.shade200,
      ),
    );
  }
}

class _ServiceCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;

  const _ServiceCard({
    required this.title,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 15,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(20),
          onTap: () {},
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.15),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, color: color, size: 28),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                  color: Color(0xFF374151),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PromoCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final Color colorStart;
  final Color colorEnd;
  final IconData icon;

  const _PromoCard({
    required this.title,
    required this.subtitle,
    required this.colorStart,
    required this.colorEnd,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [colorStart, colorEnd],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: colorStart.withOpacity(0.4),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -20,
            bottom: -20,
            child: Icon(icon, color: Colors.white.withOpacity(0.2), size: 100),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  height: 1.2,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                subtitle,
                style: TextStyle(
                  color: Colors.white.withOpacity(0.8),
                  fontSize: 14,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Text(
                  "Klaim Sekarang",
                  style: TextStyle(
                    color: colorEnd,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ==========================================
// ORDER PAGE
// ==========================================
class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      appBar: AppBar(
        title: const Text(
          "Pesanan Saya",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            Container(
              color: Colors.white,
              child: const TabBar(
                labelColor: Color(0xFF4F46E5),
                unselectedLabelColor: Colors.grey,
                indicatorColor: Color(0xFF4F46E5),
                indicatorWeight: 3,
                tabs: [
                  Tab(text: "Aktif"),
                  Tab(text: "Riwayat"),
                ],
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [_buildActiveOrders(), _buildHistoryOrders()],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActiveOrders() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _OrderListItem(
          orderId: "#WS-9021",
          service: "Cuci Kiloan Premium",
          status: "Sedang Dicuci",
          date: "12 Okt 2026",
          price: "Rp 45.000",
          isActive: true,
        ),
      ],
    );
  }

  Widget _buildHistoryOrders() {
    return ListView(
      padding: const EdgeInsets.all(20),
      children: [
        _OrderListItem(
          orderId: "#WS-8832",
          service: "Cuci Sepatu",
          status: "Selesai",
          date: "05 Okt 2026",
          price: "Rp 60.000",
          isActive: false,
        ),
        const SizedBox(height: 16),
        _OrderListItem(
          orderId: "#WS-8710",
          service: "Cuci & Setrika",
          status: "Selesai",
          date: "28 Sep 2026",
          price: "Rp 32.000",
          isActive: false,
        ),
      ],
    );
  }
}

class _OrderListItem extends StatelessWidget {
  final String orderId, service, status, date, price;
  final bool isActive;

  const _OrderListItem({
    required this.orderId,
    required this.service,
    required this.status,
    required this.date,
    required this.price,
    required this.isActive,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.03),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                orderId,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: isActive
                      ? const Color(0xFFEFF6FF)
                      : const Color(0xFFECFDF5),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    color: isActive
                        ? const Color(0xFF3B82F6)
                        : const Color(0xFF10B981),
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            service,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            date,
            style: TextStyle(color: Colors.grey.shade500, fontSize: 14),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text("Total", style: TextStyle(color: Colors.grey.shade600)),
              Text(
                price,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Color(0xFF4F46E5),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ==========================================
// NOTIFICATION PAGE
// ==========================================
class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      appBar: AppBar(
        title: const Text(
          "Notifikasi",
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(20),
        children: [
          _NotificationItem(
            title: "Pesanan Diantar 🚚",
            message: "Pesanan #WS-9021 sedang dalam perjalanan ke alamatmu.",
            time: "Baru saja",
            icon: Icons.local_shipping_rounded,
            color: const Color(0xFF3B82F6),
            isUnread: true,
          ),
          _NotificationItem(
            title: "Promo Berakhir Hari Ini!",
            message: "Diskon 30% akan hangus, yuk cuci sekarang.",
            time: "2 jam yang lalu",
            icon: Icons.discount_rounded,
            color: const Color(0xFFF59E0B),
            isUnread: false,
          ),
          _NotificationItem(
            title: "Cucian Selesai Direndam",
            message: "Pakaianmu wangiii! Kini sedang proses pengeringan.",
            time: "Kemarin",
            icon: Icons.water_drop_rounded,
            color: const Color(0xFF10B981),
            isUnread: false,
          ),
        ],
      ),
    );
  }
}

class _NotificationItem extends StatelessWidget {
  final String title, message, time;
  final IconData icon;
  final Color color;
  final bool isUnread;

  const _NotificationItem({
    required this.title,
    required this.message,
    required this.time,
    required this.icon,
    required this.color,
    required this.isUnread,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isUnread ? Colors.white : Colors.grey.shade50,
        borderRadius: BorderRadius.circular(20),
        border: isUnread
            ? Border.all(color: const Color(0xFF4F46E5).withOpacity(0.2))
            : null,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        fontWeight: isUnread
                            ? FontWeight.bold
                            : FontWeight.w600,
                        fontSize: 15,
                      ),
                    ),
                    Text(
                      time,
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Text(
                  message,
                  style: TextStyle(color: Colors.grey.shade600, height: 1.4),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ==========================================
// PROFILE PAGE
// ==========================================
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF3F4F6),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(bottom: 100),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 30,
                bottom: 30,
              ),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
              ),
              child: Center(
                child: Column(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: const Color(0xFF4F46E5),
                          width: 3,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFF4F46E5).withOpacity(0.3),
                            blurRadius: 20,
                            offset: const Offset(0, 10),
                          ),
                        ],
                      ),
                      child: const CircleAvatar(
                        radius: 50,
                        backgroundImage: NetworkImage(
                          'https://i.pravatar.cc/150?img=11',
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "Abdurrahman Rasyid",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "+62 812 3456 7890",
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  _buildProfileCard(
                    title: "WashPay Wallet",
                    subtitle: "Rp 150.000",
                    icon: Icons.account_balance_wallet_rounded,
                    color: const Color(0xFF10B981),
                    trailing: const Text(
                      "Top Up",
                      style: TextStyle(
                        color: Color(0xFF4F46E5),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        _buildMenuTile(
                          Icons.location_on_rounded,
                          "Alamat Tersimpan",
                        ),
                        _buildDivider(),
                        _buildMenuTile(
                          Icons.payment_rounded,
                          "Metode Pembayaran",
                        ),
                        _buildDivider(),
                        _buildMenuTile(
                          Icons.local_offer_rounded,
                          "Promo & Voucher",
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      children: [
                        _buildMenuTile(Icons.settings_rounded, "Pengaturan"),
                        _buildDivider(),
                        _buildMenuTile(
                          Icons.help_center_rounded,
                          "Bantuan & Dukungan",
                        ),
                        _buildDivider(),
                        _buildMenuTile(
                          Icons.exit_to_app_rounded,
                          "Keluar",
                          color: Colors.red,
                        ),
                      ],
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

  Widget _buildProfileCard({
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required Widget trailing,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(color: Colors.grey.shade600, fontSize: 13),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
          ),
          trailing,
        ],
      ),
    );
  }

  Widget _buildMenuTile(
    IconData icon,
    String title, {
    Color color = const Color(0xFF374151),
  }) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 4),
      leading: Icon(icon, color: color, size: 26),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: color,
          fontSize: 16,
        ),
      ),
      trailing: const Icon(Icons.chevron_right_rounded, color: Colors.grey),
      onTap: () {},
    );
  }

  Widget _buildDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Divider(height: 1, color: Colors.grey.shade100),
    );
  }
}
