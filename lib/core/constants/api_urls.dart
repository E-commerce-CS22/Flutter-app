class ApiUrls {


  static const baseURL = "http://192.168.1.9:8000/";
  static const register = baseURL + 'api/customer/register';
  static const login = baseURL + 'api/login';
  static const logout = baseURL + 'api/customer/logout';
  static const  userProfile = baseURL + 'api/customer/profile';
  static const categories = baseURL + 'api/categories';
  static const cart = baseURL + 'api/carts/products';
  static const wishlist = baseURL + 'api/wishlists/products';
  static const updateUserInfo = baseURL + 'api/customer/profile';
  static const orders = baseURL + 'api/customer/orders';
  static const product = baseURL + 'api/products';



}


class ApiKey {

  static String first_name = "first_name";

}