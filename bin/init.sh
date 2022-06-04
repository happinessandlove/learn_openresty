useradd openresty;
groupadd openresty;
usermod -g openresty openresty;
#groups openresty;
mkdir ../logs/;
touch ../logs/error.log;
