import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_styles.dart';
import '../models/note_model.dart';
import '../widgets/note_card.dart';
import '../widgets/category_filter.dart';
import '../widgets/bottom_navbar.dart';
import 'add_note_screen.dart';
import 'detail_note_screen.dart';
import 'archive_screen.dart';
import 'profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentNavIndex = 0;
  NoteCategory _selectedCategory = NoteCategory.semua;
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  // ignore: prefer_final_fields
  List<NoteModel> _notes = List.from(dummyNotes);

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<NoteModel> get _filteredNotes {
    List<NoteModel> filtered =
        _notes.where((n) => !n.isArchived).toList();

    if (_selectedCategory != NoteCategory.semua) {
      filtered = filtered
          .where((n) => n.category == _selectedCategory)
          .toList();
    }

    if (_searchQuery.isNotEmpty) {
      filtered = filtered
          .where((n) =>
              n.title.toLowerCase().contains(_searchQuery.toLowerCase()) ||
              n.content.toLowerCase().contains(_searchQuery.toLowerCase()))
          .toList();
    }

    return filtered;
  }

  String _formatTodayDate() {
    const days = [
      'Senin', 'Selasa', 'Rabu', 'Kamis', 'Jumat', 'Sabtu', 'Minggu'
    ];
    const months = [
      'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
      'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'
    ];
    final now = DateTime.now();
    return '${days[now.weekday - 1]}, ${now.day} ${months[now.month - 1]} ${now.year}';
  }

  void _deleteNote(String id) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: const Text('Hapus Catatan',
            style: TextStyle(
                fontFamily: AppStyles.fontFamily,
                fontWeight: FontWeight.w600)),
        content: const Text(
            'Apakah kamu yakin ingin menghapus catatan ini?',
            style: TextStyle(fontFamily: AppStyles.fontFamily)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Batal',
                style: TextStyle(
                    fontFamily: AppStyles.fontFamily,
                    color: AppColors.textSecondary)),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() => _notes.removeWhere((n) => n.id == id));
              Navigator.pop(ctx);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Catatan berhasil dihapus',
                      style: TextStyle(fontFamily: AppStyles.fontFamily)),
                  backgroundColor: AppColors.error,
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
            ),
            child: const Text('Hapus',
                style: TextStyle(
                    fontFamily: AppStyles.fontFamily, color: Colors.white)),
          ),
        ],
      ),
    );
  }

  void _archiveNote(String id) {
    setState(() {
      final idx = _notes.indexWhere((n) => n.id == id);
      if (idx != -1) {
        _notes[idx] = _notes[idx].copyWith(isArchived: true);
      }
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Catatan dipindahkan ke arsip',
            style: TextStyle(fontFamily: AppStyles.fontFamily)),
        backgroundColor: AppColors.warning,
        behavior: SnackBarBehavior.floating,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    );
  }

  void _navigateToAddNote() async {
    final result = await Navigator.push<NoteModel>(
      context,
      MaterialPageRoute(builder: (_) => AddNoteScreen(notes: _notes)),
    );
    if (result != null) {
      setState(() => _notes.insert(0, result));
    }
  }

  void _navigateToEditNote(NoteModel note) async {
    final result = await Navigator.push<NoteModel>(
      context,
      MaterialPageRoute(
          builder: (_) => AddNoteScreen(notes: _notes, noteToEdit: note)),
    );
    if (result != null) {
      setState(() {
        final idx = _notes.indexWhere((n) => n.id == result.id);
        if (idx != -1) _notes[idx] = result;
      });
    }
  }

  void _navigateToDetail(NoteModel note) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => DetailNoteScreen(
          note: note,
          onEdit: _navigateToEditNote,
          onDelete: _deleteNote,
        ),
      ),
    );
  }

  Widget _buildHomePage() {
    return Scaffold(
      backgroundColor: AppColors.surface,
      body: SafeArea(
        bottom: false,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            Container(
              color: Colors.white,
              padding: const EdgeInsets.fromLTRB(20, 16, 20, 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: const [
                              Text(
                                'Halo, Ahmad ',
                                style: TextStyle(
                                  fontFamily: AppStyles.fontFamily,
                                  fontSize: 22,
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.textPrimary,
                                ),
                              ),
                              Text('👋', style: TextStyle(fontSize: 22)),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _formatTodayDate(),
                            style: const TextStyle(
                              fontFamily: AppStyles.fontFamily,
                              fontSize: 13,
                              color: AppColors.textSecondary,
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: 44,
                        height: 44,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                            colors: [AppColors.primary, AppColors.primaryDark],
                          ),
                          borderRadius: BorderRadius.circular(14),
                          boxShadow: [
                            BoxShadow(
                              color:
                                  AppColors.primary.withValues(alpha: 0.3),
                              blurRadius: 8,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: const Icon(Icons.person_rounded,
                            color: Colors.white, size: 24),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  // Search Bar
                  TextField(
                    controller: _searchController,
                    onChanged: (val) =>
                        setState(() => _searchQuery = val),
                    style: const TextStyle(
                      fontFamily: AppStyles.fontFamily,
                      fontSize: 14,
                      color: AppColors.textPrimary,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Cari catatan...',
                      hintStyle: const TextStyle(
                        fontFamily: AppStyles.fontFamily,
                        fontSize: 14,
                        color: AppColors.textHint,
                      ),
                      prefixIcon: const Icon(Icons.search_rounded,
                          color: AppColors.textSecondary, size: 22),
                      suffixIcon: _searchQuery.isNotEmpty
                          ? IconButton(
                              icon: const Icon(Icons.close_rounded,
                                  size: 18,
                                  color: AppColors.textSecondary),
                              onPressed: () {
                                _searchController.clear();
                                setState(() => _searchQuery = '');
                              },
                            )
                          : null,
                      filled: true,
                      fillColor: AppColors.surface,
                      contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 14),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: BorderSide.none,
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: const BorderSide(
                            color: AppColors.border, width: 1),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(14),
                        borderSide: const BorderSide(
                            color: AppColors.primary, width: 1.5),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 16),
            CategoryFilter(
              selectedCategory: _selectedCategory,
              onCategorySelected: (cat) =>
                  setState(() => _selectedCategory = cat),
            ),
            const SizedBox(height: 12),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    '${_filteredNotes.length} Catatan',
                    style: const TextStyle(
                      fontFamily: AppStyles.fontFamily,
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const Icon(Icons.filter_list_rounded,
                      color: AppColors.textSecondary, size: 20),
                ],
              ),
            ),
            const SizedBox(height: 8),

            // Notes List
            Expanded(
              child: _filteredNotes.isEmpty
                  ? _buildEmptyState()
                  : ListView.builder(
                      padding: const EdgeInsets.only(bottom: 100),
                      itemCount: _filteredNotes.length,
                      itemBuilder: (ctx, i) {
                        final note = _filteredNotes[i];
                        return NoteCard(
                          note: note,
                          onTap: () => _navigateToDetail(note),
                          onEdit: () => _navigateToEditNote(note),
                          onDelete: () => _deleteNote(note.id),
                          onArchive: () => _archiveNote(note.id),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _navigateToAddNote,
        backgroundColor: AppColors.primary,
        elevation: 4,
        child: const Icon(Icons.add_rounded, color: Colors.white, size: 28),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: AppColors.primaryLight,
              borderRadius: BorderRadius.circular(24),
            ),
            child: const Icon(Icons.note_alt_outlined,
                size: 40, color: AppColors.primary),
          ),
          const SizedBox(height: 16),
          Text(
            _searchQuery.isNotEmpty
                ? 'Tidak ada catatan ditemukan'
                : 'Belum ada catatan',
            style: const TextStyle(
              fontFamily: AppStyles.fontFamily,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            _searchQuery.isNotEmpty
                ? 'Coba kata kunci yang berbeda'
                : 'Ketuk tombol + untuk membuat\ncatatan pertamamu!',
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontFamily: AppStyles.fontFamily,
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      _buildHomePage(),
      ArchiveScreen(
        notes: _notes,
        onUnarchive: (id) {
          setState(() {
            final idx = _notes.indexWhere((n) => n.id == id);
            if (idx != -1) {
              _notes[idx] = _notes[idx].copyWith(isArchived: false);
            }
          });
        },
        onDelete: _deleteNote,
      ),
      const ProfileScreen(),
    ];

    return Scaffold(
      body: IndexedStack(
        index: _currentNavIndex,
        children: pages,
      ),
      bottomNavigationBar: BottomNavbar(
        currentIndex: _currentNavIndex,
        onTap: (i) => setState(() => _currentNavIndex = i),
      ),
    );
  }
}
