start /b nodemon -e dart,yaml --ignore build --exec "dart compile js web/main.dart -o build/main.dart.js && cp web/index.html build/index.html" && start /b http://localhost:3001 && py -m http.server --dir build --bind 0.0.0.0 3001