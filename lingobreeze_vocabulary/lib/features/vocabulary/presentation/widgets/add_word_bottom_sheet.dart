import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../controllers/vocabulary_controller.dart';

class AddWordBottomSheet extends ConsumerStatefulWidget {
  const AddWordBottomSheet({super.key});

  @override
  ConsumerState<AddWordBottomSheet> createState() => _AddWordBottomSheetState();
}

class _AddWordBottomSheetState extends ConsumerState<AddWordBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final _wordController = TextEditingController();
  final _meaningController = TextEditingController();
  final _translationController = TextEditingController();
  bool _isSaving = false;

  @override
  void dispose() {
    _wordController.dispose();
    _meaningController.dispose();
    _translationController.dispose();
    super.dispose();
  }

  Future<void> _submitForm() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isSaving = true);

    // Call our Riverpod controller method
    final success = await ref.read(vocabularyProvider.notifier).addNewWord(
          word: _wordController.text,
          meaning: _meaningController.text,
          translation: _translationController.text,
        );

    setState(() => _isSaving = false);

    if (success) {
      if (mounted) Navigator.pop(context); // Close Bottom Sheet layout
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Failed to save word. Please check your Node server connection.')),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    // Handle view shifting when system software keyboard slides up
    final keyboardPadding = MediaQuery.of(context).viewInsets.bottom;

    return Container(
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: EdgeInsets.fromLTRB(24, 24, 24, 24 + keyboardPadding),
      child: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    'Add New Word',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close_rounded),
                    onPressed: () => Navigator.pop(context),
                  )
                ],
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _wordController,
                decoration: const InputDecoration(
                  labelText: 'Word *',
                  hintText: 'e.g., Bonjour',
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
                ),
                validator: (val) => (val == null || val.trim().isEmpty) ? 'Word is mandatory' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _meaningController,
                decoration: const InputDecoration(
                  labelText: 'Meaning *',
                  hintText: 'e.g., Hello / Good morning',
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
                ),
                validator: (val) => (val == null || val.trim().isEmpty) ? 'Meaning is mandatory' : null,
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _translationController,
                decoration: const InputDecoration(
                  labelText: 'Language / Translation Tag *',
                  hintText: 'e.g., French',
                  border: OutlineInputBorder(borderRadius: BorderRadius.all(Radius.circular(12))),
                ),
                validator: (val) => (val == null || val.trim().isEmpty) ? 'Language tag is mandatory' : null,
              ),
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: _isSaving ? null : _submitForm,
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF6366F1),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: _isSaving
                    ? const SizedBox(height: 20, width: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                    : const Text('Save to Vocabulary', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}