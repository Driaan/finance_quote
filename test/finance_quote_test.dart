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
  test('getRawData - No symbol', () async {
    final MockClient client = MockClient();

    Map<String, Map<String, dynamic>> quote;
    try {
      quote = await FinanceQuote.getRawData(
          quoteProvider: QuoteProvider.yahoo,
          symbols: <String>[],
          client: client);
    } catch (e) {
      expect(e, 'No exception');
    }

    expect(quote.keys.length, 0);
  });

  test('getPrice - No symbol', () async {
    final MockClient client = MockClient();

    Map<String, Map<String, dynamic>> quote;
    try {
      quote = await FinanceQuote.getPrice(
          quoteProvider: QuoteProvider.yahoo,
          symbols: <String>[],
          client: client);
    } catch (e) {
      expect(e, 'No exception');
    }

    expect(quote.keys.length, 0);
  });

  group('getRawData Test [FinanceQuote] - Yahoo', () {
    test('Yahoo: 1 symbol, 200 - Response', () async {
      final MockClient client = MockClient();

      when(client.get(
              'https://query1.finance.yahoo.com/v7/finance/quote?symbols=KO'))
          .thenAnswer((_) async => http.Response(
              '{"quoteResponse":{"result":[{"language":"en-US","region":"US","quoteType":"EQUITY","quoteSourceName":"Nasdaq Real Time Price","currency":"USD","regularMarketPrice":53.985,"regularMarketTime":1566409386,"regularMarketChange":0.10499954,"regularMarketOpen":54.25,"regularMarketDayHigh":54.41,"regularMarketDayLow":53.94,"regularMarketVolume":2718994,"regularMarketChangePercent":0.19487666,"regularMarketDayRange":"53.94 - 54.41","regularMarketPreviousClose":53.88,"bid":54.02,"ask":54.03,"bidSize":11,"askSize":14,"messageBoardId":"finmb_26642","fullExchangeName":"NYSE","longName":"The Coca-Cola Company","financialCurrency":"USD","averageDailyVolume3Month":12406673,"averageDailyVolume10Day":11250333,"fiftyTwoWeekLowChange":9.735001,"fiftyTwoWeekLowChangePercent":0.22000001,"fiftyTwoWeekRange":"44.25 - 54.82","fiftyTwoWeekHighChange":-0.8349991,"fiftyTwoWeekHighChangePercent":-0.01523165,"fiftyTwoWeekLow":44.25,"fiftyTwoWeekHigh":54.82,"dividendDate":1569888000,"earningsTimestamp":1563899400,"earningsTimestampStart":1572280200,"earningsTimestampEnd":1572625800,"trailingAnnualDividendRate":1.58,"trailingPE":32.917683,"trailingAnnualDividendYield":0.029324425,"epsTrailingTwelveMonths":1.64,"epsForward":2.29,"esgPopulated":false,"tradeable":true,"triggerable":true,"twoHundredDayAverageChangePercent":0.09685095,"marketCap":227422601216,"market":"us_market","exchangeDataDelayedBy":0,"marketState":"REGULAR","exchange":"NYQ","shortName":"Coca-Cola Company (The)","sharesOutstanding":4266119936,"bookValue":4.253,"fiftyDayAverage":52.757942,"fiftyDayAverageChange":1.2270584,"fiftyDayAverageChangePercent":0.023258269,"twoHundredDayAverage":49.218174,"twoHundredDayAverageChange":4.7668266,"forwardPE":23.574236,"priceToBook":12.693394,"sourceInterval":15,"exchangeTimezoneName":"America/New_York","exchangeTimezoneShortName":"EDT","gmtOffSetMilliseconds":-14400000,"priceHint":2,"symbol":"KO"}],"error":null}}',
              200));

      Map<String, Map<String, dynamic>> quote;
      try {
        quote = await FinanceQuote.getRawData(
            quoteProvider: QuoteProvider.yahoo,
            symbols: <String>['KO'],
            client: client);
      } catch (e) {
        expect(e, 'No exception');
      }

      expect(quote.keys.length, 1);
      expect(quote['KO'].keys.length, 66);
      expect(quote['KO']['symbol'], 'KO');
      expect(quote['KO']['regularMarketPrice'], 53.985);

      verify(client.get(
              'https://query1.finance.yahoo.com/v7/finance/quote?symbols=KO'))
          .called(1);
    });

    test('Yahoo: 3 symbols, 200 - Response', () async {
      final MockClient client = MockClient();

      when(client.get(
              'https://query1.finance.yahoo.com/v7/finance/quote?symbols=KO,GOOG,AIR.PA'))
          .thenAnswer((_) async => http.Response(
              '{"quoteResponse":{"result":[{"language":"en-US","region":"US","quoteType":"EQUITY","quoteSourceName":"Nasdaq Real Time Price","currency":"USD","market":"us_market","shortName":"Coca-Cola Company (The)","exchangeDataDelayedBy":0,"regularMarketPrice":54.75,"regularMarketTime":1566929670,"regularMarketChange":0.20999908,"regularMarketOpen":54.7,"regularMarketDayHigh":54.835,"regularMarketDayLow":54.41,"regularMarketVolume":5243563,"priceHint":2,"regularMarketChangePercent":0.3850368,"regularMarketDayRange":"54.41 - 54.835","regularMarketPreviousClose":54.54,"bid":54.75,"ask":54.76,"bidSize":8,"askSize":14,"messageBoardId":"finmb_26642","fullExchangeName":"NYSE","sharesOutstanding":4266119936,"bookValue":4.253,"fiftyDayAverage":53.009167,"fiftyDayAverageChange":1.7408333,"fiftyDayAverageChangePercent":0.03284023,"twoHundredDayAverage":49.394566,"twoHundredDayAverageChange":5.3554344,"twoHundredDayAverageChangePercent":0.108421534,"marketCap":234112647168,"forwardPE":23.908297,"priceToBook":12.873266,"sourceInterval":15,"esgPopulated":false,"tradeable":true,"triggerable":true,"marketState":"REGULAR","longName":"The Coca-Cola Company","financialCurrency":"USD","averageDailyVolume3Month":12287168,"averageDailyVolume10Day":10142433,"fiftyTwoWeekLowChange":10.5,"fiftyTwoWeekLowChangePercent":0.23728813,"fiftyTwoWeekRange":"44.25 - 54.835","fiftyTwoWeekHighChange":-0.084999084,"fiftyTwoWeekHighChangePercent":-0.0015500882,"fiftyTwoWeekLow":44.25,"fiftyTwoWeekHigh":54.835,"dividendDate":1569888000,"earningsTimestamp":1563899400,"earningsTimestampStart":1572280200,"earningsTimestampEnd":1572625800,"trailingAnnualDividendRate":1.58,"trailingPE":33.384148,"trailingAnnualDividendYield":0.028969564,"epsTrailingTwelveMonths":1.64,"epsForward":2.29,"exchangeTimezoneName":"America/New_York","exchangeTimezoneShortName":"EDT","gmtOffSetMilliseconds":-14400000,"exchange":"NYQ","symbol":"KO"},{"language":"en-US","region":"US","quoteType":"EQUITY","quoteSourceName":"Nasdaq Real Time Price","currency":"USD","market":"us_market","shortName":"Alphabet Inc.","exchangeDataDelayedBy":0,"regularMarketPrice":1163.5787,"regularMarketTime":1566929642,"regularMarketChange":-5.3112793,"regularMarketOpen":1180.53,"regularMarketDayHigh":1182.4,"regularMarketDayLow":1163.2001,"regularMarketVolume":624758,"priceHint":2,"regularMarketChangePercent":-0.45438656,"regularMarketDayRange":"1163.2001 - 1182.4","regularMarketPreviousClose":1168.89,"bid":1164.7,"ask":1165.19,"bidSize":8,"askSize":8,"messageBoardId":"finmb_29096","fullExchangeName":"NasdaqGS","sharesOutstanding":348264000,"bookValue":276.914,"fiftyDayAverage":1170.5172,"fiftyDayAverageChange":-6.9384766,"fiftyDayAverageChangePercent":-0.0059277015,"twoHundredDayAverage":1156.6758,"twoHundredDayAverageChange":6.902954,"twoHundredDayAverageChangePercent":0.005967925,"marketCap":807612121088,"forwardPE":20.856403,"priceToBook":4.2019496,"sourceInterval":15,"esgPopulated":false,"tradeable":true,"triggerable":true,"marketState":"REGULAR","longName":"Alphabet Inc.","financialCurrency":"USD","averageDailyVolume3Month":1518654,"averageDailyVolume10Day":1124733,"fiftyTwoWeekLowChange":193.46875,"fiftyTwoWeekLowChangePercent":0.1994297,"fiftyTwoWeekRange":"970.11 - 1289.27","fiftyTwoWeekHighChange":-125.691284,"fiftyTwoWeekHighChangePercent":-0.09749027,"fiftyTwoWeekLow":970.11,"fiftyTwoWeekHigh":1289.27,"trailingPE":23.490032,"epsTrailingTwelveMonths":49.535,"epsForward":55.79,"exchangeTimezoneName":"America/New_York","exchangeTimezoneShortName":"EDT","gmtOffSetMilliseconds":-14400000,"exchange":"NMS","symbol":"GOOG"},{"language":"en-US","region":"US","quoteType":"EQUITY","currency":"EUR","market":"fr_market","shortName":"AIRBUS","exchangeDataDelayedBy":0,"regularMarketPrice":122.56,"regularMarketTime":1566920121,"regularMarketChange":-0.27999878,"regularMarketOpen":122.94,"regularMarketDayHigh":123.2,"regularMarketDayLow":121.76,"regularMarketVolume":797067,"priceHint":2,"regularMarketChangePercent":-0.2279378,"regularMarketDayRange":"121.76 - 123.2","regularMarketPreviousClose":122.84,"bid":0.0,"ask":0.0,"bidSize":0,"askSize":0,"messageBoardId":"finmb_561001","fullExchangeName":"Paris","sharesOutstanding":777459968,"bookValue":9.561,"fiftyDayAverage":126.71333,"fiftyDayAverageChange":-4.1533356,"fiftyDayAverageChangePercent":-0.032777414,"twoHundredDayAverage":120.029434,"twoHundredDayAverageChange":2.5305634,"twoHundredDayAverageChangePercent":0.021082856,"marketCap":95290032128,"forwardPE":21.964157,"priceToBook":12.818743,"sourceInterval":15,"esgPopulated":false,"tradeable":false,"triggerable":false,"marketState":"POSTPOST","longName":"Airbus SE","financialCurrency":"EUR","averageDailyVolume3Month":1108838,"averageDailyVolume10Day":899513,"fiftyTwoWeekLowChange":45.059998,"fiftyTwoWeekLowChangePercent":0.58141935,"fiftyTwoWeekRange":"77.5 - 133.86","fiftyTwoWeekHighChange":-11.300003,"fiftyTwoWeekHighChangePercent":-0.084416576,"fiftyTwoWeekLow":77.5,"fiftyTwoWeekHigh":133.86,"earningsTimestamp":1572413400,"earningsTimestampStart":1550017800,"earningsTimestampEnd":1550467800,"trailingAnnualDividendRate":1.65,"trailingPE":25.48025,"trailingAnnualDividendYield":0.013432107,"epsTrailingTwelveMonths":4.81,"epsForward":5.58,"exchangeTimezoneName":"Europe/Paris","exchangeTimezoneShortName":"CEST","gmtOffSetMilliseconds":7200000,"exchange":"PAR","symbol":"AIR.PA"}],"error":null}}',
              200));

      Map<String, Map<String, dynamic>> quote;
      try {
        quote = await FinanceQuote.getRawData(
            quoteProvider: QuoteProvider.yahoo,
            symbols: <String>['KO', 'GOOG', 'AIR.PA'],
            client: client);
      } catch (e) {
        expect(e, 'No exception');
      }

      expect(quote.keys.length, 3);
      expect(quote['KO'].keys.length, 66);
      expect(quote['KO']['symbol'], 'KO');
      expect(quote['KO']['regularMarketPrice'], 54.75);
      expect(quote['GOOG'].keys.length, 60);
      expect(quote['GOOG']['symbol'], 'GOOG');
      expect(quote['GOOG']['regularMarketPrice'], 1163.5787);
      expect(quote['AIR.PA'].keys.length, 64);
      expect(quote['AIR.PA']['symbol'], 'AIR.PA');
      expect(quote['AIR.PA']['regularMarketPrice'], 122.56);

      verify(client.get(
              'https://query1.finance.yahoo.com/v7/finance/quote?symbols=KO,GOOG,AIR.PA'))
          .called(1);
    });

    test('Yahoo: null, 200 - Response', () async {
      final MockClient client = MockClient();

      when(client.get(
              'https://query1.finance.yahoo.com/v7/finance/quote?symbols=KO'))
          .thenAnswer((_) async => http.Response(
              '{"quoteResponse":{"result":[],"error":null}}', 200));

      Map<String, Map<String, dynamic>> quote;
      try {
        quote = await FinanceQuote.getRawData(
            quoteProvider: QuoteProvider.yahoo,
            symbols: <String>['KO'],
            client: client);
      } catch (e) {
        expect(e, 'No exception');
      }

      expect(quote.keys.length, 0);

      verify(client.get(
              'https://query1.finance.yahoo.com/v7/finance/quote?symbols=KO'))
          .called(1);
    });

    test('Yahoo: 404 - Response', () async {
      final MockClient client = MockClient();

      when(client.get(
              'https://query1.finance.yahoo.com/v7/finance/quote?symbols=KO'))
          .thenAnswer((_) async => http.Response(
              '{"description":"NotFoundException: HTTP 404 Not Found","detail":{"content":["NotFoundException: HTTP 404 Not Found"]},"uri":"http://yahoo.com","lang":"en-US"}',
              404));

      Map<String, Map<String, dynamic>> quote;
      try {
        quote = await FinanceQuote.getRawData(
            quoteProvider: QuoteProvider.yahoo,
            symbols: <String>['KO'],
            client: client);
      } catch (e) {
        expect(e, 'No exception');
      }

      expect(quote.keys.length, 0);

      verify(client.get(
              'https://query1.finance.yahoo.com/v7/finance/quote?symbols=KO'))
          .called(1);
    });
  });

  group('getPrice Test [FinanceQuote] - Yahoo', () {
    test('Yahoo: 1 symbol, 200 - Response', () async {
      final MockClient client = MockClient();

      when(client.get(
              'https://query1.finance.yahoo.com/v7/finance/quote?symbols=KO'))
          .thenAnswer((_) async => http.Response(
              '{"quoteResponse":{"result":[{"language":"en-US","region":"US","quoteType":"EQUITY","quoteSourceName":"Nasdaq Real Time Price","currency":"USD","regularMarketPrice":53.985,"regularMarketTime":1566409386,"regularMarketChange":0.10499954,"regularMarketOpen":54.25,"regularMarketDayHigh":54.41,"regularMarketDayLow":53.94,"regularMarketVolume":2718994,"regularMarketChangePercent":0.19487666,"regularMarketDayRange":"53.94 - 54.41","regularMarketPreviousClose":53.88,"bid":54.02,"ask":54.03,"bidSize":11,"askSize":14,"messageBoardId":"finmb_26642","fullExchangeName":"NYSE","longName":"The Coca-Cola Company","financialCurrency":"USD","averageDailyVolume3Month":12406673,"averageDailyVolume10Day":11250333,"fiftyTwoWeekLowChange":9.735001,"fiftyTwoWeekLowChangePercent":0.22000001,"fiftyTwoWeekRange":"44.25 - 54.82","fiftyTwoWeekHighChange":-0.8349991,"fiftyTwoWeekHighChangePercent":-0.01523165,"fiftyTwoWeekLow":44.25,"fiftyTwoWeekHigh":54.82,"dividendDate":1569888000,"earningsTimestamp":1563899400,"earningsTimestampStart":1572280200,"earningsTimestampEnd":1572625800,"trailingAnnualDividendRate":1.58,"trailingPE":32.917683,"trailingAnnualDividendYield":0.029324425,"epsTrailingTwelveMonths":1.64,"epsForward":2.29,"esgPopulated":false,"tradeable":true,"triggerable":true,"twoHundredDayAverageChangePercent":0.09685095,"marketCap":227422601216,"market":"us_market","exchangeDataDelayedBy":0,"marketState":"REGULAR","exchange":"NYQ","shortName":"Coca-Cola Company (The)","sharesOutstanding":4266119936,"bookValue":4.253,"fiftyDayAverage":52.757942,"fiftyDayAverageChange":1.2270584,"fiftyDayAverageChangePercent":0.023258269,"twoHundredDayAverage":49.218174,"twoHundredDayAverageChange":4.7668266,"forwardPE":23.574236,"priceToBook":12.693394,"sourceInterval":15,"exchangeTimezoneName":"America/New_York","exchangeTimezoneShortName":"EDT","gmtOffSetMilliseconds":-14400000,"priceHint":2,"symbol":"KO"}],"error":null}}',
              200));

      Map<String, Map<String, String>> quote;
      try {
        quote = await FinanceQuote.getPrice(
            quoteProvider: QuoteProvider.yahoo,
            symbols: <String>['KO'],
            client: client);
      } catch (e) {
        expect(e, 'No exception');
      }

      expect(quote.keys.length, 1);
      expect(quote['KO'].keys.length, 3);
      expect(quote['KO']['price'], '53.98');
      expect(quote['KO']['currency'], 'USD');
      expect(quote['KO']['change'], '0.19');

      verify(client.get(
              'https://query1.finance.yahoo.com/v7/finance/quote?symbols=KO'))
          .called(1);
    });

    test('Yahoo: 3 symbols, 200 - Response', () async {
      final MockClient client = MockClient();

      when(client.get(
              'https://query1.finance.yahoo.com/v7/finance/quote?symbols=KO,GOOG,AIR.PA'))
          .thenAnswer((_) async => http.Response(
              '{"quoteResponse":{"result":[{"language":"en-US","region":"US","quoteType":"EQUITY","quoteSourceName":"Nasdaq Real Time Price","currency":"USD","market":"us_market","shortName":"Coca-Cola Company (The)","exchangeDataDelayedBy":0,"regularMarketPrice":54.75,"regularMarketTime":1566929670,"regularMarketChange":0.20999908,"regularMarketOpen":54.7,"regularMarketDayHigh":54.835,"regularMarketDayLow":54.41,"regularMarketVolume":5243563,"priceHint":2,"regularMarketChangePercent":0.3850368,"regularMarketDayRange":"54.41 - 54.835","regularMarketPreviousClose":54.54,"bid":54.75,"ask":54.76,"bidSize":8,"askSize":14,"messageBoardId":"finmb_26642","fullExchangeName":"NYSE","sharesOutstanding":4266119936,"bookValue":4.253,"fiftyDayAverage":53.009167,"fiftyDayAverageChange":1.7408333,"fiftyDayAverageChangePercent":0.03284023,"twoHundredDayAverage":49.394566,"twoHundredDayAverageChange":5.3554344,"twoHundredDayAverageChangePercent":0.108421534,"marketCap":234112647168,"forwardPE":23.908297,"priceToBook":12.873266,"sourceInterval":15,"esgPopulated":false,"tradeable":true,"triggerable":true,"marketState":"REGULAR","longName":"The Coca-Cola Company","financialCurrency":"USD","averageDailyVolume3Month":12287168,"averageDailyVolume10Day":10142433,"fiftyTwoWeekLowChange":10.5,"fiftyTwoWeekLowChangePercent":0.23728813,"fiftyTwoWeekRange":"44.25 - 54.835","fiftyTwoWeekHighChange":-0.084999084,"fiftyTwoWeekHighChangePercent":-0.0015500882,"fiftyTwoWeekLow":44.25,"fiftyTwoWeekHigh":54.835,"dividendDate":1569888000,"earningsTimestamp":1563899400,"earningsTimestampStart":1572280200,"earningsTimestampEnd":1572625800,"trailingAnnualDividendRate":1.58,"trailingPE":33.384148,"trailingAnnualDividendYield":0.028969564,"epsTrailingTwelveMonths":1.64,"epsForward":2.29,"exchangeTimezoneName":"America/New_York","exchangeTimezoneShortName":"EDT","gmtOffSetMilliseconds":-14400000,"exchange":"NYQ","symbol":"KO"},{"language":"en-US","region":"US","quoteType":"EQUITY","quoteSourceName":"Nasdaq Real Time Price","currency":"USD","market":"us_market","shortName":"Alphabet Inc.","exchangeDataDelayedBy":0,"regularMarketPrice":1163.5787,"regularMarketTime":1566929642,"regularMarketChange":-5.3112793,"regularMarketOpen":1180.53,"regularMarketDayHigh":1182.4,"regularMarketDayLow":1163.2001,"regularMarketVolume":624758,"priceHint":2,"regularMarketChangePercent":-0.45438656,"regularMarketDayRange":"1163.2001 - 1182.4","regularMarketPreviousClose":1168.89,"bid":1164.7,"ask":1165.19,"bidSize":8,"askSize":8,"messageBoardId":"finmb_29096","fullExchangeName":"NasdaqGS","sharesOutstanding":348264000,"bookValue":276.914,"fiftyDayAverage":1170.5172,"fiftyDayAverageChange":-6.9384766,"fiftyDayAverageChangePercent":-0.0059277015,"twoHundredDayAverage":1156.6758,"twoHundredDayAverageChange":6.902954,"twoHundredDayAverageChangePercent":0.005967925,"marketCap":807612121088,"forwardPE":20.856403,"priceToBook":4.2019496,"sourceInterval":15,"esgPopulated":false,"tradeable":true,"triggerable":true,"marketState":"REGULAR","longName":"Alphabet Inc.","financialCurrency":"USD","averageDailyVolume3Month":1518654,"averageDailyVolume10Day":1124733,"fiftyTwoWeekLowChange":193.46875,"fiftyTwoWeekLowChangePercent":0.1994297,"fiftyTwoWeekRange":"970.11 - 1289.27","fiftyTwoWeekHighChange":-125.691284,"fiftyTwoWeekHighChangePercent":-0.09749027,"fiftyTwoWeekLow":970.11,"fiftyTwoWeekHigh":1289.27,"trailingPE":23.490032,"epsTrailingTwelveMonths":49.535,"epsForward":55.79,"exchangeTimezoneName":"America/New_York","exchangeTimezoneShortName":"EDT","gmtOffSetMilliseconds":-14400000,"exchange":"NMS","symbol":"GOOG"},{"language":"en-US","region":"US","quoteType":"EQUITY","currency":"EUR","market":"fr_market","shortName":"AIRBUS","exchangeDataDelayedBy":0,"regularMarketPrice":122.56,"regularMarketTime":1566920121,"regularMarketChange":-0.27999878,"regularMarketOpen":122.94,"regularMarketDayHigh":123.2,"regularMarketDayLow":121.76,"regularMarketVolume":797067,"priceHint":2,"regularMarketChangePercent":-0.2279378,"regularMarketDayRange":"121.76 - 123.2","regularMarketPreviousClose":122.84,"bid":0.0,"ask":0.0,"bidSize":0,"askSize":0,"messageBoardId":"finmb_561001","fullExchangeName":"Paris","sharesOutstanding":777459968,"bookValue":9.561,"fiftyDayAverage":126.71333,"fiftyDayAverageChange":-4.1533356,"fiftyDayAverageChangePercent":-0.032777414,"twoHundredDayAverage":120.029434,"twoHundredDayAverageChange":2.5305634,"twoHundredDayAverageChangePercent":0.021082856,"marketCap":95290032128,"forwardPE":21.964157,"priceToBook":12.818743,"sourceInterval":15,"esgPopulated":false,"tradeable":false,"triggerable":false,"marketState":"POSTPOST","longName":"Airbus SE","financialCurrency":"EUR","averageDailyVolume3Month":1108838,"averageDailyVolume10Day":899513,"fiftyTwoWeekLowChange":45.059998,"fiftyTwoWeekLowChangePercent":0.58141935,"fiftyTwoWeekRange":"77.5 - 133.86","fiftyTwoWeekHighChange":-11.300003,"fiftyTwoWeekHighChangePercent":-0.084416576,"fiftyTwoWeekLow":77.5,"fiftyTwoWeekHigh":133.86,"earningsTimestamp":1572413400,"earningsTimestampStart":1550017800,"earningsTimestampEnd":1550467800,"trailingAnnualDividendRate":1.65,"trailingPE":25.48025,"trailingAnnualDividendYield":0.013432107,"epsTrailingTwelveMonths":4.81,"epsForward":5.58,"exchangeTimezoneName":"Europe/Paris","exchangeTimezoneShortName":"CEST","gmtOffSetMilliseconds":7200000,"exchange":"PAR","symbol":"AIR.PA"}],"error":null}}',
              200));

      Map<String, Map<String, String>> quote;
      try {
        quote = await FinanceQuote.getPrice(
            quoteProvider: QuoteProvider.yahoo,
            symbols: <String>['KO', 'GOOG', 'AIR.PA'],
            client: client);
      } catch (e) {
        expect(e, 'No exception');
      }

      expect(quote.keys.length, 3);
      expect(quote['KO'].keys.length, 3);
      expect(quote['KO']['price'], '54.75');
      expect(quote['KO']['currency'], 'USD');
      expect(quote['KO']['change'], '0.39');
      expect(quote['GOOG'].keys.length, 3);
      expect(quote['GOOG']['price'], '1163.58');
      expect(quote['GOOG']['currency'], 'USD');
      expect(quote['GOOG']['change'], '-0.45');
      expect(quote['AIR.PA'].keys.length, 3);
      expect(quote['AIR.PA']['price'], '122.56');
      expect(quote['AIR.PA']['currency'], 'EUR');
      expect(quote['AIR.PA']['change'], '-0.23');

      verify(client.get(
              'https://query1.finance.yahoo.com/v7/finance/quote?symbols=KO,GOOG,AIR.PA'))
          .called(1);
    });

    test('Yahoo: null, 200 - Response', () async {
      final MockClient client = MockClient();

      when(client.get(
              'https://query1.finance.yahoo.com/v7/finance/quote?symbols=KO'))
          .thenAnswer((_) async => http.Response(
              '{"quoteResponse":{"result":[],"error":null}}', 200));

      Map<String, Map<String, String>> quote;
      try {
        quote = await FinanceQuote.getPrice(
            quoteProvider: QuoteProvider.yahoo,
            symbols: <String>['KO'],
            client: client);
      } catch (e) {
        expect(e, 'No exception');
      }

      expect(quote.keys.length, 0);

      verify(client.get(
              'https://query1.finance.yahoo.com/v7/finance/quote?symbols=KO'))
          .called(1);
    });

    test('Yahoo: 404 - Response', () async {
      final MockClient client = MockClient();

      when(client.get(
              'https://query1.finance.yahoo.com/v7/finance/quote?symbols=KO'))
          .thenAnswer((_) async => http.Response(
              '{"description":"NotFoundException: HTTP 404 Not Found","detail":{"content":["NotFoundException: HTTP 404 Not Found"]},"uri":"http://yahoo.com","lang":"en-US"}',
              404));

      Map<String, Map<String, String>> quote;
      try {
        quote = await FinanceQuote.getPrice(
            quoteProvider: QuoteProvider.yahoo,
            symbols: <String>['KO'],
            client: client);
      } catch (e) {
        expect(e, 'No exception');
      }

      expect(quote.keys.length, 0);

      verify(client.get(
              'https://query1.finance.yahoo.com/v7/finance/quote?symbols=KO'))
          .called(1);
    });
  });

  group('getRawData Test [FinanceQuote] - MorningstarDe', () {
    test('MorningstarDe: 1 symbol, 200 - Response', () async {
      final MockClient client = MockClient();

      when(client.get(
              'http://tools.morningstar.de/de/stockreport/default.aspx?id=0P000001BW'))
          .thenAnswer((_) async => http.Response(
              '<div id="IntradayPriceSummary" class="Wide clearfix"><div class="container fourTenths first "><!-- start of RetailIntradayPriceSummaryQuotationWide --><div id="IntradayPriceSummaryQuotationWide" class="box"><div class="clearfix"><div class="headlinePricing first"><strong>Letzter Kurs</strong><br /><span class="price" id="Col0Price">55,04</span></div><div class="headlinePricing"><strong>Veränderung zum Vortag</strong><br /><span id="Col0PriceArrow" class="price"></span><span id="Col0PriceDetail" class="price">-0,01|-0,02<span class="percentage">%</span></span></div></div><p class="priceInformation" id="Col0PriceTime">per 30.08.2019<br />19:39:23 <abbr title="TimeZone_EDT">EDT</abbr> | USD ',
              200));

      Map<String, Map<String, dynamic>> quote;
      try {
        quote = await FinanceQuote.getRawData(
            quoteProvider: QuoteProvider.morningstarDe,
            symbols: <String>['0P000001BW'],
            client: client);
      } catch (e) {
        expect(e, 'No exception');
      }

      expect(quote.keys.length, 1);
      expect(quote['0P000001BW'].keys.length, 2);
      expect(quote['0P000001BW']['price'], '55.04');
      expect(quote['0P000001BW']['currency'], 'USD');

      verify(client.get(
              'http://tools.morningstar.de/de/stockreport/default.aspx?id=0P000001BW'))
          .called(1);
    });

    test('MorningstarDe: 3 symbols, 200 - Response', () async {
      final MockClient client = MockClient();

      when(client.get(
              'http://tools.morningstar.de/de/stockreport/default.aspx?id=0P000001BW'))
          .thenAnswer((_) async => http.Response(
              '<div id="IntradayPriceSummary" class="Wide clearfix"><div class="container fourTenths first "><!-- start of RetailIntradayPriceSummaryQuotationWide --><div id="IntradayPriceSummaryQuotationWide" class="box"><div class="clearfix"><div class="headlinePricing first"><strong>Letzter Kurs</strong><br /><span class="price" id="Col0Price">55,04</span></div><div class="headlinePricing"><strong>Veränderung zum Vortag</strong><br /><span id="Col0PriceArrow" class="price"></span><span id="Col0PriceDetail" class="price">-0,01|-0,02<span class="percentage">%</span></span></div></div><p class="priceInformation" id="Col0PriceTime">per 30.08.2019<br />19:39:23 <abbr title="TimeZone_EDT">EDT</abbr> | USD ',
              200));

      when(client.get(
              'http://tools.morningstar.de/de/stockreport/default.aspx?id=0P00012BBI'))
          .thenAnswer((_) async => http.Response(
              '<div id="IntradayPriceSummary" class="Wide clearfix"><div class="container fourTenths first "><!-- start of RetailIntradayPriceSummaryQuotationWide --><div id="IntradayPriceSummaryQuotationWide" class="box"><div class="clearfix"><div class="headlinePricing first"><strong>Letzter Kurs</strong><br /><span class="price" id="Col0Price">1.188,10</span></div><div class="headlinePricing"><strong>Veränderung zum Vortag</strong><br /><span id="Col0PriceArrow" class="price"></span><span id="Col0PriceDetail" class="price">-0,01|-0,02<span class="percentage">%</span></span></div></div><p class="priceInformation" id="Col0PriceTime">per 30.08.2019<br />19:39:23 <abbr title="TimeZone_EDT">EDT</abbr> | USD ',
              200));

      when(client.get(
              'http://tools.morningstar.de/de/stockreport/default.aspx?id=0P00009QPB'))
          .thenAnswer((_) async => http.Response(
              '<div id="IntradayPriceSummary" class="Wide clearfix"><div class="container fourTenths first "><!-- start of RetailIntradayPriceSummaryQuotationWide --><div id="IntradayPriceSummaryQuotationWide" class="box"><div class="clearfix"><div class="headlinePricing first"><strong>Letzter Kurs</strong><br /><span class="price" id="Col0Price">125,30</span></div><div class="headlinePricing"><strong>Veränderung zum Vortag</strong><br /><span id="Col0PriceArrow" class="price"></span><span id="Col0PriceDetail" class="price">-0,01|-0,02<span class="percentage">%</span></span></div></div><p class="priceInformation" id="Col0PriceTime">per 30.08.2019<br />19:39:23 <abbr title="TimeZone_EDT">EDT</abbr> | EUR ',
              200));

      Map<String, Map<String, dynamic>> quote;
      try {
        quote = await FinanceQuote.getRawData(
            quoteProvider: QuoteProvider.morningstarDe,
            symbols: <String>['0P000001BW', '0P00012BBI', '0P00009QPB'],
            client: client);
      } catch (e) {
        expect(e, 'No exception');
      }

      expect(quote.keys.length, 3);
      expect(quote['0P000001BW'].keys.length, 2);
      expect(quote['0P000001BW']['price'], '55.04');
      expect(quote['0P000001BW']['currency'], 'USD');
      expect(quote['0P00012BBI'].keys.length, 2);
      expect(quote['0P00012BBI']['price'], '1188.10');
      expect(quote['0P00012BBI']['currency'], 'USD');
      expect(quote['0P00009QPB'].keys.length, 2);
      expect(quote['0P00009QPB']['price'], '125.30');
      expect(quote['0P00009QPB']['currency'], 'EUR');

      verify(client.get(
              'http://tools.morningstar.de/de/stockreport/default.aspx?id=0P000001BW'))
          .called(1);

      verify(client.get(
              'http://tools.morningstar.de/de/stockreport/default.aspx?id=0P00012BBI'))
          .called(1);

      verify(client.get(
              'http://tools.morningstar.de/de/stockreport/default.aspx?id=0P00009QPB'))
          .called(1);
    });

    test('MorningstarDe: null, 200 - Response', () async {
      final MockClient client = MockClient();

      when(client.get(
              'http://tools.morningstar.de/de/stockreport/default.aspx?id=0P000001BW'))
          .thenAnswer((_) async => http.Response('', 200));

      Map<String, Map<String, dynamic>> quote;
      try {
        quote = await FinanceQuote.getRawData(
            quoteProvider: QuoteProvider.morningstarDe,
            symbols: <String>['0P000001BW'],
            client: client);
      } catch (e) {
        expect(e, 'No exception');
      }

      expect(quote.keys.length, 0);

      verify(client.get(
              'http://tools.morningstar.de/de/stockreport/default.aspx?id=0P000001BW'))
          .called(1);
    });

    test('MorningstarDe: 404 - Response', () async {
      final MockClient client = MockClient();

      when(client.get(
              'http://tools.morningstar.de/de/stockreport/default.aspx?id=0P000001BW'))
          .thenAnswer((_) async => http.Response('', 404));

      Map<String, Map<String, dynamic>> quote;
      try {
        quote = await FinanceQuote.getRawData(
            quoteProvider: QuoteProvider.morningstarDe,
            symbols: <String>['0P000001BW'],
            client: client);
      } catch (e) {
        expect(e, 'No exception');
      }

      expect(quote.keys.length, 0);

      verify(client.get(
              'http://tools.morningstar.de/de/stockreport/default.aspx?id=0P000001BW'))
          .called(1);
    });
  });

  group('getPrice Test [FinanceQuote] - MorningstarDe', () {
    test('MorningstarDe: 1 symbol, 200 - Response', () async {
      final MockClient client = MockClient();

      when(client.get(
              'http://tools.morningstar.de/de/stockreport/default.aspx?id=0P000001BW'))
          .thenAnswer((_) async => http.Response(
              '<div id="IntradayPriceSummary" class="Wide clearfix"><div class="container fourTenths first "><!-- start of RetailIntradayPriceSummaryQuotationWide --><div id="IntradayPriceSummaryQuotationWide" class="box"><div class="clearfix"><div class="headlinePricing first"><strong>Letzter Kurs</strong><br /><span class="price" id="Col0Price">55,04</span></div><div class="headlinePricing"><strong>Veränderung zum Vortag</strong><br /><span id="Col0PriceArrow" class="price"></span><span id="Col0PriceDetail" class="price">-0,01|-0,02<span class="percentage">%</span></span></div></div><p class="priceInformation" id="Col0PriceTime">per 30.08.2019<br />19:39:23 <abbr title="TimeZone_EDT">EDT</abbr> | USD ',
              200));

      Map<String, Map<String, dynamic>> quote;
      try {
        quote = await FinanceQuote.getPrice(
            quoteProvider: QuoteProvider.morningstarDe,
            symbols: <String>['0P000001BW'],
            client: client);
      } catch (e) {
        expect(e, 'No exception');
      }

      expect(quote.keys.length, 1);
      expect(quote['0P000001BW'].keys.length, 2);
      expect(quote['0P000001BW']['price'], '55.04');
      expect(quote['0P000001BW']['currency'], 'USD');

      verify(client.get(
              'http://tools.morningstar.de/de/stockreport/default.aspx?id=0P000001BW'))
          .called(1);
    });

    test('MorningstarDe: 3 symbols, 200 - Response', () async {
      final MockClient client = MockClient();

      when(client.get(
              'http://tools.morningstar.de/de/stockreport/default.aspx?id=0P000001BW'))
          .thenAnswer((_) async => http.Response(
              '<div id="IntradayPriceSummary" class="Wide clearfix"><div class="container fourTenths first "><!-- start of RetailIntradayPriceSummaryQuotationWide --><div id="IntradayPriceSummaryQuotationWide" class="box"><div class="clearfix"><div class="headlinePricing first"><strong>Letzter Kurs</strong><br /><span class="price" id="Col0Price">55,04</span></div><div class="headlinePricing"><strong>Veränderung zum Vortag</strong><br /><span id="Col0PriceArrow" class="price"></span><span id="Col0PriceDetail" class="price">-0,01|-0,02<span class="percentage">%</span></span></div></div><p class="priceInformation" id="Col0PriceTime">per 30.08.2019<br />19:39:23 <abbr title="TimeZone_EDT">EDT</abbr> | USD ',
              200));

      when(client.get(
              'http://tools.morningstar.de/de/stockreport/default.aspx?id=0P00012BBI'))
          .thenAnswer((_) async => http.Response(
              '<div id="IntradayPriceSummary" class="Wide clearfix"><div class="container fourTenths first "><!-- start of RetailIntradayPriceSummaryQuotationWide --><div id="IntradayPriceSummaryQuotationWide" class="box"><div class="clearfix"><div class="headlinePricing first"><strong>Letzter Kurs</strong><br /><span class="price" id="Col0Price">1.188,10</span></div><div class="headlinePricing"><strong>Veränderung zum Vortag</strong><br /><span id="Col0PriceArrow" class="price"></span><span id="Col0PriceDetail" class="price">-0,01|-0,02<span class="percentage">%</span></span></div></div><p class="priceInformation" id="Col0PriceTime">per 30.08.2019<br />19:39:23 <abbr title="TimeZone_EDT">EDT</abbr> | USD ',
              200));

      when(client.get(
              'http://tools.morningstar.de/de/stockreport/default.aspx?id=0P00009QPB'))
          .thenAnswer((_) async => http.Response(
              '<div id="IntradayPriceSummary" class="Wide clearfix"><div class="container fourTenths first "><!-- start of RetailIntradayPriceSummaryQuotationWide --><div id="IntradayPriceSummaryQuotationWide" class="box"><div class="clearfix"><div class="headlinePricing first"><strong>Letzter Kurs</strong><br /><span class="price" id="Col0Price">125,30</span></div><div class="headlinePricing"><strong>Veränderung zum Vortag</strong><br /><span id="Col0PriceArrow" class="price"></span><span id="Col0PriceDetail" class="price">-0,01|-0,02<span class="percentage">%</span></span></div></div><p class="priceInformation" id="Col0PriceTime">per 30.08.2019<br />19:39:23 <abbr title="TimeZone_EDT">EDT</abbr> | EUR ',
              200));

      Map<String, Map<String, dynamic>> quote;
      try {
        quote = await FinanceQuote.getPrice(
            quoteProvider: QuoteProvider.morningstarDe,
            symbols: <String>['0P000001BW', '0P00012BBI', '0P00009QPB'],
            client: client);
      } catch (e) {
        expect(e, 'No exception');
      }

      expect(quote.keys.length, 3);
      expect(quote['0P000001BW'].keys.length, 2);
      expect(quote['0P000001BW']['price'], '55.04');
      expect(quote['0P000001BW']['currency'], 'USD');
      expect(quote['0P00012BBI'].keys.length, 2);
      expect(quote['0P00012BBI']['price'], '1188.10');
      expect(quote['0P00012BBI']['currency'], 'USD');
      expect(quote['0P00009QPB'].keys.length, 2);
      expect(quote['0P00009QPB']['price'], '125.30');
      expect(quote['0P00009QPB']['currency'], 'EUR');

      verify(client.get(
              'http://tools.morningstar.de/de/stockreport/default.aspx?id=0P000001BW'))
          .called(1);

      verify(client.get(
              'http://tools.morningstar.de/de/stockreport/default.aspx?id=0P00012BBI'))
          .called(1);

      verify(client.get(
              'http://tools.morningstar.de/de/stockreport/default.aspx?id=0P00009QPB'))
          .called(1);
    });

    test('MorningstarDe: null, 200 - Response', () async {
      final MockClient client = MockClient();

      when(client.get(
              'http://tools.morningstar.de/de/stockreport/default.aspx?id=0P000001BW'))
          .thenAnswer((_) async => http.Response('', 200));

      Map<String, Map<String, dynamic>> quote;
      try {
        quote = await FinanceQuote.getPrice(
            quoteProvider: QuoteProvider.morningstarDe,
            symbols: <String>['0P000001BW'],
            client: client);
      } catch (e) {
        expect(e, 'No exception');
      }

      expect(quote.keys.length, 0);

      verify(client.get(
              'http://tools.morningstar.de/de/stockreport/default.aspx?id=0P000001BW'))
          .called(1);
    });

    test('MorningstarDe: 404 - Response', () async {
      final MockClient client = MockClient();

      when(client.get(
              'http://tools.morningstar.de/de/stockreport/default.aspx?id=0P000001BW'))
          .thenAnswer((_) async => http.Response('', 404));

      Map<String, Map<String, dynamic>> quote;
      try {
        quote = await FinanceQuote.getPrice(
            quoteProvider: QuoteProvider.morningstarDe,
            symbols: <String>['0P000001BW'],
            client: client);
      } catch (e) {
        expect(e, 'No exception');
      }

      expect(quote.keys.length, 0);

      verify(client.get(
              'http://tools.morningstar.de/de/stockreport/default.aspx?id=0P000001BW'))
          .called(1);
    });
  });

  group('getRawData Test [FinanceQuote] - MorningstarEs', () {
    test('MorningstarEs: 1 symbol, 200 - Response', () async {
      final MockClient client = MockClient();

      when(client.get(
              'http://tools.morningstar.es/es/stockreport/default.aspx?id=0P000001BW'))
          .thenAnswer((_) async => http.Response(
              '<div id="IntradayPriceSummary" class="Wide clearfix"><div class="container fourTenths first "><!-- start of RetailIntradayPriceSummaryQuotationWide --><div id="IntradayPriceSummaryQuotationWide" class="box"><div class="clearfix"><div class="headlinePricing first"><strong>Letzter Kurs</strong><br /><span class="price" id="Col0Price">55,04</span></div><div class="headlinePricing"><strong>Veränderung zum Vortag</strong><br /><span id="Col0PriceArrow" class="price"></span><span id="Col0PriceDetail" class="price">-0,01|-0,02<span class="percentage">%</span></span></div></div><p class="priceInformation" id="Col0PriceTime">per 30.08.2019<br />19:39:23 <abbr title="TimeZone_EDT">EDT</abbr> | USD ',
              200));

      Map<String, Map<String, dynamic>> quote;
      try {
        quote = await FinanceQuote.getRawData(
            quoteProvider: QuoteProvider.morningstarEs,
            symbols: <String>['0P000001BW'],
            client: client);
      } catch (e) {
        expect(e, 'No exception');
      }

      expect(quote.keys.length, 1);
      expect(quote['0P000001BW'].keys.length, 2);
      expect(quote['0P000001BW']['price'], '55.04');
      expect(quote['0P000001BW']['currency'], 'USD');

      verify(client.get(
              'http://tools.morningstar.es/es/stockreport/default.aspx?id=0P000001BW'))
          .called(1);
    });

    test('MorningstarEs: 3 symbols, 200 - Response', () async {
      final MockClient client = MockClient();

      when(client.get(
              'http://tools.morningstar.es/es/stockreport/default.aspx?id=0P000001BW'))
          .thenAnswer((_) async => http.Response(
              '<div id="IntradayPriceSummary" class="Wide clearfix"><div class="container fourTenths first "><!-- start of RetailIntradayPriceSummaryQuotationWide --><div id="IntradayPriceSummaryQuotationWide" class="box"><div class="clearfix"><div class="headlinePricing first"><strong>Letzter Kurs</strong><br /><span class="price" id="Col0Price">55,04</span></div><div class="headlinePricing"><strong>Veränderung zum Vortag</strong><br /><span id="Col0PriceArrow" class="price"></span><span id="Col0PriceDetail" class="price">-0,01|-0,02<span class="percentage">%</span></span></div></div><p class="priceInformation" id="Col0PriceTime">per 30.08.2019<br />19:39:23 <abbr title="TimeZone_EDT">EDT</abbr> | USD ',
              200));

      when(client.get(
              'http://tools.morningstar.es/es/stockreport/default.aspx?id=0P00012BBI'))
          .thenAnswer((_) async => http.Response(
              '<div id="IntradayPriceSummary" class="Wide clearfix"><div class="container fourTenths first "><!-- start of RetailIntradayPriceSummaryQuotationWide --><div id="IntradayPriceSummaryQuotationWide" class="box"><div class="clearfix"><div class="headlinePricing first"><strong>Letzter Kurs</strong><br /><span class="price" id="Col0Price">1.188,10</span></div><div class="headlinePricing"><strong>Veränderung zum Vortag</strong><br /><span id="Col0PriceArrow" class="price"></span><span id="Col0PriceDetail" class="price">-0,01|-0,02<span class="percentage">%</span></span></div></div><p class="priceInformation" id="Col0PriceTime">per 30.08.2019<br />19:39:23 <abbr title="TimeZone_EDT">EDT</abbr> | USD ',
              200));

      when(client.get(
              'http://tools.morningstar.es/es/stockreport/default.aspx?id=0P00009QPB'))
          .thenAnswer((_) async => http.Response(
              '<div id="IntradayPriceSummary" class="Wide clearfix"><div class="container fourTenths first "><!-- start of RetailIntradayPriceSummaryQuotationWide --><div id="IntradayPriceSummaryQuotationWide" class="box"><div class="clearfix"><div class="headlinePricing first"><strong>Letzter Kurs</strong><br /><span class="price" id="Col0Price">125,30</span></div><div class="headlinePricing"><strong>Veränderung zum Vortag</strong><br /><span id="Col0PriceArrow" class="price"></span><span id="Col0PriceDetail" class="price">-0,01|-0,02<span class="percentage">%</span></span></div></div><p class="priceInformation" id="Col0PriceTime">per 30.08.2019<br />19:39:23 <abbr title="TimeZone_EDT">EDT</abbr> | EUR ',
              200));

      Map<String, Map<String, dynamic>> quote;
      try {
        quote = await FinanceQuote.getRawData(
            quoteProvider: QuoteProvider.morningstarEs,
            symbols: <String>['0P000001BW', '0P00012BBI', '0P00009QPB'],
            client: client);
      } catch (e) {
        expect(e, 'No exception');
      }

      expect(quote.keys.length, 3);
      expect(quote['0P000001BW'].keys.length, 2);
      expect(quote['0P000001BW']['price'], '55.04');
      expect(quote['0P000001BW']['currency'], 'USD');
      expect(quote['0P00012BBI'].keys.length, 2);
      expect(quote['0P00012BBI']['price'], '1188.10');
      expect(quote['0P00012BBI']['currency'], 'USD');
      expect(quote['0P00009QPB'].keys.length, 2);
      expect(quote['0P00009QPB']['price'], '125.30');
      expect(quote['0P00009QPB']['currency'], 'EUR');

      verify(client.get(
              'http://tools.morningstar.es/es/stockreport/default.aspx?id=0P000001BW'))
          .called(1);

      verify(client.get(
              'http://tools.morningstar.es/es/stockreport/default.aspx?id=0P00012BBI'))
          .called(1);

      verify(client.get(
              'http://tools.morningstar.es/es/stockreport/default.aspx?id=0P00009QPB'))
          .called(1);
    });

    test('MorningstarEs: null, 200 - Response', () async {
      final MockClient client = MockClient();

      when(client.get(
              'http://tools.morningstar.es/es/stockreport/default.aspx?id=0P000001BW'))
          .thenAnswer((_) async => http.Response('', 200));

      Map<String, Map<String, dynamic>> quote;
      try {
        quote = await FinanceQuote.getRawData(
            quoteProvider: QuoteProvider.morningstarEs,
            symbols: <String>['0P000001BW'],
            client: client);
      } catch (e) {
        expect(e, 'No exception');
      }

      expect(quote.keys.length, 0);

      verify(client.get(
              'http://tools.morningstar.es/es/stockreport/default.aspx?id=0P000001BW'))
          .called(1);
    });

    test('MorningstarEs: 404 - Response', () async {
      final MockClient client = MockClient();

      when(client.get(
              'http://tools.morningstar.es/es/stockreport/default.aspx?id=0P000001BW'))
          .thenAnswer((_) async => http.Response('', 404));

      Map<String, Map<String, dynamic>> quote;
      try {
        quote = await FinanceQuote.getRawData(
            quoteProvider: QuoteProvider.morningstarEs,
            symbols: <String>['0P000001BW'],
            client: client);
      } catch (e) {
        expect(e, 'No exception');
      }

      expect(quote.keys.length, 0);

      verify(client.get(
              'http://tools.morningstar.es/es/stockreport/default.aspx?id=0P000001BW'))
          .called(1);
    });
  });

  group('getRawData Test [FinanceQuote] - Coincap', () {
    test('Coincap: 1 symbol, 200 - Response', () async {
      final MockClient client = MockClient();

      when(client.get('https://api.coincap.io/v2/assets/bitcoin')).thenAnswer(
          (_) async => http.Response(
              '{"data":{"id":"bitcoin","rank":"1","symbol":"BTC","name":"Bitcoin","supply":"17909287.0000000000000000","maxSupply":"21000000.0000000000000000","marketCapUsd":"172415433962.2465790154727656","volumeUsd24Hr":"3144821860.9266363841492533","priceUsd":"9627.1523239449219288","changePercent24Hr":"0.2243120489992448","vwap24Hr":"9628.3630077795475554"},"timestamp":1567333621899}',
              200));

      Map<String, Map<String, dynamic>> quote;
      try {
        quote = await FinanceQuote.getRawData(
            quoteProvider: QuoteProvider.coincap,
            symbols: <String>['bitcoin'],
            client: client);
      } catch (e) {
        expect(e, 'No exception');
      }

      expect(quote.keys.length, 1);
      expect(quote['bitcoin'].keys.length, 11);
      expect(quote['bitcoin']['symbol'], 'BTC');
      expect(quote['bitcoin']['priceUsd'], '9627.1523239449219288');

      verify(client.get('https://api.coincap.io/v2/assets/bitcoin')).called(1);
    });

    test('Coincap: 1 invalid symbol, 200 - Response', () async {
      final MockClient client = MockClient();

      when(client.get('https://api.coincap.io/v2/assets/asdf')).thenAnswer(
          (_) async => http.Response(
              '{"error":"asdf not found","timestamp":1567334797490}', 200));

      Map<String, Map<String, dynamic>> quote;
      try {
        quote = await FinanceQuote.getRawData(
            quoteProvider: QuoteProvider.coincap,
            symbols: <String>['asdf'],
            client: client);
      } catch (e) {
        expect(e, 'No exception');
      }

      expect(quote.keys.length, 0);

      verify(client.get('https://api.coincap.io/v2/assets/asdf')).called(1);
    });

    test('Coincap: 3 symbols, 200 - Response', () async {
      final MockClient client = MockClient();

      when(client.get('https://api.coincap.io/v2/assets/bitcoin')).thenAnswer(
          (_) async => http.Response(
              '{"data":{"id":"bitcoin","rank":"1","symbol":"BTC","name":"Bitcoin","supply":"17909287.0000000000000000","maxSupply":"21000000.0000000000000000","marketCapUsd":"172415433962.2465790154727656","volumeUsd24Hr":"3144821860.9266363841492533","priceUsd":"9627.1523239449219288","changePercent24Hr":"0.2243120489992448","vwap24Hr":"9628.3630077795475554"},"timestamp":1567333621899}',
              200));

      when(client.get('https://api.coincap.io/v2/assets/ethereum')).thenAnswer(
          (_) async => http.Response(
              '{"data":{"id":"ethereum","rank":"2","symbol":"ETH","name":"Ethereum","supply":"107560553.4365000000000000","maxSupply":null,"marketCapUsd":"18364136667.4690426157308646","volumeUsd24Hr":"1620040186.4141028288189939","priceUsd":"170.7330064856033725","changePercent24Hr":"1.0733475421440090","vwap24Hr":"170.9198731123523860"},"timestamp":1567334942673}',
              200));

      when(client.get('https://api.coincap.io/v2/assets/asdf')).thenAnswer(
          (_) async => http.Response(
              '{"error":"asdf not found","timestamp":1567334797490}', 200));

      Map<String, Map<String, dynamic>> quote;
      try {
        quote = await FinanceQuote.getRawData(
            quoteProvider: QuoteProvider.coincap,
            symbols: <String>['bitcoin', 'adsf', 'ethereum'],
            client: client);
      } catch (e) {
        expect(e, 'No exception');
      }

      expect(quote.keys.length, 2);
      expect(quote['bitcoin'].keys.length, 11);
      expect(quote['bitcoin']['symbol'], 'BTC');
      expect(quote['bitcoin']['priceUsd'], '9627.1523239449219288');
      expect(quote['ethereum'].keys.length, 11);
      expect(quote['ethereum']['symbol'], 'ETH');
      expect(quote['ethereum']['priceUsd'], '170.7330064856033725');

      verify(client.get('https://api.coincap.io/v2/assets/bitcoin')).called(1);
      verify(client.get('https://api.coincap.io/v2/assets/ethereum')).called(1);
      verify(client.get('https://api.coincap.io/v2/assets/adsf')).called(1);
    });

    test('Coincap: null, 200 - Response', () async {
      final MockClient client = MockClient();

      when(client.get('https://api.coincap.io/v2/assets/bitcoin'))
          .thenAnswer((_) async => http.Response('{"data":', 200));

      Map<String, Map<String, dynamic>> quote;
      try {
        quote = await FinanceQuote.getRawData(
            quoteProvider: QuoteProvider.coincap,
            symbols: <String>['bitcoin'],
            client: client);
      } catch (e) {
        expect(e, 'No exception');
      }

      expect(quote.keys.length, 0);

      verify(client.get('https://api.coincap.io/v2/assets/bitcoin')).called(1);
    });

    test('Coincap: null, 404 - Response', () async {
      final MockClient client = MockClient();

      when(client.get('https://api.coincap.io/v2/assets/bitcoin'))
          .thenAnswer((_) async => http.Response('{"data":', 404));

      Map<String, Map<String, dynamic>> quote;
      try {
        quote = await FinanceQuote.getRawData(
            quoteProvider: QuoteProvider.coincap,
            symbols: <String>['bitcoin'],
            client: client);
      } catch (e) {
        expect(e, 'No exception');
      }

      expect(quote.keys.length, 0);

      verify(client.get('https://api.coincap.io/v2/assets/bitcoin')).called(1);
    });
  });

  group('getPrice Test [FinanceQuote] - Coincap', () {
    test('Coincap: 1 symbol, 200 - Response', () async {
      final MockClient client = MockClient();

      when(client.get('https://api.coincap.io/v2/assets/bitcoin')).thenAnswer(
          (_) async => http.Response(
              '{"data":{"id":"bitcoin","rank":"1","symbol":"BTC","name":"Bitcoin","supply":"17909287.0000000000000000","maxSupply":"21000000.0000000000000000","marketCapUsd":"172415433962.2465790154727656","volumeUsd24Hr":"3144821860.9266363841492533","priceUsd":"9627.1523239449219288","changePercent24Hr":"0.2243120489992448","vwap24Hr":"9628.3630077795475554"},"timestamp":1567333621899}',
              200));

      Map<String, Map<String, dynamic>> quote;
      try {
        quote = await FinanceQuote.getPrice(
            quoteProvider: QuoteProvider.coincap,
            symbols: <String>['bitcoin'],
            client: client);
      } catch (e) {
        expect(e, 'No exception');
      }

      expect(quote.keys.length, 1);
      expect(quote['bitcoin'].keys.length, 2);
      expect(quote['bitcoin']['price'], '9627.15');
      expect(quote['bitcoin']['currency'], 'USD');

      verify(client.get('https://api.coincap.io/v2/assets/bitcoin')).called(1);
    });

    test('Coincap: 1 invalid symbol, 200 - Response', () async {
      final MockClient client = MockClient();

      when(client.get('https://api.coincap.io/v2/assets/asdf')).thenAnswer(
          (_) async => http.Response(
              '{"error":"asdf not found","timestamp":1567334797490}', 200));

      Map<String, Map<String, dynamic>> quote;
      try {
        quote = await FinanceQuote.getPrice(
            quoteProvider: QuoteProvider.coincap,
            symbols: <String>['asdf'],
            client: client);
      } catch (e) {
        expect(e, 'No exception');
      }

      expect(quote.keys.length, 0);

      verify(client.get('https://api.coincap.io/v2/assets/asdf')).called(1);
    });

    test('Coincap: 3 symbols, 200 - Response', () async {
      final MockClient client = MockClient();

      when(client.get('https://api.coincap.io/v2/assets/bitcoin')).thenAnswer(
          (_) async => http.Response(
              '{"data":{"id":"bitcoin","rank":"1","symbol":"BTC","name":"Bitcoin","supply":"17909287.0000000000000000","maxSupply":"21000000.0000000000000000","marketCapUsd":"172415433962.2465790154727656","volumeUsd24Hr":"3144821860.9266363841492533","priceUsd":"9627.1523239449219288","changePercent24Hr":"0.2243120489992448","vwap24Hr":"9628.3630077795475554"},"timestamp":1567333621899}',
              200));

      when(client.get('https://api.coincap.io/v2/assets/ethereum')).thenAnswer(
          (_) async => http.Response(
              '{"data":{"id":"ethereum","rank":"2","symbol":"ETH","name":"Ethereum","supply":"107560553.4365000000000000","maxSupply":null,"marketCapUsd":"18364136667.4690426157308646","volumeUsd24Hr":"1620040186.4141028288189939","priceUsd":"170.7330064856033725","changePercent24Hr":"1.0733475421440090","vwap24Hr":"170.9198731123523860"},"timestamp":1567334942673}',
              200));

      when(client.get('https://api.coincap.io/v2/assets/asdf')).thenAnswer(
          (_) async => http.Response(
              '{"error":"asdf not found","timestamp":1567334797490}', 200));

      Map<String, Map<String, dynamic>> quote;
      try {
        quote = await FinanceQuote.getPrice(
            quoteProvider: QuoteProvider.coincap,
            symbols: <String>['bitcoin', 'adsf', 'ethereum'],
            client: client);
      } catch (e) {
        expect(e, 'No exception');
      }

      expect(quote.keys.length, 2);
      expect(quote['bitcoin'].keys.length, 2);
      expect(quote['bitcoin']['price'], '9627.15');
      expect(quote['bitcoin']['currency'], 'USD');
      expect(quote['ethereum'].keys.length, 2);
      expect(quote['ethereum']['price'], '170.73');
      expect(quote['ethereum']['currency'], 'USD');

      verify(client.get('https://api.coincap.io/v2/assets/bitcoin')).called(1);
      verify(client.get('https://api.coincap.io/v2/assets/ethereum')).called(1);
      verify(client.get('https://api.coincap.io/v2/assets/adsf')).called(1);
    });

    test('Coincap: null, 200 - Response', () async {
      final MockClient client = MockClient();

      when(client.get('https://api.coincap.io/v2/assets/bitcoin'))
          .thenAnswer((_) async => http.Response('{"data":', 200));

      Map<String, Map<String, dynamic>> quote;
      try {
        quote = await FinanceQuote.getPrice(
            quoteProvider: QuoteProvider.coincap,
            symbols: <String>['bitcoin'],
            client: client);
      } catch (e) {
        expect(e, 'No exception');
      }

      expect(quote.keys.length, 0);

      verify(client.get('https://api.coincap.io/v2/assets/bitcoin')).called(1);
    });

    test('Coincap: null, 404 - Response', () async {
      final MockClient client = MockClient();

      when(client.get('https://api.coincap.io/v2/assets/bitcoin'))
          .thenAnswer((_) async => http.Response('{"data":', 404));

      Map<String, Map<String, dynamic>> quote;
      try {
        quote = await FinanceQuote.getPrice(
            quoteProvider: QuoteProvider.coincap,
            symbols: <String>['bitcoin'],
            client: client);
      } catch (e) {
        expect(e, 'No exception');
      }

      expect(quote.keys.length, 0);

      verify(client.get('https://api.coincap.io/v2/assets/bitcoin')).called(1);
    });
  });

  group('getRawData Test [FinanceQuote] - Binance', () {
    test('Binance: 1 symbol, 200 - Response', () async {
      final MockClient client = MockClient();

      when(client.get(
              'https://api.binance.com/api/v3/ticker/price?symbol=BTCUSDT'))
          .thenAnswer((_) async => http.Response(
              '{"symbol":"BTCUSDT","price":"10428.73000000"}', 200));

      Map<String, Map<String, dynamic>> quote;
      try {
        quote = await FinanceQuote.getRawData(
            quoteProvider: QuoteProvider.binance,
            symbols: <String>['BTCUSDT'],
            client: client);
      } catch (e) {
        expect(e, 'No exception');
      }

      expect(quote.keys.length, 1);
      expect(quote['BTCUSDT'].keys.length, 2);
      expect(quote['BTCUSDT']['price'], '10428.73000000');

      verify(client.get(
              'https://api.binance.com/api/v3/ticker/price?symbol=BTCUSDT'))
          .called(1);
    });

    test('Binance: 1 invalid symbol, 200 - Response', () async {
      final MockClient client = MockClient();

      when(client
              .get('https://api.binance.com/api/v3/ticker/price?symbol=asdf'))
          .thenAnswer((_) async => http.Response(
              r'{"code":-1100,"msg":"Illegal characters found in parameter symbol; legal range is ^[A-Z0-9_]{1,20}$."}',
              200));

      Map<String, Map<String, dynamic>> quote;
      try {
        quote = await FinanceQuote.getRawData(
            quoteProvider: QuoteProvider.binance,
            symbols: <String>['asdf'],
            client: client);
      } catch (e) {
        expect(e, 'No exception');
      }

      expect(quote.keys.length, 0);

      verify(client
              .get('https://api.binance.com/api/v3/ticker/price?symbol=asdf'))
          .called(1);
    });

    test('Binance: 3 symbols, 200 - Response', () async {
      final MockClient client = MockClient();

      when(client.get(
              'https://api.binance.com/api/v3/ticker/price?symbol=BTCUSDT'))
          .thenAnswer((_) async => http.Response(
              '{"symbol":"BTCUSDT","price":"10428.73000000"}', 200));

      when(client
              .get('https://api.binance.com/api/v3/ticker/price?symbol=ETHBTC'))
          .thenAnswer((_) async =>
              http.Response('{"symbol":"ETHBTC","price":"0.01686900"}', 200));

      when(client
              .get('https://api.binance.com/api/v3/ticker/price?symbol=asdf'))
          .thenAnswer((_) async => http.Response(
              r'{"code":-1100,"msg":"Illegal characters found in parameter symbol; legal range is ^[A-Z0-9_]{1,20}$."}',
              200));

      Map<String, Map<String, dynamic>> quote;
      try {
        quote = await FinanceQuote.getRawData(
            quoteProvider: QuoteProvider.binance,
            symbols: <String>['BTCUSDT', 'adsf', 'ETHBTC'],
            client: client);
      } catch (e) {
        expect(e, 'No exception');
      }

      expect(quote.keys.length, 2);
      expect(quote['BTCUSDT'].keys.length, 2);
      expect(quote['BTCUSDT']['price'], '10428.73000000');
      expect(quote['ETHBTC'].keys.length, 2);
      expect(quote['ETHBTC']['price'], '0.01686900');

      verify(client.get(
              'https://api.binance.com/api/v3/ticker/price?symbol=BTCUSDT'))
          .called(1);
      verify(client
              .get('https://api.binance.com/api/v3/ticker/price?symbol=ETHBTC'))
          .called(1);
      verify(client
              .get('https://api.binance.com/api/v3/ticker/price?symbol=adsf'))
          .called(1);
    });

    test('Binance: null, 200 - Response', () async {
      final MockClient client = MockClient();

      when(client.get(
              'https://api.binance.com/api/v3/ticker/price?symbol=BTCUSDT'))
          .thenAnswer((_) async => http.Response('{}', 200));

      Map<String, Map<String, dynamic>> quote;
      try {
        quote = await FinanceQuote.getRawData(
            quoteProvider: QuoteProvider.binance,
            symbols: <String>['BTCUSDT'],
            client: client);
      } catch (e) {
        expect(e, 'No exception');
      }

      expect(quote.keys.length, 0);

      verify(client.get(
              'https://api.binance.com/api/v3/ticker/price?symbol=BTCUSDT'))
          .called(1);
    });

    test('Binance: null, 404 - Response', () async {
      final MockClient client = MockClient();

      when(client.get(
              'https://api.binance.com/api/v3/ticker/price?symbol=BTCUSDT'))
          .thenAnswer((_) async => http.Response('{}', 404));

      Map<String, Map<String, dynamic>> quote;
      try {
        quote = await FinanceQuote.getRawData(
            quoteProvider: QuoteProvider.binance,
            symbols: <String>['BTCUSDT'],
            client: client);
      } catch (e) {
        expect(e, 'No exception');
      }

      expect(quote.keys.length, 0);

      verify(client.get(
              'https://api.binance.com/api/v3/ticker/price?symbol=BTCUSDT'))
          .called(1);
    });
  });

  group('getPrice Test [FinanceQuote] - Binance', () {
    test('Binance: 1 symbol, 200 - Response', () async {
      final MockClient client = MockClient();

      when(client.get(
              'https://api.binance.com/api/v3/ticker/price?symbol=BTCUSDT'))
          .thenAnswer((_) async => http.Response(
              '{"symbol":"BTCUSDT","price":"10428.73000000"}', 200));

      Map<String, Map<String, dynamic>> quote;
      try {
        quote = await FinanceQuote.getPrice(
            quoteProvider: QuoteProvider.binance,
            symbols: <String>['BTCUSDT'],
            client: client);
      } catch (e) {
        expect(e, 'No exception');
      }

      expect(quote.keys.length, 1);
      expect(quote['BTCUSDT'].keys.length, 2);
      expect(quote['BTCUSDT']['price'], '10428.73000');
      expect(quote['BTCUSDT']['currency'], 'USD');

      verify(client.get(
              'https://api.binance.com/api/v3/ticker/price?symbol=BTCUSDT'))
          .called(1);
    });

    test('Binance: 1 invalid symbol, 200 - Response', () async {
      final MockClient client = MockClient();

      when(client
              .get('https://api.binance.com/api/v3/ticker/price?symbol=asdf'))
          .thenAnswer((_) async => http.Response(
              r'{"code":-1100,"msg":"Illegal characters found in parameter symbol; legal range is ^[A-Z0-9_]{1,20}$."}',
              200));

      Map<String, Map<String, dynamic>> quote;
      try {
        quote = await FinanceQuote.getPrice(
            quoteProvider: QuoteProvider.binance,
            symbols: <String>['asdf'],
            client: client);
      } catch (e) {
        expect(e, 'No exception');
      }

      expect(quote.keys.length, 0);

      verify(client
              .get('https://api.binance.com/api/v3/ticker/price?symbol=asdf'))
          .called(1);
    });

    test('Binance: 3 symbols, 200 - Response', () async {
      final MockClient client = MockClient();

      when(client.get(
              'https://api.binance.com/api/v3/ticker/price?symbol=BTCUSDT'))
          .thenAnswer((_) async => http.Response(
              '{"symbol":"BTCUSDT","price":"10428.73000000"}', 200));

      when(client
              .get('https://api.binance.com/api/v3/ticker/price?symbol=ETHBTC'))
          .thenAnswer((_) async =>
              http.Response('{"symbol":"ETHBTC","price":"0.01686900"}', 200));

      when(client
              .get('https://api.binance.com/api/v3/ticker/price?symbol=asdf'))
          .thenAnswer((_) async => http.Response(
              r'{"code":-1100,"msg":"Illegal characters found in parameter symbol; legal range is ^[A-Z0-9_]{1,20}$."}',
              200));

      Map<String, Map<String, dynamic>> quote;
      try {
        quote = await FinanceQuote.getPrice(
            quoteProvider: QuoteProvider.binance,
            symbols: <String>['BTCUSDT', 'adsf', 'ETHBTC'],
            client: client);
      } catch (e) {
        expect(e, 'No exception');
      }

      expect(quote.keys.length, 2);
      expect(quote['BTCUSDT'].keys.length, 2);
      expect(quote['BTCUSDT']['price'], '10428.73000');
      expect(quote['BTCUSDT']['currency'], 'USD');
      expect(quote['ETHBTC'].keys.length, 2);
      expect(quote['ETHBTC']['price'], '0.01687');
      expect(quote['ETHBTC']['currency'], 'BTC');

      verify(client.get(
              'https://api.binance.com/api/v3/ticker/price?symbol=BTCUSDT'))
          .called(1);
      verify(client
              .get('https://api.binance.com/api/v3/ticker/price?symbol=ETHBTC'))
          .called(1);
      verify(client
              .get('https://api.binance.com/api/v3/ticker/price?symbol=adsf'))
          .called(1);
    });

    test('Binance: null, 200 - Response', () async {
      final MockClient client = MockClient();

      when(client.get(
              'https://api.binance.com/api/v3/ticker/price?symbol=BTCUSDT'))
          .thenAnswer((_) async => http.Response('{}', 200));

      Map<String, Map<String, dynamic>> quote;
      try {
        quote = await FinanceQuote.getPrice(
            quoteProvider: QuoteProvider.binance,
            symbols: <String>['BTCUSDT'],
            client: client);
      } catch (e) {
        expect(e, 'No exception');
      }

      expect(quote.keys.length, 0);

      verify(client.get(
              'https://api.binance.com/api/v3/ticker/price?symbol=BTCUSDT'))
          .called(1);
    });

    test('Binance: null, 404 - Response', () async {
      final MockClient client = MockClient();

      when(client.get(
              'https://api.binance.com/api/v3/ticker/price?symbol=BTCUSDT'))
          .thenAnswer((_) async => http.Response('{}', 404));

      Map<String, Map<String, dynamic>> quote;
      try {
        quote = await FinanceQuote.getPrice(
            quoteProvider: QuoteProvider.binance,
            symbols: <String>['BTCUSDT'],
            client: client);
      } catch (e) {
        expect(e, 'No exception');
      }

      expect(quote.keys.length, 0);

      verify(client.get(
              'https://api.binance.com/api/v3/ticker/price?symbol=BTCUSDT'))
          .called(1);
    });
  });
}
