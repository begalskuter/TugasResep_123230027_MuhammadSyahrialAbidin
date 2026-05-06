import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import '../models/favorite.dart';
import '../services/themealdb_service.dart';

class DetailView extends StatefulWidget {
  final String idMeal;

  const DetailView({super.key, required this.idMeal});

  @override
  State<DetailView> createState() => _DetailViewState();
}

class _DetailViewState extends State<DetailView> {
  final TheMealDBService _apiService = TheMealDBService();
  late Box<FavoriteRecipe> _favoriteBox;
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    // Membuka box hive untuk mengecek status favorit
    _favoriteBox = Hive.box<FavoriteRecipe>('favorites');
    _checkFavoriteStatus();
  }

  // Mengecek apakah resep ini sudah ada di dalam Hive
  void _checkFavoriteStatus() {
    setState(() {
      // Kita menggunakan idMeal sebagai key di Hive agar lebih mudah dicari
      _isFavorite = _favoriteBox.containsKey(widget.idMeal);
    });
  }

  // Fungsi untuk menambah/menghapus dari favorit
  void _toggleFavorite(Map<String, dynamic> recipe) {
    if (_isFavorite) {
      // Jika sudah favorit, hapus dari Hive
      _favoriteBox.delete(widget.idMeal);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Dihapus dari Favorit')),
      );
    } else {
      // Jika belum favorit, tambahkan ke Hive
      final newFavorite = FavoriteRecipe(
        idMeal: recipe['idMeal'],
        strMeal: recipe['strMeal'],
        strMealThumb: recipe['strMealThumb'],
      );
      // Simpan dengan idMeal sebagai key agar pencarian (CRUD) lebih efisien
      _favoriteBox.put(recipe['idMeal'], newFavorite);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Ditambahkan ke Favorit')),
      );
    }
    _checkFavoriteStatus(); // Update state tombol
  }

  // Fungsi bantuan untuk mengekstrak list bahan dari JSON API
  List<String> _getIngredients(Map<String, dynamic> recipe) {
    List<String> ingredients = [];
    for (int i = 1; i <= 20; i++) {
      final ingredient = recipe['strIngredient$i'];
      final measure = recipe['strMeasure$i'];

      if (ingredient != null && ingredient.toString().trim().isNotEmpty) {
        ingredients.add('${measure ?? ''} $ingredient'.trim());
      }
    }
    return ingredients;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Detail Resep'),
        backgroundColor: Colors.orange,
      ),
      body: FutureBuilder<Map<String, dynamic>?>(
        // Selalu fetch ulang berdasarkan ID setiap kali halaman dibuka
        future: _apiService.getRecipeDetail(widget.idMeal),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data == null) {
            return const Center(child: Text('Data resep tidak ditemukan.'));
          }

          final recipe = snapshot.data!;
          final ingredients = _getIngredients(recipe);

          return SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Gambar Resep
                Image.network(
                  recipe['strMealThumb'],
                  width: double.infinity,
                  height: 250,
                  fit: BoxFit.cover,
                ),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Nama Resep
                      Text(
                        recipe['strMeal'],
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Kategori dan Asal Negara (Tags)
                      Row(
                        children: [
                          Chip(
                            label: Text(recipe['strCategory']),
                            backgroundColor: Colors.orange.shade100,
                            avatar: const Icon(Icons.fastfood, size: 16),
                          ),
                          const SizedBox(width: 8),
                          Chip(
                            label: Text(recipe['strArea']),
                            backgroundColor: Colors.orange.shade100,
                            avatar: const Icon(Icons.public, size: 16),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      
                      // Tombol Favorit
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton.icon(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: _isFavorite ? Colors.red : Colors.orange,
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(vertical: 12),
                          ),
                          onPressed: () => _toggleFavorite(recipe),
                          icon: Icon(
                            _isFavorite ? Icons.favorite : Icons.favorite_border,
                          ),
                          label: Text(
                            _isFavorite ? 'Hapus dari Favorit' : 'Tambah ke Favorit',
                            style: const TextStyle(fontSize: 16),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),

                      // Daftar Bahan-bahan
                      const Text(
                        'Bahan-bahan',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      ...ingredients.map((ingredient) => Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4.0),
                            child: Row(
                              children: [
                                const Icon(Icons.circle, size: 8, color: Colors.orange),
                                const SizedBox(width: 8),
                                Expanded(child: Text(ingredient)),
                              ],
                            ),
                          )),
                      const SizedBox(height: 24),

                      // Cara Memasak
                      const Text(
                        'Cara Memasak',
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        recipe['strInstructions'] ?? 'Instruksi tidak tersedia.',
                        style: const TextStyle(height: 1.5),
                        textAlign: TextAlign.justify,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}