import 'dart:convert' hide JsonDecoder;

import 'build_json_listener.dart';
import 'json_utf8_decoder_sink.dart';
import 'json_utf8_parser.dart';

class MyJsonUtf8Decoder extends Converter<List<int>, Object> {
  final bool _allowMalformed;

  MyJsonUtf8Decoder(this._allowMalformed);

  @override
  Object convert(List<int> input) {
    var parser = new JsonUtf8Parser(new BuildJsonListener(), _allowMalformed);
    parser.parse(input, 0, input.length);
    return parser.close();
  }

  @override
  ByteConversionSink startChunkedConversion(Sink<Object> sink) {
    return new JsonUtf8DecoderSink(sink, _allowMalformed);
  }
}