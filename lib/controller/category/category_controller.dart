import 'package:all_events/model/category/category_model.dart';
import 'package:all_events/model/event/event_model.dart';
import 'package:all_events/repo/category_repo.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';

final categoryControllerProvider = Provider((ref) {
  final categoryRepo = ref.watch(categoryRepoProvider);
  return CategoryController(categoryRepo: categoryRepo);
});

class CategoryController {
  final CategoryRepo _categoryRepo;
  List<CategoryModel> category = [];
  List<CategoryModel> selectedCategory = [];
  List<EventItem> eventList = [];

  CategoryController({required CategoryRepo categoryRepo}) : _categoryRepo = categoryRepo;

  Future<List<CategoryModel>> getProducts() async {
    final response = await _categoryRepo.getCategory();
    print('getProducts data: ${response.data}');
    final categoryData = response.data;
    category.clear();
    for (dynamic data in categoryData) {
      category.add(CategoryModel.fromMap(data));
    }
    selectedCategory = [category.first];
    return category;
  }

  getEventsFromCategory({String categoryName = ''}) async {
    if (category.isEmpty) {
      await getProducts();
    }
    eventList.clear();
    for (int i = 0; i < selectedCategory.length; i++) {
      var action = selectedCategory[i];
      await fetchEvent(action.data ?? '');
    }
  }

  fetchEvent(String url) async {
    final response = await _categoryRepo.getEvent(url);
    EventModel model = EventModel.fromMap(response.data);
    eventList.addAll(model.item ?? []);
  }
}
