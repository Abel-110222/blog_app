// ignore_for_file: unnecessary_this

import 'dart:math' as math;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:blog_app/utils/globals.dart' as global;

class Responsive {
  double _width = 0;
  double _height = 0;
  double _heightWithoutKeyboard = 0;
  double _diagonal = 0;
  //
  //  Indicates if the devices is a tablet
  bool _isDispositive = false;
  //
  //  Indicates if the program was compiled for the Web
  bool _isWeb = false;
  //
  //  Indicates if the devices is in portrait orientation
  bool _isPortrait = false;
  //
  double _fontSizeDefault = 0;
  //
  //
  double _fontSizeTitle = 0;

  ///
  ///!  Responsive Size
  bool _isXXS = false;
  bool _isXS = false;
  bool _isSM = false;
  bool _isMD = false;
  bool _isLG = false;
  bool _isXL = false;
  bool _isXXL = false;
  String _strResponsive = '';

  ///!  PROPERTIES
  double get width => _width;
  double get height => _height;
  double get heightWithoutKeyboard => _heightWithoutKeyboard;
  double get diagonal => _diagonal;
  bool get isDispositive => _isDispositive;
  bool get isPortrait => _isPortrait;
  bool get isWeb => _isWeb;
  double get fontSizeDefault => _fontSizeDefault;
  double get fontSizeTitle => _fontSizeTitle;

  ///!  ------------- Responsive Size
  double sizeStd(double responsiveSize) => (_height * responsiveSize) / 1000;

  double widthPercent(double percent) => _width * percent / 100;
  double heightPercent(double percent) => _height * percent / 100;
  double diagonalPercent(double percent) => _diagonal * percent / 100;

  bool get isXXS => _isXXS;
  bool get isXS => _isXS;
  bool get isSM => _isSM;
  bool get isMD => _isMD;
  bool get isLG => _isLG;
  bool get isXL => _isXL;
  bool get isXXL => _isXXL;

  double get xs => 576;
  double get sm => 768;
  double get md => 992;
  double get lg => 1200;
  double get xl => 1400;

  String get strResponsive => _strResponsive;
  String get labelCurrentResponsive =>
      '$_strResponsive - ${_width.toStringAsFixed(2)} x ${_height.toStringAsFixed(2)}';

  ///!  CONSTRUCTOR
  Responsive(
    BuildContext context, [
    bool displayOn = false,
  ]) {
    var mediaQuery = MediaQuery.of(context);

    final Size size = mediaQuery.size;
    this._width = size.width;
    this._height = size.height;
    this._heightWithoutKeyboard = MediaQuery.of(context).viewInsets.bottom;
    //

    if (((_width.round() < global.WIDTH_MIN.toInt()) ||
            (_height.round() < global.HEIGHT_MIN.toInt())) &&
        (global.responsiveScreenOk == true)) {
      //
      global.responsiveScreenOk = false;
      //
      Future.delayed(Duration.zero, () {
        /// Navigator.pushAndRemoveUntil(
        ///   context,
        ///   MaterialPageRoute(
        ///     builder: (context) => const ErrorPage(),
        ///   ),
        ///   (_) => false,
        /// );
        //

        //
        //! pantalla de error por height y width
        // Navigator.push<ErrorPage>(
        //   context,
        //   MaterialPageRoute<ErrorPage>(
        //     builder: (BuildContext context) => const ErrorPage(),
        //   ),
        // );
      });
    }
    //
    //  Pitagoras. h2 = a2 + b2
    _diagonal = math.sqrt(math.pow(_width, 2) + math.pow(_height, 2));
    _isWeb = kIsWeb == true ? true : false;
    //
    //  If the minor side is greater than 700 and it isn't web
    _isDispositive = _width < 992 ? true : false;
    //
    //  if the <height> is greater than the <width> it is a device
    //  with <portrit> orientation
    _isPortrait = _width < _height;
    //
    _fontSizeDefault = 11 + ((_width / 130) - 1).ceil().toDouble();
    _fontSizeTitle = kIsWeb == true ? 14 : 18;

    ///!  Responsive Size
    if (_width < 300) {
      _isXXS = true;
      _isXS = false;
      _isSM = false;
      _isMD = false;
      _isLG = false;
      _isXL = false;
      _isXXL = false;
      _strResponsive = 'xxs';
    }

    if (_width < 576) {
      _isXXS = false;
      _isXS = true;
      _isSM = false;
      _isMD = false;
      _isLG = false;
      _isXL = false;
      _isXXL = false;
      _strResponsive = 'xs';
    }

    if (_width >= 576 && _width < 768) {
      _isXXS = false;
      _isXS = false;
      _isSM = true;
      _isMD = false;
      _isLG = false;
      _isXL = false;
      _isXXL = false;
      _strResponsive = 'sm';
    }

    if (_width >= 768 && _width < 992) {
      _isXXS = false;
      _isXS = false;
      _isSM = false;
      _isMD = true;
      _isLG = false;
      _isXL = false;
      _isXXL = false;
      _strResponsive = 'md';
    }

    if (_width >= 992 && _width < 1200) {
      _isXXS = false;
      _isXS = false;
      _isSM = false;
      _isMD = false;
      _isLG = true;
      _isXL = false;
      _isXXL = false;
      _strResponsive = 'lg';
    }

    if (_width >= 1200 && _width < 1400) {
      _isXXS = false;
      _isXS = false;
      _isSM = false;
      _isMD = false;
      _isLG = false;
      _isXL = true;
      _isXXL = false;
      _strResponsive = 'xl';
    }

    if (_width >= 1400) {
      _isXXS = false;
      _isXS = false;
      _isSM = false;
      _isMD = false;
      _isLG = false;
      _isXL = false;
      _isXXL = true;
      _strResponsive = 'xxl';
    }

    // if (displayOn == false) {
    //   return;
    // }
    // if (kDebugMode) {
    //   print(
    //       '\n--------- width: $_width, height: $_height, heightWithoutKeyboard: $_heightWithoutKeyboard, pixelRatio: ${mediaQuery.devicePixelRatio}, isPortrait: $_isPortrait\n${mediaQuery.orientation}, isCell: $_isCell, isTablet: $_isTablet, isWeb: $kIsWeb--------\n\n');
    // }
  }
}
