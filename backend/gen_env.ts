const keygen = require('keygen');
const fs = require('fs');

let envData = ''

function generate_key() {
    return keygen.url(keygen.medium);
}

const keys = {
    APP_KEYS: generate_key() + "==," + generate_key() + "==," + generate_key() + "==",
    API_TOKEN_SALT: generate_key() + "==",
    ADMIN_JWT_SECRET: generate_key() + "==",
    TRANSFER_TOKEN_SALT: generate_key() + "=="
}

envData += "Host=0.0.0.0\n";
envData += "Port=1339\n";
for (const key in keys) {
    envData += key + "=" + keys[key] + "\n";
}
envData += "# Database" + "\n";
envData += "DATABASE_CLIENT=sqlite" + "\n";
envData += "DATABASE_FILENAME=.tmp/data.db" + "\n";
envData += "JWT_SECRET=" + generate_key() + "==";

fs.writeFileSync('.env', envData);

console.log(".env file generated succesfully.");



