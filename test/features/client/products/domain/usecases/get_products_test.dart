import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

import 'package:qitai/features/client/products/domain/entities/product.dart';
import 'package:qitai/features/client/products/domain/entities/product_pagination.dart';
import 'package:qitai/features/client/products/domain/repositories/product_repository.dart';
import 'package:qitai/features/client/products/domain/usecases/get_products.dart';

class MockProductRepository extends Mock implements ProductRepository {}

void main() {
  late MockProductRepository repo;
  late GetProducts getProducts;

  setUp(() {
    repo = MockProductRepository();
    getProducts = GetProducts(repo);
  });

  final product = Product(
    id: 1,
    name: "test",
    sku: "test",
    partNumber: "1",
    condition: "new",
    quality: "oem",
    price: 1,
    stock: 1,
    inStock: true,
    images: [],
    category: null,
  );

  test("should return products pagination from repo", () async {
    // Arrange
    final pagination = ProductPagination(
      products: [product],
      currentPage: 1,
      lastPage: 1,
      perPage: 20,
      total: 1,
    );

    when(
      () => repo.getProducts(),
    ).thenAnswer((_) async => pagination);

    // Act
    final result = await getProducts();

    // Assert
    expect(result.products, [product]);
    expect(result.currentPage, 1);
    expect(result.lastPage, 1);
    expect(result.perPage, 20);
    expect(result.total, 1);

    verify(
      () => repo.getProducts(),
    ).called(1);
  });
}