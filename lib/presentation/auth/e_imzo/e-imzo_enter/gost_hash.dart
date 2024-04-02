import 'package:onlinebozor/presentation/auth/e_imzo/e-imzo_enter/hex.dart';
import 'gost_28147_engine.dart';
import 'ozdst_1106_digest.dart';

class GostHash{


  static String hashGost(String text){
    var ba = hash(text.codeUnits);
    return Hex.fromBytes(ba);
  }
  static List<int> hash(List<int> data, {String sBoxName = "D_A"}) {
    var sbox = GOST28147Engine.getSBox(sBoxName);
    var digest = new OzDSt1106Digest(sbox);
    digest.reset();
    digest.updateBuffer(data, 0, data.length);
    var h = new List.filled(digest.DigestSize, 0);
    digest.doFinal(h, 0);
    return h;
  }

}