ENVBASH=$1
ENVBASH=${ENVBASH:-"bash"}
#echo "ENVBASH=$ENVBASH"
docker run --rm -t -i andrefernandes/docker-mysql:latest $ENVBASH ${@:2}

