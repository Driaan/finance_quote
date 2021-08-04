// Copyright 2019 Ismael Jiménez. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

library fin_quote;

import 'package:fin_quote/src/quote_providers/binance.dart';
import 'package:fin_quote/src/utils/app_logger.dart';
import 'package:fin_quote/src/quote_providers/coincap.dart';
import 'package:fin_quote/src/quote_providers/morningstarDe.dart';
import 'package:fin_quote/src/quote_providers/morningstarEs.dart';
import 'package:fin_quote/src/quote_providers/yahoo.dart';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

/// The identifier of the quote provider.
enum QuoteProvider { yahoo, coincap, morningstarDe, morningstarEs, binance }

class FinanceQuote {
  static Future<Map<String, dynamic>?> getRawHistoricalData(
      {required QuoteProvider quoteProvider,
      required String symbol,
      http.Client? client,
      Logger? logger}) async {
    // If client is not provided, use http IO client
    client ??= http.Client();

    // If logger is not provided, use default logger
    logger ??= Logger(printer: AppLogger('FinanceQuote'));

    // Retrieved market data.
    Map<String, dynamic>? retrievedHistoryData = Map<String, dynamic>();

    if (symbol.isEmpty) {
      return retrievedHistoryData;
    }

    switch (quoteProvider) {
      case QuoteProvider.yahoo:
        {
          retrievedHistoryData =
              await (Yahoo.downloadHistory(symbol, client, logger)
                  as Future<Map<String, dynamic>>);
        }
        break;
      default:
        {
          logger.e('Unknown History Source');
        }
        break;
    }

    return retrievedHistoryData;
  }

  /// Returns a [Map] object containing the raw data retrieved. The map contains a key for each
  /// symbol retrieved and the value is map with the symbol properties. In case no valid quote data
  /// is retrieved, an empty map is returned.
  ///
  /// The `quoteProvider` argument controls where the quote data comes from. This can
  /// be any of the values of [QuoteProvider].
  ///
  /// The `symbols` argument controls which quotes shall be retrieved. This can
  /// be any string identifying a valid symbol for the [QuoteProvider].
  ///
  /// If specified, the `client` provided will be used, otherwise default http IO client.
  /// This is used for testing purposes.
  ///
  /// If specified, the `logger` provided will be used, otherwise default Logger will be used.
  static Future<Map<String, Map<String, dynamic>?>> getRawData(
      {required QuoteProvider quoteProvider,
      required List<String> symbols,
      http.Client? client,
      Logger? logger}) async {
    // If client is not provided, use http IO client
    client ??= http.Client();

    // If logger is not provided, use default logger
    logger ??= Logger(printer: AppLogger('FinanceQuote'));

    // Retrieved market data.
    Map<String, Map<String, dynamic>?> retrievedQuoteData =
        <String, Map<String, dynamic>>{};

    if (symbols.isEmpty) {
      return retrievedQuoteData;
    }

    switch (quoteProvider) {
      case QuoteProvider.yahoo:
        {
          retrievedQuoteData = await Yahoo.downloadRaw(symbols, client, logger);
        }
        break;
      case QuoteProvider.morningstarDe:
        {
          retrievedQuoteData =
              await MorningstarDe.downloadRaw(symbols, client, logger);
        }
        break;
      case QuoteProvider.morningstarEs:
        {
          retrievedQuoteData =
              await MorningstarEs.downloadRaw(symbols, client, logger);
        }
        break;
      case QuoteProvider.coincap:
        {
          retrievedQuoteData =
              await Coincap.downloadRaw(symbols, client, logger);
        }
        break;
      case QuoteProvider.binance:
        {
          retrievedQuoteData =
              await Binance.downloadRaw(symbols, client, logger);
        }
        break;
      default:
        {
          logger.e('Unknown Quote Source');
        }
        break;
    }

    return retrievedQuoteData;
  }

  /// Returns a [Map] object containing the price data retrieved. The map contains a key for each
  /// symbol retrieved and the value is map with the symbol properties 'price','change' and 'currency'.
  /// In case no valid quote data is retrieved, an empty map is returned.
  ///
  /// The `quoteProvider` argument controls where the quote data comes from. This can
  /// be any of the values of [QuoteProvider].
  ///
  /// The `symbols` argument controls which quotes shall be retrieved. This can
  /// be any string identifying a valid symbol for the [QuoteProvider].
  ///
  /// If specified, the `client` provided will be used. This is used for testing purposes.
  ///
  /// If specified, the `logger` provided will be used, otherwise default Logger will be used.
  static Future<Map<String, Map<String, String?>>> getInfo(
      {required QuoteProvider quoteProvider,
      required List<String> symbols,
      http.Client? client,
      Logger? logger}) async {
    final Map<String, Map<String, String?>> quoteInfo =
        <String, Map<String, String>>{};

    if (symbols.isEmpty) {
      return quoteInfo;
    }

    final Map<String, Map<String, dynamic>?> rawQuotes = await getRawData(
        quoteProvider: quoteProvider,
        symbols: symbols,
        client: client,
        logger: logger);

    rawQuotes.forEach((String symbol, Map<String, dynamic>? rawQuote) {
      switch (quoteProvider) {
        case QuoteProvider.yahoo:
          {
            quoteInfo[symbol] = Yahoo.parseInfo(rawQuote!);
          }
          break;
        case QuoteProvider.morningstarDe:
          {
            quoteInfo[symbol] = MorningstarDe.parseInfo(rawQuote!);
          }
          break;
        case QuoteProvider.morningstarEs:
          {
            quoteInfo[symbol] = MorningstarEs.parseInfo(rawQuote!);
          }
          break;
        case QuoteProvider.coincap:
          {
            quoteInfo[symbol] = Coincap.parseInfo(rawQuote!);
          }
          break;
        case QuoteProvider.binance:
          {
            quoteInfo[symbol] = Binance.parseInfo(rawQuote!);
          }
          break;
        default:
          {
            logger!.e('Unknown Quote Source');
          }
          break;
      }
    });
    return quoteInfo;
  }

  static Future<Map<String, dynamic>> getHistoricalData(
      {required QuoteProvider quoteProvider,
      required String symbol,
      http.Client? client,
      Logger? logger}) async {
    Map<String, dynamic> historyData = Map<String, dynamic>();

    if (symbol.isEmpty) {
      return historyData;
    }

    final Map<String, dynamic>? rawHistory = await getRawHistoricalData(
        quoteProvider: quoteProvider,
        symbol: symbol,
        client: client,
        logger: logger);

    switch (quoteProvider) {
      case QuoteProvider.yahoo:
        historyData = Yahoo.parseHistoricalData(rawHistory!);
        break;
      default:
        logger!.e('Unknown Quote Source');
    }

    return historyData;
  }
}
