import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_styles.dart';
import '../models/note_model.dart';

class NoteCard extends StatelessWidget {
  final NoteModel note;
  final VoidCallback onTap;
  final VoidCallback onEdit;
  final VoidCallback onDelete;
  final VoidCallback? onArchive;

  const NoteCard({
    super.key,
    required this.note,
    required this.onTap,
    required this.onEdit,
    required this.onDelete,
    this.onArchive,
  });

  String _formatDate(DateTime date) {
    const months = [
      'Januari', 'Februari', 'Maret', 'April', 'Mei', 'Juni',
      'Juli', 'Agustus', 'September', 'Oktober', 'November', 'Desember'
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 6),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.06),
              blurRadius: 12,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: Stack(
            children: [
              // Left accent bar
              Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                child: Container(width: 5, color: note.noteColor),
              ),
              // Content
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 14, 12, 14),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Category icon
                    Container(
                      width: 42,
                      height: 42,
                      decoration: BoxDecoration(
                        color: note.category.backgroundColor,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(note.category.icon,
                          color: note.category.color, size: 22),
                    ),
                    const SizedBox(width: 12),
                    // Text content
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            note.title,
                            style: const TextStyle(
                              fontFamily: AppStyles.fontFamily,
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              color: AppColors.textPrimary,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 4),
                          Text(
                            note.content,
                            style: const TextStyle(
                              fontFamily: AppStyles.fontFamily,
                              fontSize: 12,
                              color: AppColors.textSecondary,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              const Icon(Icons.calendar_today_rounded,
                                  size: 11, color: AppColors.textHint),
                              const SizedBox(width: 4),
                              Text(
                                _formatDate(note.createdAt),
                                style: const TextStyle(
                                  fontFamily: AppStyles.fontFamily,
                                  fontSize: 11,
                                  color: AppColors.textHint,
                                ),
                              ),
                              const SizedBox(width: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 6, vertical: 2),
                                decoration: BoxDecoration(
                                  color: note.priority.backgroundColor,
                                  borderRadius: BorderRadius.circular(6),
                                ),
                                child: Text(
                                  note.priority.label,
                                  style: TextStyle(
                                    fontFamily: AppStyles.fontFamily,
                                    fontSize: 10,
                                    fontWeight: FontWeight.w600,
                                    color: note.priority.color,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Three-dot menu
                    PopupMenuButton<String>(
                      icon: const Icon(Icons.more_vert_rounded,
                          color: AppColors.textSecondary, size: 20),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      elevation: 4,
                      onSelected: (value) {
                        if (value == 'edit') onEdit();
                        if (value == 'delete') onDelete();
                        if (value == 'archive' && onArchive != null) {
                          onArchive!();
                        }
                      },
                      itemBuilder: (_) => [
                        PopupMenuItem(
                          value: 'edit',
                          child: Row(children: const [
                            Icon(Icons.edit_rounded,
                                size: 18, color: AppColors.primary),
                            SizedBox(width: 8),
                            Text('Edit',
                                style: TextStyle(
                                    fontFamily: AppStyles.fontFamily,
                                    fontSize: 14)),
                          ]),
                        ),
                        if (onArchive != null)
                          PopupMenuItem(
                            value: 'archive',
                            child: Row(children: const [
                              Icon(Icons.archive_rounded,
                                  size: 18, color: AppColors.warning),
                              SizedBox(width: 8),
                              Text('Arsipkan',
                                  style: TextStyle(
                                      fontFamily: AppStyles.fontFamily,
                                      fontSize: 14)),
                            ]),
                          ),
                        PopupMenuItem(
                          value: 'delete',
                          child: Row(children: const [
                            Icon(Icons.delete_rounded,
                                size: 18, color: AppColors.error),
                            SizedBox(width: 8),
                            Text('Hapus',
                                style: TextStyle(
                                    fontFamily: AppStyles.fontFamily,
                                    fontSize: 14,
                                    color: AppColors.error)),
                          ]),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
