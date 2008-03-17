#! /bin/sh

# Release package script.
#
# Usage: ./make_tarball version cvs-tag-name
#

CVSROOT=:ext:${USER}@cvs.pgfoundry.org:/cvsroot/pgpool
export CVSROOT

case $# in
0)
	TAGOPT=
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
cvs checkout $TAGOPT -d $PACKAGE_DIR pgpoolAdmin

# create templates_c directory.
mkdir $PACKAGE_DIR/templates_c

# remove CVS and tools directory
find $PACKAGE_DIR -name CVS -o -name tools -type d | xargs rm -rf

# make tar ball
tar czf $PACKAGE_DIR.tar.gz $PACKAGE_DIR
