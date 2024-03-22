git clone https://github.com/Orchestech/gamesite-backend
git clone https://github.com/Orchestech/gamesite-frontend
git -C gamesite-backend/. reset --hard
git -C gamesite-frontend/. reset --hard
git -C gamesite-backend/. pull
git -C gamesite-frontend/. pull

echo "REACT_APP_APIURL=https://gamesite.weirdcat.su" > gamesite-frontend/.env

sudo docker build --no-cache -t gamesite-backend:1.0 gamesite-backend
sudo docker build --no-cache -t gamesite-frontend:1.0 gamesite-frontend

sudo docker-compose up -d --pull=never
