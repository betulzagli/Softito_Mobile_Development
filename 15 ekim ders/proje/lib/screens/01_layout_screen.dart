import 'package:flutter/material.dart';

class LayoutStylingScreen extends StatefulWidget {
  const LayoutStylingScreen({super.key});

  @override
  State<LayoutStylingScreen> createState() => _LayoutStylingScreen();
}

class _LayoutStylingScreen extends State<LayoutStylingScreen> {
  bool _isBalanceVisible = true;
  String _lastAction = 'Hazır - Butonlara tıklayabilirsiniz.';

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.only(bottom: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          //profil bölümü ve online rozet
          _buildProfileHeader(),
          //cüzdan kartı
          _buildWalletCard(),
          //aksiyon butonları
          _builQuickActions(),
          //istatistik bölümü
          _buildFlexStatictics(),
          //bildirim banner
          _buildNotificationBanner(),

          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Son İşlem . $_lastAction',
                style: const TextStyle(
                  fontSize: 13,
                  color: Color(0xFF64748B),
                  fontStyle: FontStyle.italic,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /*
  Widget _buildProfileHeader() {
    return Padding(
      padding: const EdgeInsetsGeometry.fromLTRB(20, 16, 20, 8),
      child: Row(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: const Color(0x1F6366F1),
                  border: Border.all(color: const Color(0xFF6366F1), width: 2),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
*/

// 1. Profil Bölümü ve Online Rozeti
  Widget _buildProfileHeader() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              Stack(
                children: [
                  const CircleAvatar(
                    radius: 28,
                    backgroundColor: Color(0xFFE2E8F0),
                    child: Icon(Icons.person, size: 32, color: Color(0xFF64748B)),
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 14,
                      height: 14,
                      decoration: BoxDecoration(
                        color: const Color(0xFF22C55E),
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2.5),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(width: 14),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    'Hoş Geldiniz 👋',
                    style: TextStyle(fontSize: 13, color: Color(0xFF64748B)),
                  ),
                  SizedBox(height: 4),
                  Text(
                    'Ahmet Yılmaz',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1E293B),
                    ),
                  ),
                ],
              ),
            ],
          ),
          IconButton(
            onPressed: () {
              setState(() => _lastAction = 'Bildirim zil butonuna tıklandı');
            },
            icon: const Icon(Icons.notifications_none_rounded, size: 28),
            color: const Color(0xFF1E293B),
          ),
        ],
      ),
    );
  }

  // 2. Cüzdan Kartı
  Widget _buildWalletCard() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [Color(0xFF4F46E5), Color(0xFF7C3AED)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(24),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF4F46E5).withOpacity(0.35),
            blurRadius: 18,
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
              const Text(
                'Toplam Bakiye',
                style: TextStyle(color: Colors.white70, fontSize: 14),
              ),
              IconButton(
                padding: EdgeInsets.zero,
                constraints: const BoxConstraints(),
                onPressed: () {
                  setState(() {
                    _isBalanceVisible = !_isBalanceVisible;
                    _lastAction = _isBalanceVisible ? 'Bakiye görünür yapıldı' : 'Bakiye gizlendi';
                  });
                },
                icon: Icon(
                  _isBalanceVisible ? Icons.visibility_outlined : Icons.visibility_off_outlined,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            _isBalanceVisible ? '₺ 48.750,50' : '₺ ••••••••',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                '**** 2458',
                style: TextStyle(color: Colors.white70, fontSize: 13, letterSpacing: 1.5),
              ),
              Text(
                '12/28',
                style: TextStyle(color: Colors.white70, fontSize: 13),
              ),
            ],
          ),
        ],
      ),
    );
  }

  // 3. Aksiyon Butonları
  Widget _builQuickActions() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildActionButton(
            icon: Icons.arrow_upward_rounded,
            label: 'Gönder',
            color: const Color(0xFFEEF2FF),
            iconColor: const Color(0xFF4F46E5),
            onTap: () => setState(() => _lastAction = 'Para Gönder tıklandı'),
          ),
          _buildActionButton(
            icon: Icons.arrow_downward_rounded,
            label: 'İste',
            color: const Color(0xFFECFDF5),
            iconColor: const Color(0xFF10B981),
            onTap: () => setState(() => _lastAction = 'Para İste tıklandı'),
          ),
          _buildActionButton(
            icon: Icons.qr_code_scanner_rounded,
            label: 'QR İşlem',
            color: const Color(0xFFFFFBEB),
            iconColor: const Color(0xFFF59E0B),
            onTap: () => setState(() => _lastAction = 'QR İşlem tıklandı'),
          ),
          _buildActionButton(
            icon: Icons.more_horiz_rounded,
            label: 'Diğer',
            color: const Color(0xFFF1F5F9),
            iconColor: const Color(0xFF475569),
            onTap: () => setState(() => _lastAction = 'Diğer İşlemler tıklandı'),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return Column(
      children: [
        InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(18),
          child: Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(18),
            ),
            child: Icon(icon, color: iconColor, size: 24),
          ),
        ),
        const SizedBox(height: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w600,
            color: Color(0xFF475569),
          ),
        ),
      ],
    );
  }

  // 4. İstatistik Bölümü
  Widget _buildFlexStatictics() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      child: Row(
        children: [
          Expanded(
            child: _buildStatItem(
              title: 'Aylık Gelir',
              amount: '₺ 24.300',
              trend: '+12%',
              isPositive: true,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: _buildStatItem(
              title: 'Aylık Gider',
              amount: '₺ 8.940',
              trend: '-4%',
              isPositive: false,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatItem({
    required String title,
    required String amount,
    required String trend,
    required bool isPositive,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFE2E8F0)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(fontSize: 12, color: Color(0xFF64748B))),
              Text(
                trend,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: isPositive ? const Color(0xFF10B981) : const Color(0xFFEF4444),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            amount,
            style: const TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0F172A),
            ),
          ),
        ],
      ),
    );
  }

  // 5. Bildirim Banner
  Widget _buildNotificationBanner() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: const Color(0xFFEFF6FF),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: const Color(0xFFBFDBFE)),
      ),
      child: Row(
        children: [
          const Icon(Icons.info_outline_rounded, color: Color(0xFF2563EB), size: 24),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Text(
                  'Hesap Doğrulaması',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF1E3A8A),
                  ),
                ),
                SizedBox(height: 2),
                Text(
                  'Limitlerinizi artırmak için kimlik doğrulamasını tamamlayın.',
                  style: TextStyle(fontSize: 11.5, color: Color(0xFF3B82F6)),
                ),
              ],
            ),
          ),
          TextButton(
            onPressed: () {
              setState(() => _lastAction = 'Doğrula butonuna tıklandı');
            },
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              minimumSize: Size.zero,
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: const Text('Doğrula', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}