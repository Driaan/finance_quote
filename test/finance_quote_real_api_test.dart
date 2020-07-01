// Copyright 2019 Ismael Jiménez. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:fin_quote/fin_quote.dart';
import 'package:mockito/mockito.dart';
import 'package:http/http.dart' as http;
import 'package:test/test.dart';

// Create a MockClient using the Mock class provided by the Mockito package.
// Create new instances of this class in each test.
class MockClient extends Mock implements http.Client {}

void main() {
  group('downloadQuotePrice/downloadRawQuote Test [FinanceQuote] - Real API',
      () {
    test('Yahoo getInfo', () async {
      Map<String, Map<String, dynamic>> quote;
      try {
        quote = await FinanceQuote.getInfo(
            quoteProvider: QuoteProvider.yahoo, symbols: <String>['KO']);
      } catch (e) {
        expect(e, 'No exception');
      }

      expect(quote.keys.length, 1);
      expect(quote['KO'].keys.length, 3);
    });

    test('Yahoo getHistoricalData', () async {
      Map<String, dynamic> data;
      try {
        data = await FinanceQuote.getHistoricalData(
            quoteProvider: QuoteProvider.yahoo, symbol: 'KO');
      } catch (e) {
        expect(e, 'No exception');
      }

      expect(data.keys.length, 6);
      expect(data['open'].length, 524);
    });

    test('MorningstarDe', () async {
      Map<String, Map<String, dynamic>> quote;
      try {
        quote = await FinanceQuote.getInfo(
            quoteProvider: QuoteProvider.morningstarDe,
            symbols: <String>['0P000001BW']);
      } catch (e) {
        expect(e, 'No exception');
      }

      expect(quote.keys.length, 1);
      expect(quote['0P000001BW'].keys.length, 2);
    });

    test('MorningstarEs', () async {
      Map<String, Map<String, dynamic>> quote;
      try {
        quote = await FinanceQuote.getInfo(
            quoteProvider: QuoteProvider.morningstarEs,
            symbols: <String>['0P000001BW']);
      } catch (e) {
        expect(e, 'No exception');
      }

      expect(quote.keys.length, 1);
      expect(quote['0P000001BW'].keys.length, 2);
    });

    test('Coincap', () async {
      Map<String, Map<String, dynamic>> quote;
      try {
        quote = await FinanceQuote.getInfo(
            quoteProvider: QuoteProvider.coincap, symbols: <String>['bitcoin']);
      } catch (e) {
        expect(e, 'No exception');
      }

      expect(quote.keys.length, 1);
      expect(quote['bitcoin'].keys.length, 2);
    });

    test('Binance', () async {
      Map<String, Map<String, dynamic>> quote;
      try {
        quote = await FinanceQuote.getInfo(
            quoteProvider: QuoteProvider.binance, symbols: <String>['BTCUSDT']);
      } catch (e) {
        expect(e, 'No exception');
      }

      expect(quote.keys.length, 1);
      expect(quote['BTCUSDT'].keys.length, 2);
    });
  });
}
