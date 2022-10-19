import 'package:salaya_delivery_app/data/models/basket_object.dart';
import 'package:salaya_delivery_app/presentation/utils/number_format_extension.dart';

int getTotalCountInBasket({required List<BasketObject> baskets}) {
  int count = 0;
  for (BasketObject item in baskets) {
    count = count + item.qty;
  }
  return count;
}

double getTotalPriceInBasket({required List<BasketObject> baskets}) {
  double totalPrice = 0;
  for(BasketObject item in baskets) {
    totalPrice = totalPrice + (item.qty * item.product.pricePerUnit);
  }
  return totalPrice;
}