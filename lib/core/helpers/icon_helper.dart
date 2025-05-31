import 'package:flutter/material.dart';

class IconHelper {
  static const Map<String, IconData> _iconMap = {
    // Shopping & Groceries
    'shopping_cart': Icons.shopping_cart_rounded,
    'shopping_bag': Icons.shopping_bag_rounded,
    'local_grocery_store': Icons.local_grocery_store_rounded,
    'store': Icons.store_rounded,

    // Food & Dining
    'restaurant': Icons.restaurant_rounded,
    'local_dining': Icons.local_dining_rounded,
    'fastfood': Icons.fastfood_rounded,
    'local_cafe': Icons.local_cafe_rounded,
    'coffee': Icons.coffee_rounded,
    'lunch_dining': Icons.lunch_dining_rounded,

    // Transportation
    'directions_car': Icons.directions_car_rounded,
    'car': Icons.directions_car_rounded,
    'local_taxi': Icons.local_taxi_rounded,
    'train': Icons.train_rounded,
    'flight': Icons.flight_rounded,
    'directions_bus': Icons.directions_bus_rounded,
    'motorcycle': Icons.motorcycle_rounded,
    'local_gas_station': Icons.local_gas_station_rounded,

    // Entertainment
    'movie': Icons.movie_rounded,
    'theaters': Icons.theaters_rounded,
    'music_note': Icons.music_note_rounded,
    'sports_esports': Icons.sports_esports_rounded,
    'sports_soccer': Icons.sports_soccer_rounded,
    'celebration': Icons.celebration_rounded,
    'party_mode': Icons.party_mode_rounded,

    // Health & Medical
    'medical_services': Icons.medical_services_rounded,
    'local_hospital': Icons.local_hospital_rounded,
    'health_and_safety': Icons.health_and_safety_rounded,
    'medication': Icons.medication_rounded,
    'fitness_center': Icons.fitness_center_rounded,
    'spa': Icons.spa_rounded,

    // Home & Utilities
    'home': Icons.home_rounded,
    'house': Icons.house_rounded,
    'apartment': Icons.apartment_rounded,
    'electrical_services': Icons.electrical_services_rounded,
    'plumbing': Icons.plumbing_rounded,
    'wifi': Icons.wifi_rounded,
    'phone': Icons.phone_rounded,

    // Education & Work
    'school': Icons.school_rounded,
    'work': Icons.work_rounded,
    'laptop': Icons.laptop_rounded,
    'library_books': Icons.library_books_rounded,
    'auto_stories': Icons.auto_stories_rounded,
    'psychology': Icons.psychology_rounded,

    // Bills & Finance
    'receipt': Icons.receipt_rounded,
    'receipt_long': Icons.receipt_long_rounded,
    'credit_card': Icons.credit_card_rounded,
    'account_balance': Icons.account_balance_rounded,
    'money': Icons.monetization_on_rounded,
    'savings': Icons.savings_rounded,
    'payment': Icons.payment_rounded,

    // Gifts & Special
    'card_giftcard': Icons.card_giftcard_rounded,
    'redeem': Icons.redeem_rounded,
    'volunteer_activism': Icons.volunteer_activism_rounded,
    'favorite': Icons.favorite_rounded,

    // Personal Care
    'face': Icons.face_rounded,
    'content_cut': Icons.content_cut_rounded,
    'dry_cleaning': Icons.dry_cleaning_rounded,
    'checkroom': Icons.checkroom_rounded,

    // Travel & Vacation
    'luggage': Icons.luggage_rounded,
    'hotel': Icons.hotel_rounded,
    'beach_access': Icons.beach_access_rounded,
    'camera_alt': Icons.camera_alt_rounded,
    'map': Icons.map_rounded,

    // Technology
    'smartphone': Icons.smartphone_rounded,
    'computer': Icons.computer_rounded,
    'headphones': Icons.headphones_rounded,
    'tv': Icons.tv_rounded,
    'videogame_asset': Icons.videogame_asset_rounded,

    // Default & Misc
    'category': Icons.category_rounded,
    'more_horiz': Icons.more_horiz_rounded,
    'help': Icons.help_rounded,
    'info': Icons.info_rounded,
    'star': Icons.star_rounded,
    'bookmark': Icons.bookmark_rounded,
    'label': Icons.label_rounded,
    'local_offer': Icons.local_offer_rounded,

    // Trending & Analytics
    'trending_up': Icons.trending_up_rounded,
    'trending_down': Icons.trending_down_rounded,
    'analytics': Icons.analytics_rounded,
    'insights': Icons.insights_rounded,

    // Add commonly used icons
    'add': Icons.add_rounded,
    'edit': Icons.edit_rounded,
    'delete': Icons.delete_rounded,
    'search': Icons.search_rounded,
    'filter_list': Icons.filter_list_rounded,
    'sort': Icons.sort_rounded,
    'calendar_today': Icons.calendar_today_rounded,
    'access_time': Icons.access_time_rounded,
    'location_on': Icons.location_on_rounded,
    'person': Icons.person_rounded,
    'settings': Icons.settings_rounded,
    'notifications': Icons.notifications_rounded,
    'logout': Icons.logout_rounded,
    'menu': Icons.menu_rounded,
    'close': Icons.close_rounded,
    'check': Icons.check_rounded,
    'error': Icons.error_rounded,
    'warning': Icons.warning_rounded,
    'visibility': Icons.visibility_rounded,
    'visibility_off': Icons.visibility_off_rounded,
    'arrow_back': Icons.arrow_back_rounded,
    'arrow_forward': Icons.arrow_forward_rounded,
    'keyboard_arrow_down': Icons.keyboard_arrow_down_rounded,
    'keyboard_arrow_up': Icons.keyboard_arrow_up_rounded,
    'refresh': Icons.refresh_rounded,
    'download': Icons.download_rounded,
    'upload': Icons.upload_rounded,
    'share': Icons.share_rounded,
    'copy': Icons.copy_rounded,
  };

  /// Get IconData from string name
  static IconData getIconData(String iconName) {
    return _iconMap[iconName] ?? Icons.help_rounded;
  }

  /// Get Icon widget from string name with custom styling
  static Widget getIconWidget(
    String iconName, {
    Color? color,
    double? size,
    Color? backgroundColor,
    double? backgroundSize,
    EdgeInsets? padding,
  }) {
    final iconData = getIconData(iconName);

    Widget iconWidget = Icon(
      iconData,
      color: color ?? Colors.grey[600],
      size: size ?? 24.0,
    );

    // Add background if specified
    if (backgroundColor != null) {
      iconWidget = Container(
        width: backgroundSize ?? (size ?? 24.0) + 16.0,
        height: backgroundSize ?? (size ?? 24.0) + 16.0,
        padding: padding ?? const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: iconWidget,
      );
    }

    return iconWidget;
  }

  /// Get gradient icon widget
  static Widget getGradientIconWidget(
    String iconName, {
    required List<Color> gradientColors,
    double? size,
    AlignmentGeometry? begin,
    AlignmentGeometry? end,
  }) {
    return ShaderMask(
      shaderCallback: (bounds) => LinearGradient(
        colors: gradientColors,
        begin: begin ?? Alignment.topLeft,
        end: end ?? Alignment.bottomRight,
      ).createShader(bounds),
      child: Icon(
        getIconData(iconName),
        size: size ?? 24.0,
        color: Colors.white,
      ),
    );
  }

  /// Get category-specific icon with color
  static Widget getCategoryIcon(
    String categoryName, {
    double? size,
    Color? color,
    bool withBackground = false,
  }) {
    // Map Arabic category names to icon names
    final categoryIconMap = {
      'البقالة': 'shopping_cart',
      'طعام': 'restaurant',
      'ترفيه': 'movie',
      'مواصلات': 'directions_car',
      'صحة': 'medical_services',
      'تسوق': 'shopping_bag',
      'إيجار': 'home',
      'فواتير': 'receipt',
      'تعليم': 'school',
      'رياضة': 'fitness_center',
      'سفر': 'flight',
      'هدايا': 'card_giftcard',
      'تكنولوجيا': 'smartphone',
      'عناية شخصية': 'face',
      'مواصلات عامة': 'train',
      'قهوة': 'coffee',
      'دواء': 'medication',
      'كتب': 'library_books',
      'ملابس': 'checkroom',
      'منزل': 'house',
      'اتصالات': 'phone',
      'كهرباء': 'electrical_services',
      'غاز': 'local_gas_station',
      'ماء': 'water_drop',
      'تأمين': 'security',
      'استثمار': 'trending_up',
      'مدخرات': 'savings',
      'هدية': 'redeem',
      'تبرع': 'volunteer_activism',
      'حيوانات أليفة': 'pets',
      'حديقة': 'local_florist',
      'أطفال': 'child_care',
      'ألعاب': 'toys',
      'موسيقى': 'music_note',
      'فن': 'palette',
      'تصوير': 'camera_alt',
      'لياقة': 'fitness_center',
      'يوجا': 'self_improvement',
      'مساج': 'spa',
      'جمال': 'face_retouching_natural',
      'حلاق': 'content_cut',
      'تنظيف': 'cleaning_services',
      'صيانة': 'build',
      'أمان': 'security',
      'مواقف': 'local_parking',
      'ضرائب': 'receipt_long',
      'بنك': 'account_balance',
      'صراف': 'atm',
      'تحويل': 'currency_exchange',
      'عمولة': 'percent',
      'غرامة': 'gavel',
      'اشتراك': 'subscriptions',
      'برمجيات': 'code',
      'تطبيقات': 'apps',
      'ألعاب فيديو': 'sports_esports',
      'نيتفليكس': 'tv',
      'سبوتيفاي': 'headphones',
      'يوتيوب': 'play_circle',
      'أمازون': 'shopping_basket',
      'أوبر': 'local_taxi',
      'كريم': 'directions_car',
      'طلبات': 'delivery_dining',
      'زومي': 'motorcycle',
      'سوق': 'storefront',
      'نون': 'inventory',
      'جوميا': 'shopping_bag',
      'امازون': 'shopping_cart',
      'علي إكسبرس': 'shopping_basket',
      'شي إن': 'checkroom',
      'نمشي': 'directions_walk',
      'فارفيتش': 'diamond',
      'أجهزة': 'devices',
      'لابتوب': 'laptop',
      'موبايل': 'smartphone',
      'تابلت': 'tablet',
      'ساعة ذكية': 'watch',
      'سماعات': 'headphones',
      'شاحن': 'battery_charging_full',
      'كابل': 'cable',
      'حافظة': 'phone_case',
      'اكسسوارات': 'extension',
    };

    final iconName = categoryIconMap[categoryName] ?? 'category';

    if (withBackground) {
      return Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: (color ?? Colors.grey).withOpacity(0.1),
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Icon(
          getIconData(iconName),
          size: size ?? 24.0,
          color: color ?? Colors.grey[600],
        ),
      );
    }

    return Icon(
      getIconData(iconName),
      size: size ?? 24.0,
      color: color ?? Colors.grey[600],
    );
  }

  /// Check if icon exists
  static bool hasIcon(String iconName) {
    return _iconMap.containsKey(iconName);
  }

  /// Get all available icons
  static List<String> getAllIconNames() {
    return _iconMap.keys.toList();
  }

  /// Get icons by category
  static List<String> getIconsByCategory(String category) {
    switch (category.toLowerCase()) {
      case 'shopping':
        return [
          'shopping_cart',
          'shopping_bag',
          'local_grocery_store',
          'store'
        ];
      case 'food':
        return ['restaurant', 'fastfood', 'local_cafe', 'coffee'];
      case 'transport':
        return ['directions_car', 'train', 'flight', 'local_taxi'];
      case 'entertainment':
        return ['movie', 'music_note', 'sports_esports', 'celebration'];
      case 'health':
        return ['medical_services', 'fitness_center', 'spa', 'medication'];
      case 'home':
        return ['home', 'electrical_services', 'wifi', 'phone'];
      case 'education':
        return ['school', 'library_books', 'laptop', 'psychology'];
      case 'finance':
        return ['receipt', 'credit_card', 'savings', 'payment'];
      default:
        return ['category', 'help', 'star', 'bookmark'];
    }
  }
}
