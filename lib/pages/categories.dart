import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;

import '../model/widget.dart';

class Category {
  final String title;
  final List<WidgetModel> widgets; // Cambiado a List<WidgetModel>

  Category({required this.title, required this.widgets});
}

Future<List<Category>> loadCategories() async {
  final categories = <Category>[];

  // Leer los archivos JSON de cada categoría
  for (String category in [
    'usabilidad',
    'animacion_y_movimientos',
    'activos_imagen_e_icono',
    'gestion_de_estado',
    'basicos',
    'cupertino',
    'entrada',
    'navegacion',
    'layout',
    'componentes_de_material',
    'efectos_visuales',
    'desplazamiento',
    'tema_y_apariencia',
    'texto',
    'eguridad_y_autenticacion',
  ]) {
    try {
      final jsonString = await rootBundle.loadString(
          'assets/json/$category.json');
      final jsonData = jsonDecode(jsonString);

      // Crear la lista de widgets para la categoría
      final widgets = jsonData.map<WidgetModel>((widgetData) {
        return WidgetModel(
          name: widgetData['name'] as String,
          description: widgetData['description'] as String,
          image: widgetData['image'] as String,
        );
      }).toList();

      // Agregar la categoría a la lista solo si coincide con la categoría actual
      categories.add(Category(title: category, widgets: widgets));
    } catch (e) {
      print("Error loading JSON file for category '$category': $e");
    }
  }
  return categories;


}


