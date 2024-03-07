git clone https://github.com/Orchestech/gamesite-backend
git clone https://github.com/Orchestech/gamesite-frontend
sudo docker build --no-cache -t gamesite-backend:1.0 gamesite-backend
sudo docker build --no-cache -t gamesite-frontend:1.0 gamesite-frontend

sudo docker-compose up -d --pull=never
