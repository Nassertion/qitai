
String qualityLabel (String quality){
    switch (quality.toLowerCase()) {
      case 'oem':
        return 'أصلي';
      case 'aftermarket':
        return 'تجاري';
      default:
        return quality;
    }
  }

  bool isAftermarket(String quality) {
    return quality.toLowerCase() == 'aftermarket';
  }
