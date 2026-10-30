import 'package:flutter/material.dart';
import '../constants/app_colors.dart';
import '../constants/app_styles.dart';
import '../models/note_model.dart';
import '../widgets/priority_selector.dart';

class AddNoteScreen extends StatefulWidget {
  final List<NoteModel> notes;
  final NoteModel? noteToEdit;

  const AddNoteScreen({
    super.key,
    required this.notes,
    this.noteToEdit,
  });

  @override
  State<AddNoteScreen> createState() => _AddNoteScreenState();
}

class _AddNoteScreenState extends State<AddNoteScreen> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();

  NoteCategory _selectedCategory = NoteCategory.pribadi;
  Color _selectedColor = AppColors.noteBlue;
  NotePriority _selectedPriority = NotePriority.sedang;
  bool _isSaving = false;

  bool get isEditing => widget.noteToEdit != null;

  final List<Color> _noteColors = [
    AppColors.noteBlue,
    AppColors.noteGreen,
    AppColors.noteYellow,
    AppColors.notePink,
    AppColors.notePurple,
  ];

  @override
  void initState() {
    super.initState();
    if (isEditing) {
      final note = widget.noteToEdit!;
      _titleController.text = note.title;
      _contentController.text = note.content;
      _selectedCategory = note.category;
      _selectedColor = note.noteColor;
      _selectedPriority = note.priority;
    }
  }

  @override
  void dispose() {
    _titleController.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _handleSave() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isSaving = true);
    await Future.delayed(const Duration(milliseconds: 400));

    final now = DateTime.now();
    final note = NoteModel(
      id: isEditing
          ? widget.noteToEdit!.id
          : now.millisecondsSinceEpoch.toString(),
      title: _titleController.text.trim(),
      content: _contentController.text.trim(),
      category: _selectedCategory,
      noteColor: _selectedColor,
      priority: _selectedPriority,
      createdAt: isEditing ? widget.noteToEdit!.createdAt : now,
      updatedAt: now,
    );

    if (mounted) {
      setState(() => _isSaving = false);
      Navigator.pop(context, note);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Container(
            width: 38,
            height: 38,
            decoration: BoxDecoration(
              color: AppColors.surface,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(Icons.arrow_back_ios_new_rounded,
                size: 16, color: AppColors.textPrimary),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          isEditing ? 'Edit Catatan' : 'Tambah Catatan',
          style: const TextStyle(
            fontFamily: AppStyles.fontFamily,
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title Field
              _buildLabel('Judul Catatan'),
              const SizedBox(height: 8),
              TextFormField(
                controller: _titleController,
                style: const TextStyle(
                  fontFamily: AppStyles.fontFamily,
                  fontSize: 14,
                  color: AppColors.textPrimary,
                ),
                decoration: AppStyles.inputDecoration(
                  hintText: 'Masukkan judul catatan...',
                  prefixIcon: const Padding(
                    padding: EdgeInsets.all(14),
                    child: Icon(Icons.title_rounded,
                        color: AppColors.textSecondary, size: 20),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Judul catatan tidak boleh kosong';
                  }
                  if (value.trim().length < 3) {
                    return 'Judul minimal 3 karakter';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              // Content Field
              _buildLabel('Isi Catatan'),
              const SizedBox(height: 8),
              TextFormField(
                controller: _contentController,
                maxLines: 6,
                style: const TextStyle(
                  fontFamily: AppStyles.fontFamily,
                  fontSize: 14,
                  color: AppColors.textPrimary,
                ),
                decoration: const InputDecoration(
                  hintText: 'Tulis catatan Anda di sini...',
                  hintStyle: TextStyle(
                    fontFamily: AppStyles.fontFamily,
                    fontSize: 14,
                    color: AppColors.textHint,
                  ),
                  filled: true,
                  fillColor: AppColors.surface,
                  contentPadding: EdgeInsets.all(16),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(14)),
                    borderSide: BorderSide(color: AppColors.border),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(14)),
                    borderSide: BorderSide(color: AppColors.border),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(14)),
                    borderSide:
                        BorderSide(color: AppColors.primary, width: 1.5),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(14)),
                    borderSide: BorderSide(color: AppColors.error),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(14)),
                    borderSide: BorderSide(color: AppColors.error, width: 1.5),
                  ),
                ),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Isi catatan tidak boleh kosong';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              // Category Dropdown
              _buildLabel('Kategori'),
              const SizedBox(height: 8),
              Container(
                decoration: BoxDecoration(
                  color: AppColors.surface,
                  borderRadius: BorderRadius.circular(14),
                  border: Border.all(color: AppColors.border),
                ),
                child: DropdownButtonFormField<NoteCategory>(
                  // ignore: deprecated_member_use
                  value: _selectedCategory,
                  decoration: InputDecoration(
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 4),
                    border: InputBorder.none,
                    prefixIcon: Padding(
                      padding: const EdgeInsets.all(14),
                      child: Icon(_selectedCategory.icon,
                          color: _selectedCategory.color, size: 20),
                    ),
                  ),
                  dropdownColor: Colors.white,
                  icon: const Icon(Icons.keyboard_arrow_down_rounded,
                      color: AppColors.textSecondary),
                  style: const TextStyle(
                    fontFamily: AppStyles.fontFamily,
                    fontSize: 14,
                    color: AppColors.textPrimary,
                  ),
                  items: [
                    NoteCategory.pribadi,
                    NoteCategory.penting,
                    NoteCategory.kerja,
                  ].map((cat) {
                    return DropdownMenuItem(
                      value: cat,
                      child: Row(
                        children: [
                          Icon(cat.icon, color: cat.color, size: 18),
                          const SizedBox(width: 8),
                          Text(cat.label,
                              style: const TextStyle(
                                  fontFamily: AppStyles.fontFamily,
                                  fontSize: 14)),
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: (val) {
                    if (val != null) setState(() => _selectedCategory = val);
                  },
                ),
              ),

              const SizedBox(height: 20),

              // Color Picker
              _buildLabel('Warna'),
              const SizedBox(height: 12),
              Row(
                children: _noteColors.map((color) {
                  final isSelected = _selectedColor == color;
                  return GestureDetector(
                    onTap: () => setState(() => _selectedColor = color),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 200),
                      margin: const EdgeInsets.only(right: 12),
                      width: isSelected ? 44 : 38,
                      height: isSelected ? 44 : 38,
                      decoration: BoxDecoration(
                        color: color,
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isSelected ? Colors.white : Colors.transparent,
                          width: 3,
                        ),
                        boxShadow: isSelected
                            ? [
                                BoxShadow(
                                  color: color.withValues(alpha: 0.5),
                                  blurRadius: 10,
                                  spreadRadius: 2,
                                ),
                                BoxShadow(
                                  color: Colors.black.withValues(alpha: 0.15),
                                  blurRadius: 6,
                                  offset: const Offset(0, 2),
                                ),
                              ]
                            : [
                                BoxShadow(
                                  color: color.withValues(alpha: 0.3),
                                  blurRadius: 6,
                                  offset: const Offset(0, 2),
                                ),
                              ],
                      ),
                      child: isSelected
                          ? const Icon(Icons.check_rounded,
                              color: Colors.white, size: 18)
                          : null,
                    ),
                  );
                }).toList(),
              ),

              const SizedBox(height: 20),

              // Priority Selector
              _buildLabel('Prioritas'),
              const SizedBox(height: 12),
              PrioritySelector(
                selectedPriority: _selectedPriority,
                onPrioritySelected: (p) =>
                    setState(() => _selectedPriority = p),
              ),

              const SizedBox(height: 32),

              // Save Button
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  onPressed: _isSaving ? null : _handleSave,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    disabledBackgroundColor:
                        AppColors.primary.withValues(alpha: 0.6),
                  ),
                  child: _isSaving
                      ? const SizedBox(
                          width: 22,
                          height: 22,
                          child: CircularProgressIndicator(
                              color: Colors.white, strokeWidth: 2.5),
                        )
                      : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.save_rounded,
                                color: Colors.white, size: 20),
                            const SizedBox(width: 8),
                            Text(
                              isEditing ? 'Perbarui Catatan' : 'Simpan',
                              style: const TextStyle(
                                fontFamily: AppStyles.fontFamily,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                ),
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String label) {
    return Text(
      label,
      style: const TextStyle(
        fontFamily: AppStyles.fontFamily,
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),
    );
  }
}
