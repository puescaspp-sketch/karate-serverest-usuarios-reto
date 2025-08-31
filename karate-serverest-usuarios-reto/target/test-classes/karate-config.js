function fn() {
  var env = karate.env || 'dev';
  var config = {
    env: env,
    baseUrl: karate.properties['baseUrl'] || 'https://serverest.dev',
    adminEmail: karate.properties['ADMIN_EMAIL'] || karate.env == 'ci' ? karate.properties['ADMIN_EMAIL'] : 'admin@example.com',
    adminPassword: karate.properties['ADMIN_PASSWORD'] || karate.env == 'ci' ? karate.properties['ADMIN_PASSWORD'] : 'Admin*1234',
  };
  karate.configure('ssl', true);
  karate.configure('connectTimeout', 15000);
  karate.configure('readTimeout', 15000);
  return config;
}