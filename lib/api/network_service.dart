import 'dart:convert';
import 'dart:io';
import 'package:http_parser/http_parser.dart';
import 'package:demo_fllutter_cmdev/api/post_data.dart';
import 'package:demo_fllutter_cmdev/constants/api.dart';
import 'package:demo_fllutter_cmdev/models/products.dart';
import 'package:dio/dio.dart';

class NetworkService {
  NetworkService._internal();
  // # Singleton
  static final NetworkService _instance = NetworkService._internal();

  factory NetworkService() => _instance;

  static final _dio = Dio()
    ..interceptors.add(
      InterceptorsWrapper(
        onRequest: (RequestOptions options) async {
          options.baseUrl = API.BASE_URL;
          print(options.baseUrl + options.path);

          options.connectTimeout = 5000;
          options.receiveTimeout = 3000;

          return options;
        },
        onResponse: (Response response) {
          return response;
        },
        onError: (DioError e) {
          return 'Network failled, try again';
        },
      ),
    );

  Future<List<Post>> fatchPosts(int startIndex, {int limit = 10}) async {
    final url =
        'https://jsonplaceholder.typicode.com/posts?_start=$startIndex&_limit=$limit';

    final Response response = await _dio.get(url);

    if (response.statusCode == 200) {
      return postFromJson(jsonEncode(response.data));
    } else {
      throw Exception('Network failled');
    }
  }

  // # GET
  Future<List<Product>> getAllProduct() async {
    // # Product url:
    final url = API.PRODUCT;
    print(url);
    final Response response = await _dio.get(url);

    if (response.statusCode == 200) {
      return productFromJson(jsonEncode(response.data));
    } else {
      throw Exception('Network failled');
    }
  }

  // # POST
  Future<String> addProduct(Product product, {File imageFile}) async {
    // # Product url:
    final url = API.PRODUCT;
    print(url);

    // create formdata
    FormData data = FormData.fromMap({
      'name': product.name,
      'price': product.price,
      'stock': product.stock,
      if (imageFile != null)
        'photo': await MultipartFile.fromFile(
          imageFile.path,
          contentType: MediaType('image', 'jpg'),
        )
    });

    // post : add data to database
    final Response response = await _dio.post(url, data: data);

    if (response.statusCode == 201) {
      return 'Add Successfully';
    } else {
      throw Exception('Network failled');
    }
  }

  // # PUT
  Future<String> editProduct(Product product, {File imageFile}) async {
    // # Product url:
    final url = "${API.PRODUCT}/${product.id}";
    print(url);

    // create formdata
    FormData data = FormData.fromMap({
      'name': product.name,
      'price': product.price,
      'stock': product.stock,
      if (imageFile != null)
        'photo': await MultipartFile.fromFile(
          imageFile.path,
          contentType: MediaType('image', 'jpg'),
        )
    });

    // put : edit data
    final Response response = await _dio.put(url, data: data);

    if (response.statusCode == 200) {
      return 'Edit Successfully';
    } else {
      throw Exception('Network failled');
    }
  }

  // # DELETE
  Future<String> delteProduct(int productId) async {
    // # Product url:
    final url = "${API.PRODUCT}/$productId";
    print(url);

    // delete : delete data
    final Response response = await _dio.delete(url);

    if (response.statusCode == 204) {
      return 'Delete Successfully';
    } else {
      throw Exception('Network failled');
    }
  }
}
