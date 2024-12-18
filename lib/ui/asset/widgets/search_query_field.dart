import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tractian_challenge/ui/core/colors.dart';

class SearchQueryField extends StatelessWidget {
  const SearchQueryField(
      {super.key, required this.controller, this.onSubmitted});

  final TextEditingController controller;
  final Function(String)? onSubmitted;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: AppColors.grey.withValues(alpha: 0.2), // Fundo cinza claro
        borderRadius: BorderRadius.circular(8), // Borda arredondada
      ),
      child: Row(
        children: [
          Icon(
            Icons.search, // Ícone de lupa
            color: Colors.grey, // Cor do ícone cinza
          ),
          SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: controller,
              onSubmitted: onSubmitted,
              style:
                  GoogleFonts.roboto(fontSize: 18, fontWeight: FontWeight.w400),
              decoration: InputDecoration(
                hintText: 'Buscar Ativo ou Local',
                hintStyle: GoogleFonts.roboto(
                    color: AppColors.grey,
                    fontSize: 18,
                    fontWeight: FontWeight.w400),
                border: InputBorder.none,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
