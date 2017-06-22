#script must be run as root!
if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

#enable ssh, block others
ufw --force enable
ufw default deny incoming
ufw allow ssh

#get nginx
apt-get update && apt-get install nginx -y

#allow nginx through ufw
ufw allow 'Nginx HTTP'

#removes default file for nginx server
rm -v /etc/nginx/sites-enabled/default
curl -o /etc/nginx/sites-enabled/planet-ignite https://raw.githubusercontent.com/m-hemmings/MiscFiles/master/pi/nginx/planet-ignite

#restart nginx
nginx -s reload
