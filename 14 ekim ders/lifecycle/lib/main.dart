import 'package:flutter/material.dart';

void main() => runApp(const MaterialApp(home: Ana()));

// Ana sayfa: Demo'yu göster/gizle
class Ana extends StatefulWidget {
  const Ana({super.key});
  @override
  State<Ana> createState() => _AnaState();
}

class _AnaState extends State<Ana> {
  bool goster = true;
  int deger = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (goster) Demo(deger: deger),
          ElevatedButton(
            onPressed: () => setState(() => deger++),
            child: const Text('Değeri artır'),
          ),
          ElevatedButton(
            onPressed: () => setState(() => goster = !goster),
            child: const Text('Göster / Gizle'),
          ),
        ],
      ),
    );
  }
}

// Asıl demo widget
class Demo extends StatefulWidget {
  final int deger;
  const Demo({super.key, required this.deger});

  @override
  State<Demo> createState() {
    print('1) createState');
    return _DemoState();
  }
}

class _DemoState extends State<Demo> {
  int tik = 0;

  @override
  void initState() {
    super.initState();
    print('2) initState');
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    print('3) didChangeDependencies');
  }

  @override
  void didUpdateWidget(covariant Demo oldWidget) {
    super.didUpdateWidget(oldWidget);
    print('   didUpdateWidget: ${oldWidget.deger} → ${widget.deger}');
  }

  @override
  Widget build(BuildContext context) {
    print('4) build');
    return TextButton(
      onPressed: () => setState(() => tik++),
      child: Text('Değer: ${widget.deger} | Tık: $tik'),
    );
  }

  @override
  void deactivate() {
    print('5) deactivate');
    super.deactivate();
  }

  @override
  void dispose() {
    print('6) dispose');
    super.dispose();
  }
}