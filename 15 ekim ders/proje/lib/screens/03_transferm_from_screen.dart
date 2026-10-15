import 'package:flutter/material.dart';
import '../models/transation.dart'; // Dosya adınız transation.dart ise ona göre düzeltin.

class TransferFromScreen extends StatefulWidget {
  const TransferFromScreen({super.key});

  @override
  State<TransferFromScreen> createState() => _TransferFromScreenState();
}

class _TransferFromScreenState extends State<TransferFromScreen> {
  double _balance = 148950.00;

  final List<TransactionItem> _history = [
    const TransactionItem(
      id: 'tx_init_1',
      title: 'Ahmet Yılmaz',
      category: 'Hızlı transfer',
      date: 'bugün 11.30',
      amount: 1500,
      isExpense: true,
      icon: Icons.send_rounded,
    ),
    const TransactionItem(
      id: "tx_init_2",
      title: "Merve Demir",
      category: 'Hızlı transfer',
      date: 'dün 15.45',
      amount: 240000,
      isExpense: true,
      icon: Icons.send_rounded,
    ),
  ];

  // Transfer işlemi için gerekli TextController'lar
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();

  void _submitData() {
    final enteredTitle = _titleController.text;
    final enteredAmount = double.tryParse(_amountController.text) ?? 0.0;

    if (enteredTitle.isEmpty || enteredAmount <= 0 || enteredAmount > _balance) {
      // Geçersiz veri veya yetersiz bakiye durumu
      return;
    }

    // Yeni işlemi oluştur
    final newTx = TransactionItem(
      id: DateTime.now().toString(),
      title: enteredTitle,
      category: 'Yeni transfer',
      date: 'şimdi',
      amount: enteredAmount,
      isExpense: true,
      icon: Icons.send_rounded,
    );

    setState(() {
      _history.insert(0, newTx); // Listeye en başa ekle
      _balance -= enteredAmount; // Bakiyeden düş
    });

    Navigator.of(context).pop(); // Alt pencereyi kapat
    
    // Controller'ları temizle
    _titleController.clear();
    _amountController.clear();
  }

  void _openTransferModel() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Klavyenin alanını hesaba katması için
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext ctx) {
        return Padding(
          padding: EdgeInsets.only(
            top: 20,
            left: 20,
            right: 20,
            bottom: MediaQuery.of(ctx).viewInsets.bottom + 20, // Klavye boşluğu
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Text(
                'Yeni Para Transferi',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              TextField(
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Alıcı Adı Soyadı',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 15),
              TextField(
                controller: _amountController,
                decoration: const InputDecoration(
                  labelText: 'Tutar (TL)',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _submitData,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: const Text('Gönder'),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Para Transferi'),
        backgroundColor: Colors.blue.shade800,
        foregroundColor: Colors.white,
      ),
      body: Column(
        children: [
          // Bakiye Gösterge Alanı
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(30),
            color: Colors.blue.shade800,
            child: Column(
              children: [
                const Text(
                  'Kullanılabilir Bakiye',
                  style: TextStyle(color: Colors.white70, fontSize: 16),
                ),
                const SizedBox(height: 10),
                Text(
                  '₺${_balance.toStringAsFixed(2)}',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 36,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          
          // İşlem Geçmişi Başlığı
          const Padding(
            padding: EdgeInsets.all(15.0),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Geçmiş İşlemler',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          
          // İşlem Listesi
          Expanded(
            child: ListView.builder(
              itemCount: _history.length,
              itemBuilder: (context, index) {
                final tx = _history[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: tx.isExpense ? Colors.red.shade100 : Colors.green.shade100,
                    child: Icon(
                      tx.icon,
                      color: tx.isExpense ? Colors.red : Colors.green,
                    ),
                  ),
                  title: Text(tx.title, style: const TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text('${tx.category} • ${tx.date}'),
                  trailing: Text(
                    '${tx.isExpense ? "-" : "+"}₺${tx.amount.toStringAsFixed(2)}',
                    style: TextStyle(
                      color: tx.isExpense ? Colors.red : Colors.green,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      
      // Transfer Butonu
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _openTransferModel,
        icon: const Icon(Icons.swap_horiz),
        label: const Text('Transfer Yap'),
        backgroundColor: Colors.blue.shade800,
        foregroundColor: Colors.white,
      ),
    );
  }
}