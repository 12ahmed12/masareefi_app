import 'package:flutter/foundation.dart';

import '../../features/dashboard/data/models/category_model.dart';
import '../models/product_model.dart';

class Dummy {
  static final List<CategoryModel> kDefaultCategories = [
    const CategoryModel(
        id: 1,
        label: 'البقالة',
        iconName: 'shopping_cart',
        colorHex: '#4FC3F7'), // Blue
    const CategoryModel(
        id: 2,
        label: 'الترفيه',
        iconName: 'celebration',
        colorHex: '#BA68C8'), // Purple
    const CategoryModel(
        id: 3,
        label: 'الوقود',
        iconName: 'local_gas_station',
        colorHex: '#EF5350'), // Red
    const CategoryModel(
        id: 4,
        label: 'التسوق',
        iconName: 'shopping_bag',
        colorHex: '#FFD54F'), // Yellow
    const CategoryModel(
        id: 5,
        label: 'الصحف',
        iconName: 'menu_book',
        colorHex: '#FFB74D'), // Orange
    const CategoryModel(
        id: 6,
        label: 'المواصلات',
        iconName: 'commute',
        colorHex: '#9575CD'), // Lavender
    const CategoryModel(
        id: 7,
        label: 'الإيجار',
        iconName: 'home_work',
        colorHex: '#81C784'), // Green
    const CategoryModel(
        id: 8,
        label: 'الصحة',
        iconName: 'local_hospital',
        colorHex: '#4DD0E1'), // Cyan
    const CategoryModel(
        id: 9,
        label: 'المطاعم',
        iconName: 'restaurant',
        colorHex: '#FF8A65'), // Deep orange
    const CategoryModel(
        id: 10,
        label: 'التعليم',
        iconName: 'school',
        colorHex: '#64B5F6'), // Light blue
  ];
}
