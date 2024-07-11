
class WidgetModel {
  final String name;
  final String description;
  final String image;

  WidgetModel({required this.name, required this.description, required this.image});

  // Método para convertir el objeto WidgetModel a un Map<String, dynamic>
  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
      'image': image,
    };
  }
}

