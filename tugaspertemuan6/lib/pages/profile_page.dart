import 'package:flutter/material.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profil Mahasiswa'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Kartu profil dengan FlutterLogo dan foto profil
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.secondaryContainer,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Column(
                    children: [
                      const FlutterLogo(size: 64),
                      const SizedBox(height: 16),

                      ClipRRect(
                        borderRadius: BorderRadius.circular(80),
                        child: Image.network(
                          'assets/images/file.jpg',
                          width: 120,
                          height: 120,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) {
                            return const SizedBox(
                              width: 120,
                              height: 120,
                              child: Placeholder(),
                            );
                          },
                        ),
                      ),

                      const SizedBox(height: 16),
                      Text(
                        'Wahyu Trisnantoadi Prakoso',
                        style: Theme.of(context)
                            .textTheme
                            .titleLarge
                            ?.copyWith(fontWeight: FontWeight.w700),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'NIM: 2341760153',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      Text(
                        'Jurusan: Sistem Informasi',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 16),

                // Contoh Row + Icon + Text, dalam Container (padding, border, margin)
                Container(
                  padding: const EdgeInsets.all(16),
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceVariant,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.outlineVariant,
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.email, size: 24),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          'wahyutptp20@gmail.com',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                    
                    ],
                  ),
                ),

                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Theme.of(context).colorScheme.surfaceVariant,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: Theme.of(context).colorScheme.outlineVariant,
                    ),
                  ),
                  child: Row(
                    children: [
                      const Icon(Icons.phone, size: 24),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          '+62 895-3671-39439',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                     
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Contoh Container dengan gradient + Placeholder tambahan (mis. area portfolio/foto belum ada)
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.15),
                        Theme.of(context)
                            .colorScheme
                            .primary
                            .withOpacity(0.05),
                      ],
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Tentang',
                          style: Theme.of(context).textTheme.titleMedium),
                      const SizedBox(height: 8),
                      Text(
                        'Mahasiswa yang baik hati.',
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                      const SizedBox(height: 12),
                      // AspectRatio(
                      //   aspectRatio: 16 / 9,
                      //   child: Container(
                      //     decoration: BoxDecoration(
                      //       color: Theme.of(context).colorScheme.surface,
                      //       borderRadius: BorderRadius.circular(8),
                      //     ),
                      //     child: const Placeholder(),
                      //   ),
                      // ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
