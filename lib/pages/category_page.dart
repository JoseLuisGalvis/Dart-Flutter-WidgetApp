import 'package:flutter/material.dart';
import 'package:widget_cards/pages/widget_category_page.dart';

// 3. Página Principal
class CategoryPage extends StatefulWidget {
  const CategoryPage({super.key});

  @override
  State<CategoryPage> createState() => _CategoryPageState();
}

class _CategoryPageState extends State<CategoryPage> {
  final List<String> _images = [
    'assets/images/accessibility.png',
    'assets/images/animation.png',
    'assets/images/icons.png',
    'assets/images/estados.png',
    'assets/images/basicos.png',
    'assets/images/cupertino.png',
    'assets/images/desplazamiento.jpeg',
    'assets/images/entrada.jpeg',
    'assets/images/layout.jpeg',
    'assets/images/material.jpeg',
    'assets/images/navegacion.jpeg',
    'assets/images/visuales.jpeg',
    'assets/images/tema.png',
    'assets/images/text.png',
    'assets/images/security.png',
  ];

  final List<String> _titles = [
    'Usabilidad',
    'Animación y Movimientos',
    'Activos Imagen e Ícono',
    'Gestión de Estado',
    'Básicos',
    'Cupertino',
    'Entrada',
    'Navegación',
    'Layout',
    'Componentes de Material',
    'Efectos Visuales',
    'Desplazamiento',
    'Tema y Apariencia',
    'Texto',
    'Seguridad y Autenticación',
  ];

  final List<String> _descriptions = [
    'Mejora la accesibilidad de la aplicación',
    'Agrega animaciones a los widgets',
    'Administra activos, muestra imágenes e iconos',
    'Funcionalidad para manejar el estado de la aplicación de manera eficiente.',
    'Widgets esenciales para el desarrollo de aplicaciones Flutter',
    'Widgets hermosos y de alta fidelidad para estilos iOS.',
    'Entrada del usuario y de los widgets en Componentes de Material y Cupertino',
    'Responde a eventos táctiles y dirige a los usuarios a diferentes vistas.',
    'Organiza otros widgets, columnas, filas, cuadrículas y otros diseños.',
    'Widgets visuales, comportamentales y ricos en movimiento',
    'Widgets que añaden cambios visuales a sus hijos sin cambiar su diseño y forma.',
    'Desplaza múltiples widgets como hijos de los padres.',
    'Se ocupa del tema, responsividad y tamaño de la aplicación.',
    'Muestra y Estiliza Texto',
    'Autenticación y Autorización',
  ];

  final Map<String, String> _categoryMap = {
    'Usabilidad': 'usabilidad',
    'Animación y Movimientos': 'animacion_y_movimientos',
    'Activos Imagen e Ícono': 'activos_imagen_e_icono',
    'Gestión de Estado': 'gestion_de_estado',
    'Básicos': 'basicos',
    'Cupertino': 'cupertino',
    'Entrada': 'entrada',
    'Navegación': 'navegacion',
    'Layout': 'layout',
    'Componentes de Material': 'componentes_de_material',
    'Efectos Visuales': 'efectos_visuales',
    'Desplazamiento': 'desplazamiento',
    'Tema y Apariencia': 'tema_y_apariencia',
    'Texto': 'texto',
    'Seguridad y Autenticación': 'seguridad_y_autenticacion',
  };


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Categorías de Widgets'),
      ),
      body: GridView.count(
        crossAxisCount: 2, // número de columnas
        children: List.generate(_images.length, (index) {
          return CategoryCard(
            image: _images[index],
            title: _titles[index],
            description: _descriptions[index],
            onPressed: () {
              // Navegar a la vista de selección de widgets
              // correspondiente
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => WidgetCategoryPage(
                    categoryName: _categoryMap[_titles[index]]?? '',
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String image;
  final String title;
  final String description;
  final VoidCallback onPressed;

  CategoryCard({
    required this.image,
    required this.title,
    required this.description,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 15,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: SizedBox(
        width: 200,
        height: 430,
        child: InkWell(
          onTap: onPressed,
          child: Column(
            children: [
              SizedBox(
                width: 200,
                height: 110,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(5),
                  child: Image.asset(image),
                ),
              ),
              Text(
                title,
                style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
              ),
              Flexible(
                child: Text(
                  description,
                  maxLines: 4,
                  style: TextStyle(fontSize: 12),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}