import 'package:ishonch/data/models/discount/discount_model.dart';

abstract class DiscountState {}

class DiscountInitial extends DiscountState{}

class GettingDiscountInProgress extends DiscountState{}
class GettingDiscountInSuccess extends DiscountState{
  List<Discount> discount;
  GettingDiscountInSuccess({required this.discount});
}
class GettingDiscountInFailury extends DiscountState{
  String status;
  GettingDiscountInFailury({required this.status});
}