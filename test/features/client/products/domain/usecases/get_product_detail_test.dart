import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:qitai/features/client/products/domain/entities/product_detail.dart';
import 'package:qitai/features/client/products/domain/repositories/product_detail_repository.dart';
import 'package:qitai/features/client/products/domain/usecases/get_products_details.dart';

class MockProductDetailRepository extends Mock
    implements ProductDetailRepository {}

void main() {
  late MockProductDetailRepository repository;
  late GetProductsDetails getProductsDetails;

  setUp(() {
    repository = MockProductDetailRepository();
    getProductsDetails = GetProductsDetails(repository);
  });

  test('should return product detail from repository', () async {
    // Arrange
    const productId = 1;

    const productDetail = ProductDetail(
      id: 1,
      name: 'Test Product',
      sku: 'SKU-1',
      partNumber: 'PART-1',
      price: 100,
      stock: 5,
      stockStatus: 'in_stock',
      condition: 'new',
      quality: 'oem',
      description: 'Test description',
      category: null,
      images: [],
      compatibilities: [],
    );

    when(
      () => repository.getProductsDetails(productId),
    ).thenAnswer((_) async => productDetail);

    // Act
    final result = await getProductsDetails(productId);

    // Assert
    expect(result, productDetail);

    verify(
      () => repository.getProductsDetails(productId),
    ).called(1);
  });
}