part of dawn;

void runApp(final Widget app) {
  if (app is StatelessWidget) {
    StatelessNode(app)._initialize();
  } else if (app is StatefulWidget) {
    StatefulNode(app)._initialize();
  } else {
    throw TypeError();
  }
}
