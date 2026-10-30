import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_styles.dart';
import '../models/note_model.dart';
import '../widgets/note_card.dart';

class ArchiveScreen extends StatelessWidget {
  final List<NoteModel> notes;
  final Function(String) onUnarchive;
  final Function(String) onDelete;

  const ArchiveScreen({
    super.key,
    required this.notes,
    required this.onUnarchive,
    required this.onDelete,
  });

  List<NoteModel> get _archivedNotes =>
      notes.where((n) => n.isArchived).toList();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.surface,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: const Text(
          'Arsip',
          style: TextStyle(
            fontFamily: AppStyles.fontFamily,
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 16),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              decoration: BoxDecoration(
                color: AppColors.primaryLight,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                '${_archivedNotes.length} Catatan',
                style: const TextStyle(
                  fontFamily: AppStyles.fontFamily,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  color: AppColors.primary,
                ),
              ),
            ),
          ),
        ],
      ),
      body: _archivedNotes.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
              padding: const EdgeInsets.only(top: 12, bottom: 100),
              itemCount: _archivedNotes.length,
              itemBuilder: (ctx, i) {
                final note = _archivedNotes[i];
                return NoteCard(
                  note: note,
                  onTap: () {},
                  onEdit: () {},
                  onDelete: () => onDelete(note.id),
                  onArchive: () => onUnarchive(note.id),
                );
              },
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
            child: const Icon(
              Icons.archive_outlined,
              size: 40,
              color: AppColors.primary,
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Tidak ada catatan diarsipkan',
            style: TextStyle(
              fontFamily: AppStyles.fontFamily,
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Catatan yang diarsipkan akan\nmuncul di sini',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontFamily: AppStyles.fontFamily,
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
