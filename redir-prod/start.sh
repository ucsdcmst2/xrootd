podman run -d  \
	--privileged \
        --name redi-prod \
        --network host \
        --volume $(pwd)/config/xrootd-redirector.cfg:/etc/xrootd/xrootd-redirector.cfg \
        --volume $(pwd)/config/macaroon-secret:/etc/xrootd/macaroon-secret \
        --volume $(pwd)/config/Authfile:/etc/xrootd/Authfile \
        --volume $(pwd)/hostcert.pem:/etc/grid-security/xrd/xrdcert.pem \
	--volume $(pwd)/hostkey.pem:/etc/grid-security/xrd/xrdkey.pem \
	--volume $(pwd)/config/scitokens.cfg:/etc/xrootd/scitokens.cfg \
        --volume $(pwd)/config/grid-mapfile:/etc/grid-security/grid-mapfile \
        --volume $(pwd)/config/voms-mapfile:/etc/grid-security/voms-mapfile \
        --volume $(pwd)/config/robots.txt:/etc/xrootd/robots.txt \
        hub.opensciencegrid.org/sense/sense-redir:el8-20250911
