import 'dart:io';
import 'package:amix/src/amix/route/route.dart';

///[AmixRequest]
///
///Server HttpRequests will Convert to AmixRequest
class AmixRequest {
  ///The cookies in the request, from the "Cookie" headers.
  final List<Cookie> cookies;

  ///The request headers.
  ///
  ///The returned [HttpHeaders] are immutable
  final HttpHeaders headers;

  ///The persistent connection state signaled by the client.
  final bool persistentConnection;

  ///Information about the client connection.
  ///
  ///Returns null if the socket is not available.
  final HttpConnectionInfo? connectionInfo;

  ///The method, such as 'GET' or 'POST', for the request.
  final String method;

  ///The requested URI for the request.
  ///
  ///The returned URI is
  /// reconstructed by using
  ///  http-header fields,
  ///  to access otherwise
  /// lost information,
  /// e.g. host and scheme.
  ///
  ///To reconstruct the scheme
  ///, first
  ///'X-Forwarded-Proto' is checked,
  ///and then falling back
  /// to server type.
  ///
  ///To reconstruct the host, first 'X-Forwarded-Host'
  ///is checked,
  ///then 'Host' and finally calling back to server.
  final Uri requestedUri;

  ///The content length of the request body.
  ///
  ///If the size of the request body is not known in advance, this value is -1.
  final int contentLength;

  ///The HTTP protocol version used in the request, either "1.0" or "1.1".
  final String protocolVersion;

  ///The URI for the request.
  ///
  ///This provides access to the path and query string for the request.
  final Uri uri;

  ///The client certificate of the client making the request.
  ///
  ///This value is null if the connection is
  /// not a secure TLS or SSL connection
  /// , or if the server does not request
  ///  a client certificate,
  ///  or if the client does not provide one.
  final X509Certificate? certificate;

  ///route of Server
  final AmixRoute route;

  ///query parameters
  late Map<String, String> params;

  ///hide parameters
  final Map<String, String> hideParams;

  ///[AmixRequest]
  ///
  ///Server HttpRequests will Convert to AmixRequest
  AmixRequest({
    required this.protocolVersion,
    required this.persistentConnection,
    required this.connectionInfo,
    required this.certificate,
    required this.cookies,
    required this.headers,
    required this.contentLength,
    required this.method,
    required this.requestedUri,
    required this.uri,
    required this.route,
    required this.hideParams,
  }) {
    params = uri.queryParameters;
  }
}
