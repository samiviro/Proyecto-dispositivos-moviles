// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

import 'dart:math';
import 'package:url_launcher/url_launcher.dart';

class SubjectCardWidget extends StatefulWidget {
  const SubjectCardWidget({
    Key? key,
    this.width,
    this.height,
    this.subjectName = 'Nombre Materia',
    this.subjectCode = 'COD-101',
    this.meetingUrl = '',
    this.onTapCard,
    this.onTapChat,
    this.onTapTasks,
    this.onTapCalendar,
  }) : super(key: key);

  final double? width;
  final double? height;

  // ── Parámetros configurables desde FlutterFlow ──
  final String subjectName;
  final String subjectCode;
  final String meetingUrl;
  final Future<dynamic> Function()? onTapCard;
  final Future<dynamic> Function()? onTapChat;
  final Future<dynamic> Function()? onTapTasks;
  final Future<dynamic> Function()? onTapCalendar;

  @override
  State<SubjectCardWidget> createState() => _SubjectCardWidgetState();
}

class _SubjectCardWidgetState extends State<SubjectCardWidget>
    with SingleTickerProviderStateMixin {
  bool _isPressed = false;

  // ── Genera un gradiente determinista según el nombre de la materia ──
  // Así la misma materia siempre tendrá el mismo color
  List<Color> _getGradientColors(String name) {
    final gradients = [
      [const Color(0xFF1A237E), const Color(0xFF3949AB)], // Azul profundo
      [const Color(0xFF1B5E20), const Color(0xFF388E3C)], // Verde bosque
      [const Color(0xFF4A148C), const Color(0xFF7B1FA2)], // Morado
      [const Color(0xFF880E4F), const Color(0xFFC2185B)], // Rosa oscuro
      [const Color(0xFF0D47A1), const Color(0xFF1976D2)], // Azul real
      [const Color(0xFF004D40), const Color(0xFF00796B)], // Verde azulado
      [const Color(0xFF311B92), const Color(0xFF512DA8)], // Índigo
      [const Color(0xFF1A237E), const Color(0xFF00838F)], // Azul a teal
      [const Color(0xFF33691E), const Color(0xFF689F38)], // Verde lima
      [const Color(0xFF37474F), const Color(0xFF546E7A)], // Gris azulado
    ];

    // Hash simple del nombre para elegir gradiente consistente
    int hash = 0;
    for (int i = 0; i < name.length; i++) {
      hash = (hash * 31 + name.codeUnitAt(i)) % gradients.length;
    }
    return gradients[hash % gradients.length];
  }

  Future<void> _launchMeeting() async {
    if (widget.meetingUrl.isEmpty) return;
    final uri = Uri.parse(widget.meetingUrl);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final gradientColors = _getGradientColors(widget.subjectName);

    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) => setState(() => _isPressed = false),
      onTapCancel: () => setState(() => _isPressed = false),
      onTap: widget.onTapCard != null ? () => widget.onTapCard!() : null,
      child: AnimatedScale(
        scale: _isPressed ? 0.97 : 1.0,
        duration: const Duration(milliseconds: 120),
        child: Container(
          width: widget.width ?? double.infinity,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            gradient: LinearGradient(
              colors: gradientColors,
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            boxShadow: [
              BoxShadow(
                color: gradientColors[0].withOpacity(0.4),
                blurRadius: 16,
                offset: const Offset(0, 6),
              ),
            ],
          ),
          child: Stack(
            children: [
              // ── Patrón decorativo de fondo ──
              Positioned(
                right: -20,
                top: -20,
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.05),
                  ),
                ),
              ),
              Positioned(
                right: 30,
                bottom: -30,
                child: Container(
                  width: 80,
                  height: 80,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.white.withOpacity(0.05),
                  ),
                ),
              ),

              // ── Contenido ──
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Nombre y código
                    Text(
                      widget.subjectName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 0.3,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        widget.subjectCode,
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 11,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 1.0,
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // ── Botones de acción ──
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        _ActionButton(
                          icon: Icons.chat_bubble_outline_rounded,
                          tooltip: 'Chat',
                          onTap: widget.onTapChat != null
                              ? () => widget.onTapChat!()
                              : null,
                        ),
                        const SizedBox(width: 10),
                        _ActionButton(
                          icon: Icons.assignment_outlined,
                          tooltip: 'Entregas',
                          onTap: widget.onTapTasks != null
                              ? () => widget.onTapTasks!()
                              : null,
                        ),
                        const SizedBox(width: 10),
                        _ActionButton(
                          icon: Icons.calendar_month_outlined,
                          tooltip: 'Horario',
                          onTap: widget.onTapCalendar != null
                              ? () => widget.onTapCalendar!()
                              : null,
                        ),
                        const SizedBox(width: 10),
                        _ActionButton(
                          icon: Icons.videocam_outlined,
                          tooltip: 'Videollamada',
                          onTap: _launchMeeting,
                          accentColor: const Color(0xFF4CAF50),
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

// ── Botón de acción individual ──
class _ActionButton extends StatelessWidget {
  const _ActionButton({
    required this.icon,
    required this.tooltip,
    this.onTap,
    this.accentColor,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback? onTap;
  final Color? accentColor;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          width: 42,
          height: 42,
          decoration: BoxDecoration(
            color: accentColor != null
                ? accentColor!.withOpacity(0.25)
                : Colors.white.withOpacity(0.15),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: accentColor != null
                  ? accentColor!.withOpacity(0.5)
                  : Colors.white.withOpacity(0.2),
              width: 1,
            ),
          ),
          child: Icon(
            icon,
            color: accentColor ?? Colors.white,
            size: 20,
          ),
        ),
      ),
    );
  }
}

// Set your widget name, define your parameter, and then add the
// boilerplate code using the green button on the right!
