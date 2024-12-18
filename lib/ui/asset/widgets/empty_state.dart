import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

class AssetsEmptyState extends StatelessWidget {
  const AssetsEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Text(
          'Nenhum asset encontrado.',
          style: GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.w400),
        ),
      ),
    );
  }
}
