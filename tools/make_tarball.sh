#! /bin/sh

# Release package script.
#
# Usage: ./make_tarball [version git-tag-name]
#

case $# in
0)
	BRANCH=master
	VERSION=snapshot
	;;
2)
	BRANCH=$2
	VERSION=$1
	;;
*)
	echo "Usage: $0 version git-branch-name" 1>&2
	exit 1
	;;
esac

PACKAGE_DIR=pgpoolAdmin-$VERSION

echo "1. git clone"
rm -rf $PACKAGE_DIR
git clone ssh://git@git.postgresql.org/pgpooladmin.git $PACKAGE_DIR
echo ""

echo "2. git checkout"
cd $PACKAGE_DIR
git checkout $BRANCH
cd ../
echo ""

echo "3. Arrange dirs"
mkdir $PACKAGE_DIR/templates_c
find $PACKAGE_DIR -name tools -type d | xargs rm -rf
find $PACKAGE_DIR -name .git -type d | xargs rm -rf

echo "4. make tar ball"
tar czf $PACKAGE_DIR.tar.gz $PACKAGE_DIR
