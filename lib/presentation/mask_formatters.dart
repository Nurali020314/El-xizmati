import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

var phoneMaskFormatter = MaskTextInputFormatter(
    mask: '___ __ ___ __ __',
    filter: {"_": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy);

var brithMaskFormatter = MaskTextInputFormatter(
    mask: '____-__-__',
    filter: {"_": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy);

var biometricNumberMaskFormatter = MaskTextInputFormatter(
    mask: '___ __ __',
    filter: {"_": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy);

var cardNumberMaskFormatter = MaskTextInputFormatter(
    mask: '____ ____ ____ ____',
    filter: {"_": RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy);

var cardExpiredMaskFormatter = MaskTextInputFormatter(
    mask: '__/__',
    filter: {"_": RegExp(r'[0-9]'),},
    type: MaskAutoCompletionType.lazy);