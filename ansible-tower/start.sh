#!/bin/bash
#get script path
pushd `dirname $0` > /dev/null
SCRIPTPATH=`pwd`
popd > /dev/null
 	
echo $SCRIPTPATH

docker run -d \
	--name tower \
	-v "$SCRIPTPATH/license.txt":/etc/tower/license \
	-v tower_certs:/certs \
	-v tower_db:/var/lib/postgresql \
	-p 8443:443 \
	ansible-tower:3.2.1

docker logs -f tower
#-e TOWER_INIT_SCM_URL=https://github.com/dayglo/synergy-poc-setup \s