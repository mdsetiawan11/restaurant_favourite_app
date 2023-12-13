import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class InfoScreen extends StatelessWidget {
  const InfoScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              children: [
                const SizedBox(
                  height: 20,
                ),
                Lottie.asset(
                  'assets/developer.json',
                  width: 200,
                  height: 200,
                  fit: BoxFit.fill,
                ),
                const Text(
                  'Aplikasi dibuat oleh Muhammad Dadang Setiawan untuk memenuhi tugas proyek 3 pada kelas Belajar Fundamental Aplikasi Flutter - Dicoding.com',
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          )),
    );
  }
}
