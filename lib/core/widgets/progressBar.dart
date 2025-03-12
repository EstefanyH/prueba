import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  final ValueNotifier<bool> value;

  const ProgressBar({super.key, required this.value, });


  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder<bool>(
            valueListenable: value,
            builder: (context, loading, child) {
              if (!loading) return const SizedBox.shrink();
              return Stack(
                children: [
                  // Fondo oscuro
                  ModalBarrier(
                    dismissible: false,
                    color: Colors.black.withOpacity(0.5),
                  ),
                  // CircularProgressIndicator centrado
                  const Center(
                    child: CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                ],
              );
            },
          );
  }
}