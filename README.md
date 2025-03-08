🚀 Running App

1️⃣ Requirements

Flutter SDK, Dart, Android Studio/vscode, PHP 8+, Composer, Laravel, MySQL"XAMPP"

2️⃣ Start Laravel Back-End

composer install  
cp .env.example .env  
php artisan key:generate  
php artisan migrate --seed  
php artisan serve  
🔹 API URL: http://127.0.0.1:8000/api

3️⃣ Run Flutter App

cd flutter_app  
flutter pub get  
flutter run  
