import 'package:logging/logging.dart';
import 'package:json_conv/json_conv.dart';

void test<T>(Type i) {
  final Type d = T;
  print(d);
  print(T);
  print(i);
  print("${d == i}");
}

final json =
    '{"_total":2,"streams":[{"_id":24854234912,"game":"League of Legends","viewers":23095,"video_height":1080,"average_fps":60,"delay":0,"created_at":"2017-03-22T11:18:07Z","is_playlist":false,"preview":{"small":"https://static-cdn.jtvnw.net/previews-ttv/live_user_imaqtpie-80x45.jpg","medium":"https://static-cdn.jtvnw.net/previews-ttv/live_user_imaqtpie-320x180.jpg","large":"https://static-cdn.jtvnw.net/previews-ttv/live_user_imaqtpie-640x360.jpg","template":"https://static-cdn.jtvnw.net/previews-ttv/live_user_imaqtpie-{width}x{height}.jpg"},"channel":{"mature":false,"partner":true,"status":"the highest ranked adc in north american solo queue shows you what must be done to achieve such a grandiose title in a stellar fashion ","broadcaster_language":"en","display_name":"imaqtpie","game":"League of Legends","language":"en","_id":24991333,"name":"imaqtpie","created_at":"2011-09-22T13:10:14Z","updated_at":"2017-03-22T16:35:07Z","delay":null,"logo":"https://static-cdn.jtvnw.net/jtv_user_pictures/imaqtpie-profile_image-8efb10b7bed60d76-300x300.jpeg","banner":null,"video_banner":null,"background":null,"profile_banner":null,"profile_banner_background_color":null,"url":"https://www.twitch.tv/imaqtpie","views":199369014,"followers":1622638,"_links":{"self":"https://api.twitch.tv/kraken/channels/imaqtpie","follows":"https://api.twitch.tv/kraken/channels/imaqtpie/follows","commercial":"https://api.twitch.tv/kraken/channels/imaqtpie/commercial","stream_key":"https://api.twitch.tv/kraken/channels/imaqtpie/stream_key","chat":"https://api.twitch.tv/kraken/chat/imaqtpie","features":"https://api.twitch.tv/kraken/channels/imaqtpie/features","subscriptions":"https://api.twitch.tv/kraken/channels/imaqtpie/subscriptions","editors":"https://api.twitch.tv/kraken/channels/imaqtpie/editors","teams":"https://api.twitch.tv/kraken/channels/imaqtpie/teams","videos":"https://api.twitch.tv/kraken/channels/imaqtpie/videos"}},"_links":{"self":"https://api.twitch.tv/kraken/streams/imaqtpie"}},{"_id":24854283536,"game":"League of Legends","viewers":6088,"video_height":1080,"average_fps":60.4929051531,"delay":0,"created_at":"2017-03-22T11:32:27Z","is_playlist":false,"preview":{"small":"https://static-cdn.jtvnw.net/previews-ttv/live_user_fate_twisted_na-80x45.jpg","medium":"https://static-cdn.jtvnw.net/previews-ttv/live_user_fate_twisted_na-320x180.jpg","large":"https://static-cdn.jtvnw.net/previews-ttv/live_user_fate_twisted_na-640x360.jpg","template":"https://static-cdn.jtvnw.net/previews-ttv/live_user_fate_twisted_na-{width}x{height}.jpg"},"channel":{"mature":false,"partner":true,"status":"music is the key, my commentary HOLDS ME BACK","broadcaster_language":"en","display_name":"Fate_Twisted_NA","game":"League of Legends","language":"en","_id":91137296,"name":"fate_twisted_na","created_at":"2015-05-15T21:46:20Z","updated_at":"2017-03-22T16:35:09Z","delay":null,"logo":"https://static-cdn.jtvnw.net/jtv_user_pictures/fate_twisted_na-profile_image-f51be41c0c37cf65-300x300.jpeg","banner":null,"video_banner":"https://static-cdn.jtvnw.net/jtv_user_pictures/fate_twisted_na-channel_offline_image-1f3444194662a008-1920x1080.jpeg","background":null,"profile_banner":"https://static-cdn.jtvnw.net/jtv_user_pictures/fate_twisted_na-profile_banner-500ddbd648f0f88f-480.jpeg","profile_banner_background_color":null,"url":"https://www.twitch.tv/fate_twisted_na","views":9460791,"followers":294769,"_links":{"self":"https://api.twitch.tv/kraken/channels/fate_twisted_na","follows":"https://api.twitch.tv/kraken/channels/fate_twisted_na/follows","commercial":"https://api.twitch.tv/kraken/channels/fate_twisted_na/commercial","stream_key":"https://api.twitch.tv/kraken/channels/fate_twisted_na/stream_key","chat":"https://api.twitch.tv/kraken/chat/fate_twisted_na","features":"https://api.twitch.tv/kraken/channels/fate_twisted_na/features","subscriptions":"https://api.twitch.tv/kraken/channels/fate_twisted_na/subscriptions","editors":"https://api.twitch.tv/kraken/channels/fate_twisted_na/editors","teams":"https://api.twitch.tv/kraken/channels/fate_twisted_na/teams","videos":"https://api.twitch.tv/kraken/channels/fate_twisted_na/videos"}},"_links":{"self":"https://api.twitch.tv/kraken/streams/fate_twisted_na"}}],"_links":{"self":"https://api.twitch.tv/kraken/streams?channel=riotgames2%2Cotespiezo%09%2Csaintvicious%2Cmilkakoe%2Cdropthegun234%2Cfate_twisted_na%2Cimaqtpie%2Cotespiezo%2Cschuhbart%2Ceulcs2%2Cvoyboy%2Chotshotgg%2Cpobelter%2Ckemonozume%2Caim1ess%2Cyuubari_ad%2Cboesking%2Cepixz%2Csadathylive%2Cnalcs1%2Cnalcs2%2Cgreenspeak%2CHashinshinismyhusbando%2Criotgames%2Chashinshin%2Cheisendongna%2Cgullin15\u0026limit=25\u0026stream_type=live","next":"https://api.twitch.tv/kraken/streams?channel=riotgames2%2Cotespiezo%09%2Csaintvicious%2Cmilkakoe%2Cdropthegun234%2Cfate_twisted_na%2Cimaqtpie%2Cotespiezo%2Cschuhbart%2Ceulcs2%2Cvoyboy%2Chotshotgg%2Cpobelter%2Ckemonozume%2Caim1ess%2Cyuubari_ad%2Cboesking%2Cepixz%2Csadathylive%2Cnalcs1%2Cnalcs2%2Cgreenspeak%2CHashinshinismyhusbando%2Criotgames%2Chashinshin%2Cheisendongna%2Cgullin15\u0026limit=25\u0026offset=25\u0026stream_type=live","featured":"https://api.twitch.tv/kraken/streams/featured","summary":"https://api.twitch.tv/kraken/streams/summary","followed":"https://api.twitch.tv/kraken/streams/followed"}}';

class TwitchResponse {
  List<Streams> streams;
  @Property(name: "_total")
  int total;

  TwitchResponse();

  @override
  String toString() {
    return "total: $total\nstreams: ${streams?.fold('', (a, b) => a+b.toString())}";
  }
}

class Streams {
  @Property(name: "_id")
  int id;
  String game;
  Channel channel;

  Streams();

  @override
  String toString() {
    return "id: $id, game: $game, channel: $channel";
  }
}

class Channel {
  String status;
  @Property(name: "display_name")
  String displayName;
  String game;
  String language;
  @Property(name: "_id")
  int id;
  String name;

  Channel();

  @override
  String toString() {
    return "status: $status, displayName: $displayName, game: $game, language: $language, id: $id, name: $name";
  }
}

void main() {
  hierarchicalLoggingEnabled = true;
  Logger.root.level = Level.OFF;
  Logger.root.onRecord.listen((LogRecord rec) {
    print('${rec.level.name}: ${rec.time}: ${rec.message}');
  });

  final sample = decode<TwitchResponse>(json, TwitchResponse);
  print(sample);
  // final json =
  //     '{"persons": {"person1": {"name": "name"},"person2": {"name": "name2"},"person3": {"name": "name3"}}}';
  // final sample = decodeTest<MapComplex>(json, MapComplex);
  // print(sample.persons);

  // int its = 20000;
  // Stopwatch w = new Stopwatch();
  // w.start();
  // for (int i = 0; i < its; i++) {
  //   var b = JSON.decode(list);
  // }
  // w.stop();
  // print("JSON.decode took: ${w.elapsedMilliseconds}");

  // w.reset();
  // w.start();
  // for (int i = 0; i < its; i++) {
  //   var b = decode<List<Test6>>(list, new List<Test6>().runtimeType);
  //   //print(b.length);
  // }
  // w.stop();
  // print("decode 3rd version took: ${w.elapsedMilliseconds}");

  // w.reset();
  // w.start();
  // for (int i = 0; i < its; i++) {
  //   var b = decodeObj<List<Test6>>(
  //       JSON.decode(list), new List<Test6>().runtimeType);
  //   //print(b.length);
  // }
  // w.stop();
  // print("decode 2nd version took: ${w.elapsedMilliseconds}");

  // w.reset();
  // w.start();
  // for (int i = 0; i < its; i++) {
  //   var b = god.deseriaizeJson(list, outputType: new List<Test6>().runtimeType);
  //   //print(b.length);
  // }
  // w.stop();
  // print("json god took: ${w.elapsedMilliseconds}");

  // w.reset();
  // w.start();
  // var dson = new d.Dartson.JSON();
  // for (int i = 0; i < its; i++) {
  //   var b = dson.decode(list, new Test6(), true);
  //   //print(b.length);
  // }
  // w.stop();
  // print("dartson took: ${w.elapsedMilliseconds}");
}
