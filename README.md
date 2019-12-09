# certbot-dns-dnsmanager
ISPsystem DNS API for certbot --manual-auth-hook --manual-cleanup-hook

Install and renew Let's encrypt wildcard ssl certificate for domain *.site.com using ISPsystem DNS API:

#### 1) Clone this repo and set the API key
```bash
git clone https://github.com/gordienko/certbot-dns-dnsmanager.git && cd ./certbot-dns-dnsmanager
```

#### 2) Edit access settings

Get the parameters in your control panel or in your provider's billing system.

```bash
nano ./config.sh
```

#### 3) Install CertBot from git
```bash
cd ../ && git clone https://github.com/certbot/certbot && cd certbot
```

#### 4) Generate wildcard
```bash
./letsencrypt-auto certonly --manual-public-ip-logging-ok --agree-tos --email info@site.com --renew-by-default -d site.com -d *.site.com --manual --manual-auth-hook ../certbot-dns-dnsmanager/authenticator.sh --manual-cleanup-hook ../certbot-dns-dnsmanager/cleanup.sh --preferred-challenges dns-01 --server https://acme-v02.api.letsencrypt.org/directory
```

#### 5) Force Renew
```bash
./letsencrypt-auto renew --force-renew --manual --manual-auth-hook ../certbot-dns-dnsmanager/authenticator.sh --manual-cleanup-hook ../certbot-dns-dnsmanager/cleanup.sh --preferred-challenges dns-01 --server https://acme-v02.api.letsencrypt.org/directory
```
