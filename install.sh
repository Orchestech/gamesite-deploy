git clone https://github.com/Orchestech/gamesite-backend
git clone https://github.com/Orchestech/gamesite-frontend
git reset --hard gamesite-backend/.
git reset --hard gamesite-frontend/.
git pull gamesite-backend/.
git pull gamesite-frontend/.

echo "REACT_APP_APIURL=https://gamesite.weirdcat.su" > gamesite-frontend/.env

sudo docker build --no-cache -t gamesite-backend:1.0 gamesite-backend
sudo docker build --no-cache -t gamesite-frontend:1.0 gamesite-frontend

sudo docker-compose up -d --pull=never
