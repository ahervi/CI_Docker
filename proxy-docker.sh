export http_proxy='http://proxy.enst-bretagne.fr:8080'
mkdir -p /etc/systemd/system/docker.service.d
echo "[Service]" > /etc/systemd/system/docker.service.d/proxy.conf
echo "Environment='HTTPS_PROXY=$http_proxy' 'HTTP_PROXY=$http_proxy'" >> /etc/systemd/system/docker.service.d/proxy.conf
systemctl daemon-reload
systemctl restart docker

echo '{' > /etc/docker/daemon.json
echo '    "dns": ["192.44.75.10", "192.108.115.2"]' >> /etc/docker/daemon.json
echo '}' >> /etc/docker/daemon.json
