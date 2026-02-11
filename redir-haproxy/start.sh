podman run -d  \
	--privileged \
        --name haproxy \
        --network host \
        --volume $(pwd)/configs/haproxy.cfg:/etc/haproxy/haproxy.cfg \
        --volume $(pwd)/configs/random-redirect.lua:/etc/haproxy/random-redirect.lua \
        --volume $(pwd)/cert.pem:/usr/local/etc/haproxy/certs/cert.pem \
        haproxy:2.9 -f /etc/haproxy/haproxy.cfg
