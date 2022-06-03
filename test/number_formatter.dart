import 'package:flutter_calculator/number_formatter/number_formatter.dart';
import 'package:flutter_test/flutter_test.dart';

void main(){
  test('formats floating point numbers correctly', (){
    final formattedNumber = NumberFormatter.format('299.99');

    expect(formattedNumber, '299.99');
  });

  test('formats infinity correctly', (){
    final formattedNumber = NumberFormatter.format(double.infinity.toString());

    expect(formattedNumber, 'Infinity');
  });

  test('formats rounding issues correctly', (){
    final formattedNumber = NumberFormatter.format('29.0000000000000001');

    expect(formattedNumber, '29');
  });

  test('formats integers correctly', (){
    final formattedNumber = NumberFormatter.format('1003939');

    expect(formattedNumber, '1003939');
  });

  test('does not throw when not given a number', (){
    expect(NumberFormatter.format(''), '');
  });
}