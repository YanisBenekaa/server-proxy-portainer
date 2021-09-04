# Configuration

Au préalable avant de lancer le conteneur, il est nécessaire d'avoir éteind apache si il est installé sur la machine.

```bash
# Linux
sudo service apache2 stop
sudo systemctl stop apache2
# OSX
sudo apachectl stop
```

## Génération du certificat local

Installer [mkcert](https://github.com/FiloSottile/mkcert) et ensuite lancer la commande : 

```bash
sh gen-cert.sh
```

## Création du network proxy

```bash
docker network create proxy 
```

## Lancement du conteneur 

```bash
docker compose up -d
```


## Exemple de configuration dans le docker-compose.yml

Après avoir créé le certificat pour ces domains : *.docker.localhost
```yml
version: '3'
services:
  whoami:
    image: containous/whoami
    container_name: whoami
    security_opt:
      - no-new-privileges:true
    labels:
      - "traefik.enable=true"
      # URL pour accéder à ce conteneur
      - "traefik.http.routers.whoami.rule=Host(`whoami.docker.localhost`)"
      # Activation de TLS
      - "traefik.http.routers.whoami.tls=true"
      # Si le port est différent de 80, utilisez le service suivant:
      # - "traefik.http.services.<service_name>.loadbalancer.server.port=<port>"
    networks:
      - proxy

networks:
  proxy:
    external: true
```

On peut ensuite se rendre sur [https://whoami.docker.localhost](https://whoami.docker.localhost)

Source: [Zeste de savoir](https://zestedesavoir.com/billets/3355/traefik-v2-https-ssl-en-localhost/)