import 'package:flutter/material.dart';

import '../models/asset_model.dart';
import '../models/transation.dart';

class MarketsListScreen extends StatelessWidget {
  const MarketsListScreen({super.key});

  static const List<Asset> assets = [
    Asset(
      symbol: 'BTC',
      name: 'Bitcoin',
      price: 67420.00,
      change24h: 4.20,
      balance: 0.4,
    ),
    Asset(
      symbol: 'ETH',
      name: 'Etherium',
      price: 3500,
      change24h: -1.80,
      balance: 4.20,
    ),
    Asset(
      symbol: 'Sol',
      name: 'Solana',
      price: 200,
      change24h: 0.5,
      balance: 85,
    ),
  ];

  static const List<TransactionItem> transations = [
    TransactionItem(
      id: 'tx_1',
      title: 'Apple Store',
      category: 'Teknoloji',
      date: 'bugün 14.20',
      amount: 64500,
      isExpense: true,
      icon: Icons.laptop_mac,
    ),
    TransactionItem(
      id: 'tx_2',
      title: 'Kodusta Danışmanlık Hakediş',
      category: 'Kurumsal Gelir',
      date: 'dün 09.00',
      amount: 125000,
      isExpense: false,
      icon: Icons.account_balance,
    ),
    TransactionItem(
      id: 'tx_3',
      title: 'Kodusta Danışmanlık Hakediş',
      category: 'Kurumsal Gelir',
      date: 'dün 09.00',
      amount: 125000,
      isExpense: false,
      icon: Icons.account_balance,
    ),
    TransactionItem(
      id: 'tx_4',
      title: 'Kodusta Danışmanlık Hakediş',
      category: 'Kurumsal Gelir',
      date: 'dün 09.00',
      amount: 125000,
      isExpense: false,
      icon: Icons.account_balance,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: const Text(
          'Piyasalar ve Hareketler',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: Color(0xFF0F172A),
          ),
        ),
        elevation: 0,
        backgroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Kripto Varlıklar Başlığı
            _buildSectionHeader(title: 'Kripto Varlıklar', actionText: 'Tümü'),
            const SizedBox(height: 12),
            _buildAssetCardsSection(),

            const SizedBox(height: 28),

            // Son İşlemler Başlığı
            _buildSectionHeader(title: 'Son İşlemler', actionText: 'Filtrele'),
            const SizedBox(height: 12),
            _buildTransactionsSection(),
          ],
        ),
      ),
    );
  }

  // Bölüm Başlığı
  Widget _buildSectionHeader({
    required String title,
    required String actionText,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Color(0xFF0F172A),
            ),
          ),
          Text(
            actionText,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: Color(0xFF2563EB),
            ),
          ),
        ],
      ),
    );
  }

  // Kripto Varlık Kartları (Yatay Liste)
  Widget _buildAssetCardsSection() {
    return SizedBox(
      height: 155,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: assets.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final asset = assets[index];
          final bool isGain = asset.change24h >= 0;
          final double totalValue = asset.balance * asset.price;

          return Container(
            width: 180,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: const Color(0xFFE2E8F0)),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      asset.symbol,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
                      decoration: BoxDecoration(
                        color: isGain ? const Color(0xFFDCFCE7) : const Color(0xFFFEE2E2),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        '${isGain ? '+' : ''}${asset.change24h.toStringAsFixed(2)}%',
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.bold,
                          color: isGain ? const Color(0xFF15803D) : const Color(0xFFB91C1C),
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  asset.name,
                  style: const TextStyle(fontSize: 12, color: Color(0xFF64748B)),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '\$${asset.price.toStringAsFixed(2)}',
                      style: const TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color: Color(0xFF0F172A),
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${asset.balance} ${asset.symbol} (~\$${totalValue.toStringAsFixed(0)})',
                      style: const TextStyle(fontSize: 11, color: Color(0xFF94A3B8)),
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  // Son İşlemler (Dikey Liste)
  Widget _buildTransactionsSection() {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: transations.length,
      separatorBuilder: (_, __) => const SizedBox(height: 10),
      itemBuilder: (context, index) {
        final tx = transations[index];

        return Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: const Color(0xFFF1F5F9)),
          ),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: tx.isExpense ? const Color(0xFFFEF2F2) : const Color(0xFFF0FDF4),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  tx.icon,
                  size: 22,
                  color: tx.isExpense ? const Color(0xFFEF4444) : const Color(0xFF16A34A),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tx.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF1E293B),
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      '${tx.category} • ${tx.date}',
                      style: const TextStyle(fontSize: 11.5, color: Color(0xFF64748B)),
                    ),
                  ],
                ),
              ),
              Text(
                '${tx.isExpense ? '-' : '+'}₺${tx.amount.toStringAsFixed(0)}',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: tx.isExpense ? const Color(0xFFDC2626) : const Color(0xFF16A34A),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}