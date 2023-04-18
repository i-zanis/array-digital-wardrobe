import 'package:Array_App/data/network/dio_network_client.dart';
import 'package:Array_App/data/network/network_client.dart';

class NetworkClientFactory {
  static NetworkClient create() {
    return DioNetworkClient();
  }
}
