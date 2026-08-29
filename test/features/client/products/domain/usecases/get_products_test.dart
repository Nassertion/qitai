import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:qitai/features/client/products/domain/entities/product.dart';
import 'package:qitai/features/client/products/domain/repositories/product_repository.dart';
import 'package:qitai/features/client/products/domain/usecases/get_products.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class mockProductRepository extends Mock implements ProductRepository {}

void main() {
  late mockProductRepository repo;
  late GetProducts getProducts;

  setUp(() {
    repo = mockProductRepository();
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

  test("should return products from repo", () async{when(()=> repo.getProducts() ).thenAnswer((_) async => [product]);
  final result = await getProducts();

  expect(result, [product]);

  verify(() => repo.getProducts()).called(1);
  
  });
}
