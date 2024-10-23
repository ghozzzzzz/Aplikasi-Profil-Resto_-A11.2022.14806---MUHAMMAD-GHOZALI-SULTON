import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MainApp());
}

class MainApp extends StatelessWidget {
  final biodata = <String, String>{};

  MainApp({super.key}) {
    biodata['name'] = 'Lamongan Pak Vincent';
    biodata['email'] = '111202214806@mhs.dinus.ac.id';
    biodata['phone'] = '+625163104423';
    biodata['image'] = 'assets/Logo.jpg';
    biodata['addr'] =
        'Jl. Imam Bonjol No.207, Pendrikan Kidul, Kec. Semarang Tengah, Kota Semarang, Jawa Tengah';
    biodata['desc'] =
        'Tempat makan yang menyajikan segala jenis nasi bungkus, khususnya isinya 2';
    biodata['menu'] =
        'Nasi Bungkus Suka Suka, Nasi Bungkus Otak-otak, Nasi Bungkus Isi Ikan Hidup';
    biodata['hours'] = 'Senin - Sabtu : 10:00 - 22:00';
    biodata['hours2'] = 'Minggu : 11:00 - 20:00';
  }

  Expanded btnContact(IconData icon, var color, void Function() onPressed) {
    return Expanded(
      child: ElevatedButton(
        onPressed: onPressed,
        child: Icon(icon, size: 30),
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          backgroundColor: color,
          padding: EdgeInsets.all(20),
          foregroundColor: Colors.white,
        ),
      ),
    );
  }

  Widget textAttribute(String judul, Widget content) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '$judul:',
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
        SizedBox(height: 5),
        content,
        SizedBox(height: 10),
      ],
    );
  }

  Widget menuList(String menuItems) {
    List<String> items = menuItems.split(', ');
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items.map((item) {
        return Row(
          children: [
            Text("• ", style: TextStyle(fontSize: 18)), // Bullet point
            Expanded(child: Text(item, style: TextStyle(fontSize: 18))),
          ],
        );
      }).toList(),
    );
  }

  Widget hoursList(String hours, String hours2) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text("• ", style: TextStyle(fontSize: 18)), // Bullet point
            Expanded(child: Text(hours, style: TextStyle(fontSize: 18))),
          ],
        ),
        Row(
          children: [
            Text("• ", style: TextStyle(fontSize: 18)), // Bullet point
            Expanded(child: Text(hours2, style: TextStyle(fontSize: 18))),
          ],
        ),
      ],
    );
  }

  void _launchEmail() async {
    final Uri params = Uri(
      scheme: 'mailto',
      path: biodata['email'],
      query: 'subject=Tanya Seputar Resto',
    );
    var url = params.toString();
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _launchPhone() async {
    var url = 'tel:${biodata['phone']}';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _launchMap() async {
    const lat = '-6.981848757020565';
    const long = '110.41015494123249';
    var url = 'https://www.google.com/maps/search/?api=1&query=$lat,$long';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Profil Restoran",
      home: Scaffold(
        body: SingleChildScrollView(
          padding: EdgeInsets.all(10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Nama Resto
              Container(
                padding: EdgeInsets.all(10),
                alignment: Alignment.center,
                width: double.infinity,
                decoration: BoxDecoration(color: Colors.black),
                child: Text(
                  biodata['name'] ?? '',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                    color: Colors.white,
                  ),
                ),
              ),
              // Gambar Profil
              Image(image: AssetImage(biodata['image'] ?? '')),
              SizedBox(height: 20),
              // Baris icon kontak di tengah
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  btnContact(Icons.email, Colors.green[900], _launchEmail),
                  btnContact(Icons.phone, Colors.blueAccent, _launchPhone),
                  btnContact(Icons.map, Colors.deepPurple, _launchMap),
                ],
              ),
              SizedBox(
                  height: 30), // Jarak lebih besar antara ikon dan deskripsi
              // Teks Deskripsi (Mulai baris baru setelah titik dua)
              textAttribute(
                'Deskripsi',
                Text(biodata['desc'] ?? '', style: TextStyle(fontSize: 18)),
              ),
              // Teks Menu (dalam bentuk list vertikal)
              textAttribute(
                'List Menu',
                menuList(biodata['menu'] ?? ''),
              ),
              // Teks Alamat (Mulai baris baru setelah titik dua)
              textAttribute(
                'Alamat',
                Text(biodata['addr'] ?? '', style: TextStyle(fontSize: 18)),
              ),
              // Jam Buka (dengan dua baris, mulai setelah titik dua)
              textAttribute(
                'Jam Buka',
                hoursList(biodata['hours'] ?? '', biodata['hours2'] ?? ''),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
