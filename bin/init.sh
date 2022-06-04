useradd openresty;
groupadd openresty;
usermod -g openresty openresty;
#groups openresty;
binDir=$(cd $(dirname $0); pwd);
cd $binDir;
mkdir ../logs/;
touch ../logs/error.log;
