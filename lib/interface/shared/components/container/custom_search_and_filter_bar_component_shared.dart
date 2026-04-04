import 'package:flutter/material.dart';

/// Filter item model for the custom search and filter bar.
/// Modelo de ítem de filtro para la barra de búsqueda y filtro personalizada.
class CustomFilterItemComponentShared {
  /// Numeric identifier used to relate the item with domain models (e.g. category id).
  /// Identificador numérico usado para relacionar el ítem con modelos de dominio (por ejemplo id de categoría).
  final int id;

  /// Unique value used internally to identify the filter item.
  /// Valor único usado internamente para identificar el ítem de filtro.
  final String value;

  /// Visible label shown in the dropdown.
  /// Etiqueta visible que se muestra en el desplegable.
  final String label;

  /// Creates a new filter item for the component.
  /// Crea un nuevo ítem de filtro para el componente.
  const CustomFilterItemComponentShared({
    required this.id,
    required this.value,
    required this.label,
  });
}

class CustomSearchAndFilterBarComponentShared extends StatelessWidget {
  const CustomSearchAndFilterBarComponentShared({
    super.key,
    required this.searchController,
    required this.selectedFilterItem,
    required this.filterItems,
    this.onSearchChanged,
    this.onFilterItemSelected,
    this.searchHintText = 'Buscar software',
    this.height = 48,
    this.searchWidthSpacing = 10,
  });

  final TextEditingController searchController;
  final CustomFilterItemComponentShared? selectedFilterItem;
  final List<CustomFilterItemComponentShared> filterItems;
  final ValueChanged<String>? onSearchChanged;
  final ValueChanged<CustomFilterItemComponentShared?>? onFilterItemSelected;
  final String searchHintText;
  final double height;
  final double searchWidthSpacing;

  @override
  Widget build(BuildContext context) {
    final TextTheme textTheme = Theme.of(context).textTheme;

    final OutlineInputBorder border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide.none,
    );

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
          child: SizedBox(
            height: height,
            child: TextField(
              controller: searchController,
              onChanged: onSearchChanged,
              expands: true,
              maxLines: null,
              minLines: null,
              style: textTheme.bodyMedium?.copyWith(color: Colors.white),
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.black.withValues(alpha: 0.1),
                hintText: searchHintText,
                hintStyle: textTheme.bodyMedium?.copyWith(color: Colors.white),
                prefixIcon: const Icon(Icons.search, color: Colors.white),
                isDense: true,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 0,
                ),
                border: border,
                enabledBorder: border,
                focusedBorder: border,
              ),
            ),
          ),
        ),
        SizedBox(width: searchWidthSpacing),
        SizedBox(
          width: 220,
          height: height,
          child: Theme(
            data: Theme.of(context).copyWith(
              inputDecorationTheme: InputDecorationTheme(
                isDense: true,
                filled: true,
                fillColor: Colors.black.withValues(alpha: 0.1),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 0,
                ),
                border: border,
                enabledBorder: border,
                focusedBorder: border,
                suffixIconColor: Colors.white,
              ),
            ),
            child: DropdownMenu<CustomFilterItemComponentShared>(
              width: 220,
              initialSelection: selectedFilterItem,
              enableSearch: false,
              enableFilter: false,
              selectOnly: true,
              textStyle: textTheme.bodyMedium?.copyWith(color: Colors.white),
              menuStyle: MenuStyle(
                visualDensity: VisualDensity.compact,
                backgroundColor: WidgetStatePropertyAll<Color>(
                  Colors.white.withValues(alpha: 0.9),
                ),
              ),
              onSelected: onFilterItemSelected,
              dropdownMenuEntries: filterItems
                  .map(
                    (CustomFilterItemComponentShared item) =>
                        DropdownMenuEntry<CustomFilterItemComponentShared>(
                          value: item,
                          label: item.label,
                        ),
                  )
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
