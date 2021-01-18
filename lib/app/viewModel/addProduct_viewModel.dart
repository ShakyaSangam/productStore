import 'package:productstore/app/model/product.dart';
import 'package:productstore/app/repo/repository.dart';

class AddProductViewModel {
  Repository _repository = Repository();
  Future addProduct({
    String productName,
    int productSP,
    int productCP,
    int stock,
  }) async {
    Map product = Product().toMap(
        productName: productName,
        productSP: productSP,
        productCP: productCP,
        stock: stock);

    _repository.addProduct(data: product);
  }
}
