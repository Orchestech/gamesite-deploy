1. Склонируйте репозиторий
```
git clone https://github.com/Orchestech/gamesite-deploy.git
cd gamesite-deploy
```
2. Измените настройки в файле docker-compose.yml
3. Запустите установку
```
sudo sh install install.sh
```
4. Добавьте контейнер gamesite-deploy-frontend в сеть reverse-proxy. Предлагается использовать [Nginx Proxy Manager](https://github.com/NginxProxyManager/nginx-proxy-manager)

Для обновления до последней версии достаточно повторно запускать скрипт install.sh
