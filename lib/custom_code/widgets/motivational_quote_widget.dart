// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:math';

class MotivationalQuoteWidget extends StatefulWidget {
  const MotivationalQuoteWidget({
    Key? key,
    this.width,
    this.height,
    this.collectionName = 'quotes',
    this.quoteField = 'quote',
    this.authorField = 'author',
  }) : super(key: key);

  final double? width;
  final double? height;

  final String collectionName;
  final String quoteField;
  final String authorField;

  @override
  State<MotivationalQuoteWidget> createState() =>
      _MotivationalQuoteWidgetState();
}

class _MotivationalQuoteWidgetState extends State<MotivationalQuoteWidget>
    with SingleTickerProviderStateMixin {
  // ── Estado ──
  List<Map<String, String>> _quotes = [];
  int _currentIndex = 0;
  bool _isLoading = true;
  bool _hasError = false;

  // ── Animación ──
  late AnimationController _animController;
  late Animation<double> _fadeAnim;

  @override
  void initState() {
    super.initState();

    // Animación fade
    _animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 500),
    );
    _fadeAnim = CurvedAnimation(
      parent: _animController,
      curve: Curves.easeInOut,
    );

    _loadQuotes();
  }

  @override
  void dispose() {
    _animController.dispose();
    super.dispose();
  }

  // ── Cargar frases desde Firestore ──
  Future<void> _loadQuotes() async {
    try {
      final snapshot = await FirebaseFirestore.instance
          .collection(widget.collectionName)
          .get();

      if (snapshot.docs.isEmpty) {
        // Fallback si la colección está vacía
        setState(() {
          _quotes = [
            {
              'quote':
                  'El éxito es la suma de pequeños esfuerzos repetidos día tras día.',
              'author': 'Robert Collier',
            }
          ];
          _isLoading = false;
        });
        _animController.forward();
        return;
      }

      final List<Map<String, String>> loaded = snapshot.docs
          .map((doc) {
            final data = doc.data();
            return {
              'quote': (data[widget.quoteField] ?? '').toString(),
              'author': (data[widget.authorField] ?? '').toString(),
            };
          })
          .where((q) => q['quote']!.isNotEmpty)
          .toList();

      // Mostrar una frase aleatoria al inicio
      final random = Random();
      final startIndex = random.nextInt(loaded.length);

      setState(() {
        _quotes = loaded;
        _currentIndex = startIndex;
        _isLoading = false;
      });

      _animController.forward();
    } catch (e) {
      setState(() {
        _isLoading = false;
        _hasError = true;
      });
    }
  }

  // ── Cambiar a siguiente frase con fade ──
  Future<void> _nextQuote() async {
    if (_quotes.length <= 1) return;

    // Fade out
    await _animController.reverse();

    // Cambiar frase (evitar repetir la misma)
    int nextIndex;
    do {
      nextIndex = Random().nextInt(_quotes.length);
    } while (nextIndex == _currentIndex && _quotes.length > 1);

    setState(() => _currentIndex = nextIndex);

    // Fade in
    await _animController.forward();
  }

  @override
  Widget build(BuildContext context) {
    // ── Colores del tema de la app ──
    const Color bgColor = Color(0xFF1E1E2E);
    const Color borderColor = Color(0xFF3D3D5C);
    const Color accentBlue = Color(0xFF3333CC);
    const Color textPrimary = Color(0xFFFFFFFF);
    const Color textSecondary = Color(0xFFAAAAAA);

    return GestureDetector(
      onTap: _isLoading || _hasError ? null : _nextQuote,
      child: Container(
        width: widget.width ?? double.infinity,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: borderColor, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: accentBlue.withOpacity(0.15),
              blurRadius: 20,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: _isLoading
            ? _buildLoading()
            : _hasError
                ? _buildError(textSecondary)
                : _buildQuote(textPrimary, textSecondary, accentBlue),
      ),
    );
  }

  // ── Estado de carga ──
  Widget _buildLoading() {
    return const Center(
      child: SizedBox(
        height: 24,
        width: 24,
        child: CircularProgressIndicator(
          strokeWidth: 2,
          color: Color(0xFF3333CC),
        ),
      ),
    );
  }

  // ── Estado de error ──
  Widget _buildError(Color textSecondary) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(Icons.wifi_off_rounded, color: textSecondary, size: 16),
        const SizedBox(width: 8),
        Text(
          'No se pudieron cargar las frases',
          style: TextStyle(color: textSecondary, fontSize: 13),
        ),
      ],
    );
  }

  // ── Contenido principal ──
  Widget _buildQuote(Color textPrimary, Color textSecondary, Color accentBlue) {
    final current = _quotes[_currentIndex];

    return FadeTransition(
      opacity: _fadeAnim,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Comilla decorativa
          Text(
            '"',
            style: TextStyle(
              color: accentBlue,
              fontSize: 40,
              height: 0.8,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 8),

          // Frase
          Text(
            current['quote'] ?? '',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontStyle: FontStyle.italic,
              height: 1.5,
              letterSpacing: 0.2,
            ),
          ),

          // Autor (si existe)
          if ((current['author'] ?? '').isNotEmpty) ...[
            const SizedBox(height: 12),
            Row(
              children: [
                Container(
                  width: 24,
                  height: 1.5,
                  color: accentBlue,
                ),
                const SizedBox(width: 8),
                Text(
                  current['author']!,
                  style: TextStyle(
                    color: textSecondary,
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.5,
                  ),
                ),
              ],
            ),
          ],

          // Hint de tap
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Icon(Icons.touch_app_rounded, color: textSecondary, size: 14),
              const SizedBox(width: 4),
              Text(
                'Toca para cambiar',
                style: TextStyle(
                  color: textSecondary,
                  fontSize: 11,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// Set your widget name, define your parameter, and then add the
// boilerplate code using the green button on the right!
