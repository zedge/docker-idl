#!/bin/sh

case "$1" in
    sh|bash)
	exec /bin/$1
	;;
    *)
	exec /usr/local/bin/idl "$@"
	;;
esac
