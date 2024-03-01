// Define a global provider for orderId
import 'package:flutter_riverpod/flutter_riverpod.dart';

final orderIdProvider = StateProvider<String?>((ref) => null);

// Define a global provider for amount
final amountProvider = StateProvider<int?>((ref) => null);
