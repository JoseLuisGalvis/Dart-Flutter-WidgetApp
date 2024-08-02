import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import '../model/category.dart';
import '../model/widget.dart';

class WidgetCategoryPage extends StatefulWidget {
  final String categoryName;

  WidgetCategoryPage({required this.categoryName});

  @override
  _WidgetCategoryPageState createState() => _WidgetCategoryPageState();
}

class _WidgetCategoryPageState extends State<WidgetCategoryPage> {
  late Future<List<Category>> _categories;

  Future<List<Category>> loadCategories() async {
    try {
      final categories = <Category>[];

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
        'seguridad_y_autenticacion',
      ]) {
        final jsonString = await rootBundle.loadString('assets/json/$category.json');
        final jsonData = jsonDecode(jsonString);

        final widgets = jsonData.map<WidgetModel>((widgetData) {
          return WidgetModel(
            name: widgetData['name'] as String,
            description: widgetData['description'] as String,
            image: widgetData['image'],
          );
        }).toList();

        if (category == widget.categoryName) {
          categories.add(Category(title: category, widgets: widgets));
        }
      }

      return categories;
    } catch (e) {
      return Future.error("Error loading categories: $e");
    }
  }

  @override
  void initState() {
    super.initState();
    _categories = loadCategories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text(
          widget.categoryName,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<List<Category>>(
        future: _categories,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final category = snapshot.data!.firstWhere((c) => c.title == widget.categoryName, orElse: () => Category(title: '', widgets: []));
            return GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 4,
              //crossAxisSpacing: 10,
              //mainAxisSpacing: 10,
              children: category.widgets.map((widget) {
                return CategoryCardWidget(
                  title: widget.name,
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text(widget.name),
                          content: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 350,
                                child: Image.asset(
                                  widget.image,
                                  fit: BoxFit.contain,
                                  height: 200,
                                ),
                              ),
                              Text(widget.description),
                            ],
                          ),
                        );
                      },
                    );
                  },
                );
              }).toList(),
            );
          } else if (snapshot.hasError) {
            return Center(child: Text('Error loading categories: ${snapshot.error}'));
          } else {
            return Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}





class CategoryCardWidget extends StatelessWidget {
  final String title;
  final VoidCallback onPressed;

  CategoryCardWidget({
    required this.title,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.fromLTRB(20, 10, 20, 0),
      elevation: 15,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: SizedBox(
        width: 100,
        height: 100,
        child: InkWell(
          onTap: onPressed,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),

    );
  }
}

