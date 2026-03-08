import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'dart:ui';

void main() {
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ),
  );
  runApp(const WashItApp());
}

class WashItApp extends StatelessWidget {
  const WashItApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'WashIt',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(
            0xFF0F172A,
          ), // Dark Midnight Blue theme for premium look
          background: const Color(0xFF000000), // Slate 100
        ),
        fontFamily: 'Segoe UI',
        textTheme: const TextTheme(
          displayLarge: TextStyle(
            fontWeight: FontWeight.w900,
            color: Colors.white,
          ),
          displayMedium: TextStyle(
            fontWeight: FontWeight.w900,
            color: Colors.white,
          ),
          titleLarge: TextStyle(
            fontWeight: FontWeight.w800,
            color: Colors.white,
          ),
          titleMedium: TextStyle(
            fontWeight: FontWeight.w700,
            color: Color(0xFFE4E4E7),
          ),
          bodyLarge: TextStyle(
            fontWeight: FontWeight.w600,
            color: Color(0xFFA1A1AA),
          ),
          bodyMedium: TextStyle(
            fontWeight: FontWeight.w500,
            color: Color(0xFFA1A1AA),
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
      extendBody: true,
      body: IndexedStack(index: _currentIndex, children: _pages),
      bottomNavigationBar: _buildFloatingBottomNav(),
      floatingActionButton: _currentIndex == 0 ? _buildFab() : null,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget _buildFab() {
    return Container(
      margin: const EdgeInsets.only(top: 36), // Push slightly lower
      height: 68,
      width: 68,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF00E5FF),
            Color(0xFF7000FF),
          ], // Bright blue gradient
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF00E5FF).withOpacity(0.4),
            blurRadius: 20,
            offset: const Offset(0, 10),
            spreadRadius: 2,
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          customBorder: const CircleBorder(),
          onTap: () => _showNewOrderBottomSheet(context),
          child: const Icon(
            Icons.add_shopping_cart_rounded,
            color: Color(0xFF111111),
            size: 30,
          ),
        ),
      ),
    );
  }

  Widget _buildFloatingBottomNav() {
    return BottomAppBar(
      color: Colors.transparent,
      elevation: 0,
      padding: EdgeInsets.zero,
      child: Container(
        height: 75, // Slightly taller
        margin: const EdgeInsets.only(left: 24, right: 24, bottom: 24),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(40),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.3),
              blurRadius: 30,
              offset: const Offset(0, 15),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(40),
          child: BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 20, sigmaY: 20),
            child: Container(
              color: Color(
                0xFF111111,
              ).withOpacity(0.6), // Frosted glass transparency
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _buildNavItem(
                    Icons.grid_view_rounded,
                    Icons.grid_view_outlined,
                    0,
                    "Beranda",
                  ),
                  _buildNavItem(
                    Icons.receipt_long_rounded,
                    Icons.receipt_long_outlined,
                    1,
                    "Pesanan",
                  ),
                  const SizedBox(width: 48), // Space for FAB
                  _buildNavItem(
                    Icons.notifications_active_rounded,
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
          ),
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
      child: SizedBox(
        width: 65,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 400),
              curve: Curves.easeOutCubic,
              padding: EdgeInsets.symmetric(
                horizontal: isSelected ? 12 : 8,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: isSelected ? Colors.white : Colors.transparent,
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(
                isSelected ? activeIcon : inactiveIcon,
                color: isSelected ? Color(0xFF111111) : Color(0xFF71717A),
                size: 26,
              ),
            ),
            AnimatedOpacity(
              duration: const Duration(milliseconds: 300),
              opacity: isSelected ? 1.0 : 0.0,
              child: Padding(
                padding: const EdgeInsets.only(top: 4.0),
                child: Text(
                  label,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showNewOrderBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return Container(
          height:
              MediaQuery.of(context).size.height *
              0.75, // Taller for more content
          decoration: const BoxDecoration(
            color: Color(0xFF111111),
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(36),
              topRight: Radius.circular(36),
            ),
          ),
          child: Column(
            children: [
              const SizedBox(height: 16),
              Container(
                width: 60,
                height: 6,
                decoration: BoxDecoration(
                  color: Color(0xFF3F3F46),
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              const SizedBox(height: 32),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Pesan Layanan",
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ),
                    Icon(Icons.tune_rounded, color: Color(0xFFE4E4E7)),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Expanded(
                child: ListView(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  children: [
                    _buildOrderOptionCard(
                      "Cuci Kiloan Premium",
                      "Pakaian harian bersih & wangi",
                      Icons.local_laundry_service_rounded,
                      "Mulai Rp 8.000/kg",
                      const Color(0xFF00E5FF),
                    ),
                    const SizedBox(height: 16),
                    _buildOrderOptionCard(
                      "Cuci Satuan VIP",
                      "Garansi aman untuk batik & jas",
                      Icons.checkroom_rounded,
                      "Mulai Rp 25.000/pcs",
                      const Color(0xFF00FFA3),
                    ),
                    const SizedBox(height: 16),
                    _buildOrderOptionCard(
                      "Deep Clean Sepatu",
                      "Kembalikan warna asli sepatu",
                      Icons.snowshoeing_rounded,
                      "Mulai Rp 45.000/psg",
                      const Color(0xFFFFB000),
                    ),
                    const SizedBox(height: 16),
                    _buildOrderOptionCard(
                      "Spa Karpet",
                      "Pembersihan tungau & noda",
                      Icons.layers_rounded,
                      "Mulai Rp 30.000/m2",
                      const Color(0xFFB52BFF),
                    ),
                    const SizedBox(height: 32), // Padding at bottom
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildOrderOptionCard(
    String title,
    String subtitle,
    IconData icon,
    String price,
    Color color,
  ) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF111111),
        borderRadius: BorderRadius.circular(32),
        border: Border.all(color: Color(0xFF27272A), width: 2),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(32),
          onTap: () {},
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Icon(icon, color: color, size: 32),
                ),
                const SizedBox(width: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          fontWeight: FontWeight.w800,
                          fontSize: 16,
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        subtitle,
                        style: TextStyle(
                          color: Color(0xFFA1A1AA),
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: color.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          price,
                          style: TextStyle(
                            color: color,
                            fontWeight: FontWeight.w800,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 18,
                  color: Color(0xFF71717A),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ==========================================
// HOME PAGE - WASHIT PREMIUM
// ==========================================
class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF000000), // Slate 100
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          _buildSliverAppBar(context),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(left: 24, right: 24, bottom: 130),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 24),
                  _buildSearchBar(),
                  const SizedBox(height: 36),
                  _buildSectionTitle('Kategori Layanan'),
                  const SizedBox(height: 20),
                  _buildServicesGrid(),
                  const SizedBox(height: 36),
                  _buildSectionTitle('Penawaran Eksklusif'),
                  const SizedBox(height: 20),
                  _buildPromoCarousel(),
                  const SizedBox(height: 36),
                  _buildSectionTitle('Status Cucianmu'),
                  const SizedBox(height: 20),
                  _buildActiveOrderCard(),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  SliverAppBar _buildSliverAppBar(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 140, // Slightly taller for breathing room
      floating: false,
      pinned: true,
      elevation: 0,
      backgroundColor: const Color(0xFF000000), // Match background
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          padding: EdgeInsets.only(
            top: MediaQuery.of(context).padding.top + 20,
            left: 24,
            right: 24,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Text(
                          "Halo, Asit 🤗", // Updated Name!
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18, // Bigger
                            fontWeight: FontWeight.w800,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 4,
                          ),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFEF3C7),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: const Text(
                            "PRO",
                            style: TextStyle(
                              color: Color(0xFFD97706),
                              fontSize: 10,
                              fontWeight: FontWeight.w900,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    const Text(
                      "Mau pakaianmu\nkembali seperti baru?",
                      style: TextStyle(
                        color: Color(0xFFA1A1AA),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                        height: 1.3,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: Border.all(color: Color(0xFF111111), width: 3),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: const CircleAvatar(
                  radius: 28,
                  backgroundColor: Color(0xFFE2E8F0),
                  backgroundImage: NetworkImage(
                    'https://i.pravatar.cc/150?img=60',
                  ), // Updated Avatar
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      decoration: BoxDecoration(
        color: Color(0xFF111111),
        borderRadius: BorderRadius.circular(32), // More rounded
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.04),
            blurRadius: 24,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Row(
        children: [
          const Icon(Icons.search_rounded, color: Color(0xFF94A3B8), size: 24),
          const SizedBox(width: 16),
          Expanded(
            child: TextField(
              decoration: InputDecoration(
                hintText: "Cari \"Cuci Jas\"...",
                hintStyle: TextStyle(
                  color: Color(0xFF71717A),
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
                border: InputBorder.none,
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF00E5FF), Color(0xFF7000FF)],
              ), // Blue gradient
              borderRadius: BorderRadius.circular(16), // Rounded square
            ),
            child: const Icon(
              Icons.tune_rounded,
              color: Color(0xFF111111),
              size: 20,
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
            fontWeight: FontWeight.w900,
            color: Colors.white,
            letterSpacing: -0.5,
          ),
        ),
        const Text(
          "Semua",
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w800,
            color: Color(0xFF00E5FF),
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
        'color': const Color(0xFF00E5FF),
      },
      {
        'title': 'Satuan',
        'icon': Icons.checkroom_rounded,
        'color': const Color(0xFF00FFA3),
      },
      {
        'title': 'Sepatu',
        'icon': Icons.snowshoeing_rounded,
        'color': const Color(0xFFFFB000),
      },
      {
        'title': 'Karpet',
        'icon': Icons.layers_rounded,
        'color': const Color(0xFFB52BFF),
      },
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: services.map((s) {
        return _ServiceItem(
          title: s['title'] as String,
          icon: s['icon'] as IconData,
          color: s['color'] as Color,
        );
      }).toList(),
    );
  }

  Widget _buildPromoCarousel() {
    return SizedBox(
      height: 180, // Taller for more impressive cards
      child: ListView(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        clipBehavior: Clip.none,
        children: [
          _PromoBannerCard(
            title: "Diskon 50%",
            subtitle: "Spesial untuk\npengguna PRO",
            icon: Icons.percent_rounded,
            color1: Colors.white, // Dark slate
            color2: Colors.white, // Darker slate
          ),
          const SizedBox(width: 20),
          _PromoBannerCard(
            title: "Gratis Jemput",
            subtitle: "Maksimal\njarak 15 KM",
            icon: Icons.electric_moped_rounded,
            color1: const Color(0xFF00FFA3), // Emerald
            color2: const Color(0xFF008A56), // Dark Emerald
          ),
          const SizedBox(width: 20),
        ],
      ),
    );
  }

  Widget _buildActiveOrderCard() {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF111111),
        borderRadius: BorderRadius.circular(40), // Very rounded corner
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.05),
            blurRadius: 30,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFEF3C7),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: const Icon(
                        Icons.dry_cleaning_rounded,
                        color: Color(0xFFD97706),
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 20),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          "Order #WSH-2938",
                          style: TextStyle(
                            fontWeight: FontWeight.w900,
                            fontSize: 18,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(height: 6),
                        Text(
                          "Sedang disetrika",
                          style: TextStyle(
                            color: Color(0xFFD97706),
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: const Color(0xFF000000),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: const Icon(
                    Icons.arrow_forward_ios_rounded,
                    color: Color(0xFFA1A1AA),
                    size: 16,
                  ),
                ),
              ],
            ),
          ),
          Container(height: 1, color: Color(0xFF27272A)), // Very thin line
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _buildTrackerNode("Jemput", true),
                _buildLine(true),
                _buildTrackerNode("Cuci", true),
                _buildLine(true),
                _buildTrackerNode(
                  "Setrika",
                  false,
                  isActive: true,
                ), // Current step
                _buildLine(false),
                _buildTrackerNode("Antar", false),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTrackerNode(
    String title,
    bool isCompleted, {
    bool isActive = false,
  }) {
    return Column(
      children: [
        Container(
          height: 28, // Slighly bigger
          width: 28,
          decoration: BoxDecoration(
            color: isCompleted
                ? const Color(0xFF00FFA3)
                : (isActive ? Color(0xFF111111) : Color(0xFF111111)),
            shape: BoxShape.circle,
            border: Border.all(
              color: isCompleted
                  ? const Color(0xFF00FFA3)
                  : (isActive ? const Color(0xFF00E5FF) : Color(0xFF3F3F46)),
              width: isActive
                  ? 4
                  : (isCompleted ? 2 : 2), // Thicker border for active
            ),
            boxShadow: isActive
                ? [
                    BoxShadow(
                      color: const Color(0xFF00E5FF).withOpacity(0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ]
                : null,
          ),
          child: isCompleted
              ? const Icon(
                  Icons.check_rounded,
                  color: Color(0xFF111111),
                  size: 16,
                )
              : null,
        ),
        const SizedBox(height: 10),
        Text(
          title,
          style: TextStyle(
            fontSize: 12,
            fontWeight: isActive || isCompleted
                ? FontWeight.w800
                : FontWeight.w600,
            color: isActive || isCompleted ? Colors.white : Color(0xFF71717A),
          ),
        ),
      ],
    );
  }

  Widget _buildLine(bool isCompleted) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.only(bottom: 24),
        height: 4, // Thicker line
        decoration: BoxDecoration(
          color: isCompleted ? const Color(0xFF00FFA3) : Color(0xFF27272A),
          borderRadius: BorderRadius.circular(2),
        ),
      ),
    );
  }
}

class _ServiceItem extends StatelessWidget {
  final String title;
  final IconData icon;
  final Color color;

  const _ServiceItem({
    required this.title,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 76, // Slightly larger
          width: 76,
          decoration: BoxDecoration(
            color: Color(0xFF111111),
            borderRadius: BorderRadius.circular(32), // Squircle shape
            boxShadow: [
              BoxShadow(
                color: Colors.white.withOpacity(0.04),
                blurRadius: 20,
                offset: const Offset(0, 10),
              ),
            ],
          ),
          child: Icon(icon, color: color, size: 36),
        ),
        const SizedBox(height: 14),
        Text(
          title,
          style: const TextStyle(
            fontWeight: FontWeight.w800,
            fontSize: 13,
            color: Color(0xFFE4E4E7),
          ),
        ),
      ],
    );
  }
}

class _PromoBannerCard extends StatelessWidget {
  final String title, subtitle;
  final IconData icon;
  final Color color1, color2;

  const _PromoBannerCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.color1,
    required this.color2,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 280, // Wider
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [color1, color2],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(40), // Very round
        boxShadow: [
          BoxShadow(
            color: color1.withOpacity(0.4),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Stack(
        children: [
          Positioned(
            right: -30,
            bottom: -20,
            child: Icon(
              icon,
              color: Color(0xFF111111).withOpacity(0.1),
              size: 140,
            ),
          ), // Huge subtle icon
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: Color(0xFF111111).withOpacity(0.2),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  "PROMO KHUSUS",
                  style: TextStyle(
                    color: Color(0xFF111111),
                    fontSize: 10,
                    fontWeight: FontWeight.w900,
                    letterSpacing: 1.5,
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(
                title,
                style: const TextStyle(
                  color: Color(0xFF111111),
                  fontSize: 28,
                  fontWeight: FontWeight.w900,
                  letterSpacing: -1,
                ),
              ),
              const SizedBox(height: 6),
              Text(
                subtitle,
                style: TextStyle(
                  color: Color(0xFF111111).withOpacity(0.8),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  height: 1.4,
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
// ORDER PAGE FULL - WASHIT PREMIUM
// ==========================================
class OrderPage extends StatelessWidget {
  const OrderPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF000000), // Slate 100
      appBar: AppBar(
        title: const Text(
          "Pesanan Saya",
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 22,
            color: Colors.white,
            letterSpacing: -0.5,
          ),
        ),
        backgroundColor: const Color(0xFF000000),
        elevation: 0,
        centerTitle: false, // Left aligned looks more premium
        titleSpacing: 24,
      ),
      body: DefaultTabController(
        length: 2,
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
              child: Container(
                height: 50, // Custom TabBar holder
                decoration: BoxDecoration(
                  color: Color(0xFF111111),
                  borderRadius: BorderRadius.circular(25),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.white.withOpacity(0.03),
                      blurRadius: 10,
                      offset: const Offset(0, 5),
                    ),
                  ],
                ),
                child: TabBar(
                  indicator: BoxDecoration(
                    color: Colors.white, // Dark mode indicator
                    borderRadius: BorderRadius.circular(25),
                  ),
                  labelColor: Color(0xFF111111),
                  unselectedLabelColor: const Color(0xFFA1A1AA),
                  labelStyle: const TextStyle(
                    fontWeight: FontWeight.w800,
                    fontSize: 14,
                  ),
                  unselectedLabelStyle: const TextStyle(
                    fontWeight: FontWeight.w700,
                    fontSize: 14,
                  ),
                  padding: const EdgeInsets.all(
                    4,
                  ), // Give spacing inside the container
                  tabs: const [
                    Tab(text: "Sedang Proses"),
                    Tab(text: "Riwayat Selesai"),
                  ],
                ),
              ),
            ),
            Expanded(
              child: TabBarView(
                children: [
                  ListView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.only(
                      top: 16,
                      left: 24,
                      right: 24,
                      bottom: 120,
                    ),
                    children: [
                      _buildOrderItem(
                        id: "WSH-2938",
                        type: "Cuci Satuan VIP",
                        date: "10 Mar 2026",
                        price: "Rp 75.000",
                        status: "Sedang diantar",
                        isDone: false,
                        color: const Color(0xFF00E5FF),
                      ),
                      const SizedBox(height: 20),
                      _buildOrderItem(
                        id: "WSH-2940",
                        type: "Cuci Sepatu",
                        date: "11 Mar 2026",
                        price: "Rp 40.000",
                        status: "Sedang dicuci",
                        isDone: false,
                        color: const Color(0xFFB52BFF),
                      ),
                    ],
                  ),
                  ListView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.only(
                      top: 16,
                      left: 24,
                      right: 24,
                      bottom: 120,
                    ),
                    children: [
                      _buildOrderItem(
                        id: "WSH-2801",
                        type: "Cuci Kiloan",
                        date: "02 Mar 2026",
                        price: "Rp 35.000",
                        status: "Selesai",
                        isDone: true,
                      ),
                      const SizedBox(height: 20),
                      _buildOrderItem(
                        id: "WSH-2790",
                        type: "Karpet Besar",
                        date: "25 Feb 2026",
                        price: "Rp 120.000",
                        status: "Selesai",
                        isDone: true,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildOrderItem({
    required String id,
    required String type,
    required String date,
    required String price,
    required String status,
    required bool isDone,
    Color color = Colors.white,
  }) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Color(0xFF111111),
        borderRadius: BorderRadius.circular(32), // Squircle
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 10),
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
                "Order #$id",
                style: TextStyle(
                  fontWeight: FontWeight.w900,
                  color: Color(0xFF71717A),
                  fontSize: 13,
                  letterSpacing: 0.5,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: isDone
                      ? const Color(0xFF00FFA3).withOpacity(0.1)
                      : color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  status,
                  style: TextStyle(
                    color: isDone ? const Color(0xFF00FFA3) : color,
                    fontWeight: FontWeight.w800,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(14),
                decoration: BoxDecoration(
                  color: const Color(0xFF000000),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Icon(
                  Icons.dry_cleaning_rounded,
                  color: isDone ? Color(0xFF52525B) : color,
                  size: 30,
                ),
              ),
              const SizedBox(width: 20),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    type,
                    style: const TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    date,
                    style: TextStyle(
                      color: Color(0xFFA1A1AA),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 20),
          const Divider(),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Total Transfer",
                style: TextStyle(
                  color: Color(0xFFA1A1AA),
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                price,
                style: const TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 18,
                  color: Colors.white,
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
// NOTIFICATION PAGE FULL - PREMIUM
// ==========================================
class NotificationPage extends StatelessWidget {
  const NotificationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF000000),
      appBar: AppBar(
        title: const Text(
          "Notifikasi",
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 22,
            color: Colors.white,
            letterSpacing: -0.5,
          ),
        ),
        backgroundColor: const Color(0xFF000000),
        elevation: 0,
        centerTitle: false,
        titleSpacing: 24,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: IconButton(
              icon: const Icon(
                Icons.checklist_rounded,
                color: Colors.white,
                size: 28,
              ),
              onPressed: () {},
            ),
          ),
        ],
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.only(
          top: 16,
          left: 24,
          right: 24,
          bottom: 120,
        ),
        children: [
          _buildNotifItem(
            title: "Siap Ambil di Depan Pintu! 🚀",
            message:
                "Kurir WashIt sudah sampai di titik penjemputan. Tolong siapkan cucian besihmu, ya!",
            time: "Baru saja",
            isNew: true,
            icon: Icons.electric_moped_rounded,
            color: const Color(0xFF00E5FF),
          ),
          const SizedBox(height: 16),
          _buildNotifItem(
            title: "Cucian Selesai Diproses ✨",
            message:
                "Pakaianmu sudah selesai dicuci, dikeringkan, dan disetrika dengan rapi.",
            time: "2 jam yang lalu",
            isNew: false,
            icon: Icons.auto_awesome_rounded,
            color: const Color(0xFF00FFA3),
          ),
          const SizedBox(height: 16),
          _buildNotifItem(
            title: "Promo Flash Sale! 🎉",
            message:
                "Diskon cuci sepatu 50% khusus hari ini, mulai jam 12 siang. Jangan sampai kehabisan slot!",
            time: "Kemarin",
            isNew: false,
            icon: Icons.celebration_rounded,
            color: const Color(0xFFFFB000),
          ),
        ],
      ),
    );
  }

  Widget _buildNotifItem({
    required String title,
    required String message,
    required String time,
    required bool isNew,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Color(0xFF111111), // All white, looks cleaner
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.04),
            blurRadius: 20,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: color.withOpacity(0.12),
              borderRadius: BorderRadius.circular(16),
            ),
            child: Icon(icon, color: color, size: 26),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: TextStyle(
                          fontWeight: isNew ? FontWeight.w900 : FontWeight.w700,
                          fontSize: 15,
                          color: Colors.white,
                        ),
                      ),
                    ),
                    if (isNew)
                      Container(
                        height: 10,
                        width: 10,
                        decoration: const BoxDecoration(
                          color: Color(0xFF00E5FF),
                          shape: BoxShape.circle,
                        ),
                      ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  message,
                  style: TextStyle(
                    color: Color(0xFFA1A1AA),
                    fontSize: 14,
                    height: 1.4,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  time,
                  style: TextStyle(
                    color: Color(0xFF71717A),
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                  ),
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
// PROFILE PAGE FULL - PREMIUM
// ==========================================
class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF000000),
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: 280, // Very tall for the profile cover
            floating: false,
            pinned: true,
            elevation: 0,
            backgroundColor: const Color(0xFF000000),
            flexibleSpace: FlexibleSpaceBar(
              background: Column(
                mainAxisAlignment:
                    MainAxisAlignment.end, // Push content to bottom
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.15),
                          blurRadius: 30,
                          offset: const Offset(0, 10),
                        ),
                      ],
                    ),
                    child: const CircleAvatar(
                      radius: 54, // Huge avatar
                      backgroundImage: NetworkImage(
                        'https://i.pravatar.cc/150?img=60',
                      ), // Updated Avatar
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Asit",
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.w900,
                      color: Colors.white,
                      letterSpacing: -0.5,
                    ),
                  ), // Name is ASIT
                  const SizedBox(height: 6),
                  Text(
                    "asit@premium.washit",
                    style: TextStyle(
                      color: Color(0xFFA1A1AA),
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 14,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white, // Dark mode badge
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.white.withOpacity(0.3),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: const Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.stars_rounded,
                          color: Color(0xFFFCD34D),
                          size: 16,
                        ),
                        SizedBox(width: 6),
                        Text(
                          "PRO MEMBER",
                          style: TextStyle(
                            color: Color(0xFF111111),
                            fontSize: 12,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 1,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20), // Padding from bottom of app bar
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.only(left: 24, right: 24, bottom: 130),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  _buildWalletCard(),
                  const SizedBox(height: 32),
                  const Text(
                    "Akun Saya",
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildMenuSection([
                    _MenuData(
                      Icons.location_on_rounded,
                      "Alamat Tersimpan",
                      "3 Alamat",
                    ),
                    _MenuData(
                      Icons.account_balance_wallet_rounded,
                      "Metode Pembayaran",
                      "GoPay",
                    ),
                    _MenuData(
                      Icons.local_offer_rounded,
                      "Kupon Promo",
                      "5 Tersedia",
                      iconColor: const Color(0xFFFFB000),
                    ),
                  ]),
                  const SizedBox(height: 32),
                  const Text(
                    "Lainnya",
                    style: TextStyle(
                      fontWeight: FontWeight.w900,
                      fontSize: 18,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 16),
                  _buildMenuSection([
                    _MenuData(
                      Icons.headset_mic_rounded,
                      "Pusat Bantuan CS",
                      "",
                    ),
                    _MenuData(
                      Icons.settings_rounded,
                      "Pengaturan Aplikasi",
                      "",
                    ),
                    _MenuData(
                      Icons.logout_rounded,
                      "Keluar Akun",
                      "",
                      textColor: const Color(0xFFEF4444),
                      iconColor: const Color(0xFFEF4444),
                    ),
                  ]),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWalletCard() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Colors.white, Colors.white], // Dark slate gradient
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.3),
            blurRadius: 25,
            offset: const Offset(0, 15),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.account_balance_wallet_rounded,
                    color: Color(0xFF111111),
                    size: 20,
                  ),
                  const SizedBox(width: 8),
                  Text(
                    "WashPay Saldo",
                    style: TextStyle(
                      color: Color(0xFF111111).withOpacity(0.8),
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Text(
                "Rp 245.000",
                style: TextStyle(
                  color: Color(0xFF111111),
                  fontSize: 26,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ],
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
            decoration: BoxDecoration(
              color: const Color(0xFF00E5FF), // Bright blue contrast
              borderRadius: BorderRadius.circular(16),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF00E5FF).withOpacity(0.4),
                  blurRadius: 15,
                  offset: const Offset(0, 5),
                ),
              ],
            ),
            child: const Text(
              "Top Up",
              style: TextStyle(
                color: Color(0xFF111111),
                fontWeight: FontWeight.w900,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMenuSection(List<_MenuData> items) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFF111111),
        borderRadius: BorderRadius.circular(32), // Squircle
        boxShadow: [
          BoxShadow(
            color: Colors.white.withOpacity(0.03),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Column(
        children: items.asMap().entries.map((entry) {
          int idx = entry.key;
          _MenuData val = entry.value;
          return Column(
            children: [
              ListTile(
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 8,
                ), // More generous padding
                leading: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: val.iconColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(val.icon, color: val.iconColor, size: 22),
                ),
                title: Text(
                  val.title,
                  style: TextStyle(
                    fontWeight: FontWeight.w800,
                    color: val.textColor,
                    fontSize: 15,
                  ),
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (val.subtitle.isNotEmpty)
                      Text(
                        val.subtitle,
                        style: TextStyle(
                          color: Color(0xFF71717A),
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    if (val.subtitle.isNotEmpty) const SizedBox(width: 12),
                    Icon(
                      Icons.arrow_forward_ios_rounded,
                      size: 16,
                      color: Color(0xFF3F3F46),
                    ),
                  ],
                ),
                onTap: () {},
              ),
              if (idx != items.length - 1)
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Divider(height: 1, color: Color(0xFF27272A)),
                ),
            ],
          );
        }).toList(),
      ),
    );
  }
}

class _MenuData {
  final IconData icon;
  final String title;
  final String subtitle;
  final Color textColor;
  final Color iconColor;

  _MenuData(
    this.icon,
    this.title,
    this.subtitle, {
    this.textColor = Colors.white,
    this.iconColor = const Color(0xFFA1A1AA),
  });
}
