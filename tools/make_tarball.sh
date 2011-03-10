#! /bin/sh

# Release package script.
#
# Usage: ./make_tarball [version cvs-tag-name]
#

CVSROOT=:ext:${USER}@cvs.pgfoundry.org:/cvsroot/pgpool
export CVSROOT

case $# in
0)
	TAGOPT="-r HEAD"
	VERSION=snapshot
	;;
2)
	TAGOPT="-r $2"
	VERSION=$1
	;;
*)
	echo "Usage: $0 pgpoolAdmin-versino cvs-tag-name" 1>&2
	exit 1
	;;
esac

PACKAGE_DIR=pgpoolAdmin-$VERSION

rm -rf $PACKAGE_DIR
cvs export $TAGOPT -d $PACKAGE_DIR pgpoolAdmin

# create templates_c directory.
mkdir $PACKAGE_DIR/templates_c

# remove tools directory
find $PACKAGE_DIR -name tools -type d | xargs rm -rf

# make tar ball
tar czf $PACKAGE_DIR.tar.gz $PACKAGE_DIR
