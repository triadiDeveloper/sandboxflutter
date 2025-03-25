// # Abstraksi pengecekan koneksi internet

abstract class NetworkInfo {
  Future<bool> get isConnected;
}