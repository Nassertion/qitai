 import 'package:qitai/features/client/search/data/model/search_product_model.dart';

String qualityLabel (SearchProductModel product){
    switch (product.quality.toLowerCase()) {
      case 'oem':
        return 'أصلي';
      case 'aftermarket':
        return 'تجاري';
      default:
        return product.quality;
    }
  }

  bool isAftermarket(SearchProductModel product) {
    return product.quality.toLowerCase() == 'aftermarket';
  }
