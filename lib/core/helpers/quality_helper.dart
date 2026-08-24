import 'package:qitai/features/client/products/domain/entities/product.dart';

String qualityLabel (Product product){
    switch (product.quality.toLowerCase()) {
      case 'oem':
        return 'أصلي';
      case 'aftermarket':
        return 'تجاري';
      default:
        return product.quality;
    }
  }

  bool isAftermarket(Product product) {
    return product.quality.toLowerCase() == 'aftermarket';
  }
