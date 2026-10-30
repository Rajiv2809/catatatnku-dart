import 'package:flutter/material.dart';
import '../constants/app_colors.dart';

enum NoteCategory { semua, penting, pribadi, kerja }

enum NotePriority { rendah, sedang, tinggi }

extension NoteCategoryExtension on NoteCategory {
  String get label {
    switch (this) {
      case NoteCategory.semua:
        return 'Semua';
      case NoteCategory.penting:
        return 'Penting';
      case NoteCategory.pribadi:
        return 'Pribadi';
      case NoteCategory.kerja:
        return 'Kerja';
    }
  }

  IconData get icon {
    switch (this) {
      case NoteCategory.semua:
        return Icons.grid_view_rounded;
      case NoteCategory.penting:
        return Icons.star_rounded;
      case NoteCategory.pribadi:
        return Icons.person_rounded;
      case NoteCategory.kerja:
        return Icons.work_rounded;
    }
  }

  Color get color {
    switch (this) {
      case NoteCategory.semua:
        return AppColors.primary;
      case NoteCategory.penting:
        return AppColors.categoryPentingIcon;
      case NoteCategory.pribadi:
        return AppColors.categoryPribadiIcon;
      case NoteCategory.kerja:
        return AppColors.categoryKerjaIcon;
    }
  }

  Color get backgroundColor {
    switch (this) {
      case NoteCategory.semua:
        return AppColors.primaryLight;
      case NoteCategory.penting:
        return AppColors.categoryPenting;
      case NoteCategory.pribadi:
        return AppColors.categoryPribadi;
      case NoteCategory.kerja:
        return AppColors.categoryKerja;
    }
  }
}

extension NotePriorityExtension on NotePriority {
  String get label {
    switch (this) {
      case NotePriority.rendah:
        return 'Rendah';
      case NotePriority.sedang:
        return 'Sedang';
      case NotePriority.tinggi:
        return 'Tinggi';
    }
  }

  Color get color {
    switch (this) {
      case NotePriority.rendah:
        return AppColors.success;
      case NotePriority.sedang:
        return AppColors.warning;
      case NotePriority.tinggi:
        return AppColors.error;
    }
  }

  Color get backgroundColor {
    switch (this) {
      case NotePriority.rendah:
        return const Color(0xFFDCFCE7);
      case NotePriority.sedang:
        return const Color(0xFFFEF3C7);
      case NotePriority.tinggi:
        return const Color(0xFFFEE2E2);
    }
  }
}

class NoteModel {
  final String id;
  String title;
  String content;
  NoteCategory category;
  Color noteColor;
  NotePriority priority;
  DateTime createdAt;
  DateTime updatedAt;
  bool isArchived;

  NoteModel({
    required this.id,
    required this.title,
    required this.content,
    required this.category,
    required this.noteColor,
    required this.priority,
    required this.createdAt,
    required this.updatedAt,
    this.isArchived = false,
  });

  NoteModel copyWith({
    String? id,
    String? title,
    String? content,
    NoteCategory? category,
    Color? noteColor,
    NotePriority? priority,
    DateTime? createdAt,
    DateTime? updatedAt,
    bool? isArchived,
  }) {
    return NoteModel(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      category: category ?? this.category,
      noteColor: noteColor ?? this.noteColor,
      priority: priority ?? this.priority,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      isArchived: isArchived ?? this.isArchived,
    );
  }
}

// Dummy Data
List<NoteModel> dummyNotes = [
  NoteModel(
    id: '1',
    title: 'Ide Aplikasi',
    content:
        'Ide untuk membuat aplikasi catatan sederhana dengan fitur kategori, warna, dan prioritas. Aplikasi ini digunakan untuk mencatat ide, rencana, dan hal penting sehari-hari.',
    category: NoteCategory.penting,
    noteColor: AppColors.noteBlue,
    priority: NotePriority.tinggi,
    createdAt: DateTime(2026, 10, 19, 9, 30),
    updatedAt: DateTime(2026, 10, 19, 9, 30),
  ),
  NoteModel(
    id: '2',
    title: 'Rencana Mingguan',
    content:
        'Daftar rencana untuk minggu ini:\n1. Olahraga 3x seminggu\n2. Belajar Flutter\n3. Membaca buku\n4. Belanja kebutuhan',
    category: NoteCategory.pribadi,
    noteColor: AppColors.noteGreen,
    priority: NotePriority.sedang,
    createdAt: DateTime(2026, 10, 18, 14, 0),
    updatedAt: DateTime(2026, 10, 18, 14, 0),
  ),
  NoteModel(
    id: '3',
    title: 'Catatan Kuliah',
    content:
        'Materi Pemrograman Perangkat Bergerak:\n- Flutter Widget Lifecycle\n- State Management\n- Navigator & Routing\n- HTTP Requests',
    category: NoteCategory.kerja,
    noteColor: AppColors.notePurple,
    priority: NotePriority.tinggi,
    createdAt: DateTime(2026, 10, 17, 10, 15),
    updatedAt: DateTime(2026, 10, 17, 10, 15),
  ),
  NoteModel(
    id: '4',
    title: 'Hal yang Perlu Dibeli',
    content:
        'Daftar belanja:\n- Susu\n- Telur\n- Sayur bayam\n- Buah apel\n- Sabun mandi\n- Shampo',
    category: NoteCategory.pribadi,
    noteColor: AppColors.noteYellow,
    priority: NotePriority.rendah,
    createdAt: DateTime(2026, 10, 16, 8, 0),
    updatedAt: DateTime(2026, 10, 16, 8, 0),
  ),
  NoteModel(
    id: '5',
    title: 'Jurnal Harian',
    content:
        'Hari ini cukup produktif. Berhasil menyelesaikan beberapa tugas kuliah dan sempat berolahraga pagi. Cuaca cerah membuat semangat beraktivitas.',
    category: NoteCategory.pribadi,
    noteColor: AppColors.notePink,
    priority: NotePriority.rendah,
    createdAt: DateTime(2026, 10, 15, 21, 0),
    updatedAt: DateTime(2026, 10, 15, 21, 0),
  ),
];
