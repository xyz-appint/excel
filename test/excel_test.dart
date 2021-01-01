import 'dart:io';

import 'package:excel/excel.dart';
import 'package:test/test.dart';

void main() {
  test('Create New XLSX File', () {
    var excel = Excel.createExcel();
    expect(excel.sheets.entries.length, equals(1));
    expect(excel.sheets.entries.first.key, equals('Sheet1'));
  });

  test('Read XLSX File', () {
    var file = Directory.current.path + "/test_resources/example.xlsx";
    var bytes = File(file).readAsBytesSync();
    var excel = Excel.decodeBytes(bytes);
    expect(excel.tables['Sheet1'].maxCols, equals(3));
    expect(excel.tables["Sheet1"].rows[1][1].toString(), equals('Washington'));
  });

  group('Sheet Operations', () {
    var file = Directory.current.path + "/test_resources/example.xlsx";
    var bytes = File(file).readAsBytesSync();
    Excel excel = Excel.decodeBytes(bytes);
    test('create Sheet', () {
      Sheet sheetObject = excel['SheetTmp'];
      sheetObject.insertRowIterables(["Country", "Capital", "Head"], 0);
      sheetObject.insertRowIterables(["Russia", "Moscow", "Putin"], 1);
      expect(excel.sheets.entries.length,equals(2));
      expect(
          excel.tables["Sheet1"].rows[1][1].toString(), equals('Washington'));
      expect(excel.tables['SheetTmp'].maxCols, equals(3));
      expect(excel.tables["SheetTmp"].rows[1][2].toString(), equals('Putin'));
    });
    
    test('copy Sheet', () {
      excel.copy('SheetTmp', 'SheetTmp2');
      expect(excel.sheets.entries.length,equals(3));
      expect(
          excel.tables["Sheet1"].rows[1][1].toString(), equals('Washington'));
      expect(excel.tables['SheetTmp'].maxCols, equals(3));
      expect(excel.tables["SheetTmp"].rows[1][2].toString(), equals('Putin'));
      expect(excel.tables["SheetTmp2"].rows[1][2].toString(), equals('Putin'));
    });

    test('rename Sheet', () {
      excel.rename('SheetTmp2', 'SheetTmp3');
      expect(excel.sheets.entries.length,equals(3));
      expect(excel.tables['Sheettmp2'], equals(null));
      expect(
          excel.tables["Sheet1"].rows[1][1].toString(), equals('Washington'));
      expect(excel.tables['SheetTmp'].maxCols, equals(3));
      expect(excel.tables["SheetTmp"].rows[1][2].toString(), equals('Putin'));
      expect(excel.tables["SheetTmp3"].rows[1][2].toString(), equals('Putin'));
    });


  
  
  });
}
