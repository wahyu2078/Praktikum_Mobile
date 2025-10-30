// lib/routes.dart

import 'package:flutter/material.dart';
import 'profile_page.dart'; // Asumsikan Anda membuat file ini
import 'gallery_page.dart'; // Asumsikan Anda membuat file ini

final Map<String, WidgetBuilder> routes = {
  '/': (context) => ProfilePage(), // Halaman awal adalah halaman profil
  '/gallery': (context) => GalleryPage(),
};
