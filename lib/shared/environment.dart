abstract class Environment {
  final String host;

  const Environment(this.host);
}

class EnvLocal extends Environment {
  const EnvLocal() : super("http://127.0.0.1");
}

class EnvRemote extends Environment {
  const EnvRemote() : super("https://flut-be.azurewebsites.net");
}
