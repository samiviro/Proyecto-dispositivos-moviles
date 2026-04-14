// Automatic FlutterFlow imports
import '/backend/backend.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import 'index.dart'; // Imports other custom widgets
import '/flutter_flow/custom_functions.dart'; // Imports custom functions
import 'package:flutter/material.dart';
// Begin custom widget code
// DO NOT REMOVE OR MODIFY THE CODE ABOVE!

class DeadlineCountdownChip extends StatefulWidget {
  const DeadlineCountdownChip({
    Key? key,
    this.width,
    this.height,
    this.deadlineDate = '',
    this.showIcon = true,
  }) : super(key: key);

  final double? width;
  final double? height;

  // ── Parámetros configurables desde FlutterFlow ──
  final String deadlineDate;
  final bool showIcon;

  @override
  State<DeadlineCountdownChip> createState() => _DeadlineCountdownChipState();
}

class _DeadlineCountdownChipState extends State<DeadlineCountdownChip>
    with SingleTickerProviderStateMixin {
  // ── Animación de pulso para entregas urgentes (<1 día) ──
  late AnimationController _pulseController;
  late Animation<double> _pulseAnim;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);

    _pulseAnim = Tween<double>(begin: 0.7, end: 1.0).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  // ── Parsear la fecha y calcular diferencia ──
  _CountdownData _getCountdown() {
    if (widget.deadlineDate.isEmpty) {
      return _CountdownData(
        label: 'Sin fecha',
        isExpired: false,
        urgencyLevel: UrgencyLevel.normal,
      );
    }

    try {
      final deadline = DateTime.parse(widget.deadlineDate);
      final now = DateTime.now();
      final diff = deadline.difference(now);

      // Ya expiró
      if (diff.isNegative) {
        return _CountdownData(
          label: 'Vencida',
          isExpired: true,
          urgencyLevel: UrgencyLevel.expired,
        );
      }

      final days = diff.inDays;
      final hours = diff.inHours % 24;

      // Construir label
      String label;
      if (days == 0 && hours == 0) {
        final minutes = diff.inMinutes;
        label = 'Exp ${minutes}min';
      } else if (days == 0) {
        label = 'Exp ${hours}H';
      } else {
        label = hours > 0 ? 'Exp ${days}D ${hours}H' : 'Exp ${days}D';
      }

      // Nivel de urgencia
      UrgencyLevel urgency;
      if (diff.inHours < 24) {
        urgency = UrgencyLevel.critical; // Rojo
      } else if (diff.inDays < 3) {
        urgency = UrgencyLevel.warning; // Amarillo
      } else {
        urgency = UrgencyLevel.normal; // Verde
      }

      return _CountdownData(
        label: label,
        isExpired: false,
        urgencyLevel: urgency,
      );
    } catch (e) {
      return _CountdownData(
        label: 'Fecha inválida',
        isExpired: false,
        urgencyLevel: UrgencyLevel.normal,
      );
    }
  }

  // ── Colores según urgencia ──
  _UrgencyColors _getColors(UrgencyLevel level) {
    switch (level) {
      case UrgencyLevel.critical:
        return _UrgencyColors(
          background: const Color(0xFFB71C1C).withOpacity(0.2),
          border: const Color(0xFFEF5350),
          text: const Color(0xFFEF9A9A),
          icon: const Color(0xFFEF5350),
        );
      case UrgencyLevel.warning:
        return _UrgencyColors(
          background: const Color(0xFFF57F17).withOpacity(0.2),
          border: const Color(0xFFFFB300),
          text: const Color(0xFFFFCC80),
          icon: const Color(0xFFFFB300),
        );
      case UrgencyLevel.normal:
        return _UrgencyColors(
          background: const Color(0xFF1B5E20).withOpacity(0.2),
          border: const Color(0xFF66BB6A),
          text: const Color(0xFFA5D6A7),
          icon: const Color(0xFF66BB6A),
        );
      case UrgencyLevel.expired:
        return _UrgencyColors(
          background: const Color(0xFF212121).withOpacity(0.5),
          border: const Color(0xFF616161),
          text: const Color(0xFF9E9E9E),
          icon: const Color(0xFF757575),
        );
    }
  }

  @override
  Widget build(BuildContext context) {
    final countdown = _getCountdown();
    final colors = _getColors(countdown.urgencyLevel);
    final isCritical = countdown.urgencyLevel == UrgencyLevel.critical;

    Widget chip = Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: colors.background,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: colors.border, width: 1.2),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Ícono
          if (widget.showIcon) ...[
            Icon(
              countdown.isExpired
                  ? Icons.block_rounded
                  : Icons.access_time_rounded,
              color: colors.icon,
              size: 13,
            ),
            const SizedBox(width: 5),
          ],

          // Texto
          Text(
            countdown.label,
            style: TextStyle(
              color: colors.text,
              fontSize: 12,
              fontWeight: FontWeight.w700,
              letterSpacing: 0.4,
            ),
          ),
        ],
      ),
    );

    // Animación de pulso solo para entregas críticas
    if (isCritical) {
      chip = FadeTransition(opacity: _pulseAnim, child: chip);
    }

    return chip;
  }
}

// ── Modelos internos ──
enum UrgencyLevel { critical, warning, normal, expired }

class _CountdownData {
  final String label;
  final bool isExpired;
  final UrgencyLevel urgencyLevel;

  _CountdownData({
    required this.label,
    required this.isExpired,
    required this.urgencyLevel,
  });
}

class _UrgencyColors {
  final Color background;
  final Color border;
  final Color text;
  final Color icon;

  _UrgencyColors({
    required this.background,
    required this.border,
    required this.text,
    required this.icon,
  });
}

// Set your widget name, define your parameter, and then add the
// boilerplate code using the green button on the right!
