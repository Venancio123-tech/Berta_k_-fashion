import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:url_launcher/url_launcher.dart';

Future<Map<String, dynamic>> loadConfig() async {
  final s = await rootBundle.loadString('config.json');
  return json.decode(s) as Map<String, dynamic>;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final cfg = await loadConfig();
  runApp(BertaApp(config: cfg));
}

class BertaApp extends StatelessWidget {
  final Map<String, dynamic> config;
  const BertaApp({Key? key, required this.config}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: config['app_name'] ?? 'A Elegância Feminina',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: HomePage(config: config),
    );
  }
}

class HomePage extends StatelessWidget {
  final Map<String, dynamic> config;
  HomePage({required this.config});

  final List<Map<String,String>> products = [
    {'name':'Vestido Floral','price':'AOA 12,000','image':'assets/products/p1.png'},
    {'name':'Blusa Casual','price':'AOA 4,500','image':'assets/products/p2.png'},
    {'name':'Saia Midi','price':'AOA 6,800','image':'assets/products/p3.png'},
  ];

  @override
  Widget build(BuildContext context) {
    final brand = config['brand_name'] ?? '';
    final contact = config['contact'] ?? '';
    return Scaffold(
      appBar: AppBar(title: Text(config['app_name'] ?? 'A Elegância Feminina')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Image.asset(config['logo'] ?? 'assets/logo.png', height: 120),
          ),
          Expanded(
            child: GridView.builder(
              padding: EdgeInsets.all(12),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2, childAspectRatio: 0.7, crossAxisSpacing: 12, mainAxisSpacing: 12),
              itemCount: products.length,
              itemBuilder: (context, index) {
                final p = products[index];
                return Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Expanded(child: Image.asset(p['image']!, fit: BoxFit.cover)),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(p['name']!, style: TextStyle(fontWeight: FontWeight.bold)),
                            SizedBox(height: 4),
                            Text(p['price']!),
                            SizedBox(height: 8),
                            ElevatedButton.icon(
                              onPressed: () => _launchWhatsApp(contact),
                              icon: Icon(Icons.chat_bubble),
                              label: Text('Contacto'),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 8),
          TextButton(
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (_) => AboutPage(config: config))),
            child: Text('Sobre'),
          ),
          SizedBox(height: 12)
        ],
      ),
    );
  }

  void _launchWhatsApp(String phone) async {
    final p = phone.replaceAll('+','').replaceAll(' ','');
    final url = Uri.parse('https://wa.me/' + p);
    if (await canLaunchUrl(url)) await launchUrl(url);
  }
}

class AboutPage extends StatelessWidget {
  final Map<String,dynamic> config;
  AboutPage({required this.config});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sobre')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(config['brand_name'] ?? 'Berta K Fashion', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            SizedBox(height: 12),
            Text('A Elegância Feminina é o espaço oficial da marca ${config['brand_name'] ?? 'Berta K Fashion'}, dedicada à moda feminina contemporânea.'),
            SizedBox(height: 20),
            ElevatedButton.icon(
              onPressed: () => Navigator.pop(context),
              icon: Icon(Icons.arrow_back),
              label: Text('Voltar')
            )
          ],
        ),
      ),
    );
  }
}
