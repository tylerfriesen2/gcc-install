#!/bin/bash
gccversion=11.2.0
gmpversion=6.2.1
mpcversion=1.2.1
mpfrversion=4.1.0

mkdir "gcc-$gccversion"
sudo apt-get install gcc
sudo apt-get install g++
sudp apt-get install gdb
echo "Fetching gcc..."
echo
sleep 1
curl -s "https://ftp.gnu.org/gnu/gcc/gcc-${gccversion}/gcc-${gccversion}.tar.gz" | tar -zxv
if [ $? -ne 0 ]; then
	echo "Failed to fetch gcc."
	echo "Exiting."
	exit 1
fi
echo "Fetching gmp..."
echo
sleep 1
curl -s "https://ftp.gnu.org/gnu/gmp/gmp-${gmpversion}.tar.xz" | tar -Jxv
if [ $? -ne 0 ]; then
	echo "Failed to fetch gmp."
	echo "Exiting."
	exit 1
fi
mv -v "gmp-${gmpversion}" "gcc-${gccversion}"/gmp
echo "Fetching mpc..."
echo
sleep 1
curl -s "https://ftp.gnu.org/gnu/mpc/mpc-${mpcversion}.tar.gz" | tar -zxv
if [ $? -ne 0 ]; then
	echo "Failed to fetch mpc."
	echo "Exiting."
	exit 1
fi
mv -v "mpc-${mpcversion}" "gcc-${gccversion}/mpc"
echo "Fetching mpfr..."
echo
sleep 1
curl -s "https://ftp.gnu.org/gnu/mpfr/mpfr-${mpfrversion}.tar.xz" | tar -Jxv
if [ $? -ne 0 ]; then
	echo "Failed to fetch mpfr."
	echo "Exiting."
	exit 1
fi
mv -v "mpfr-${mpfrversion}" "gcc-${gccversion}/mpfr"
mkdir build
cd build
echo "Configuring gcc..."
echo
sleep 1
../"gcc-${gccversion}/configure" --program-suffix="-${gccversion}" --enable-languages=c,c++ --disable-multilib
if [ $? -ne 0 ]; then
	echo "Failed to configure properly."
	echo "Exiting."
	exit 1
fi

echo "Everything good so far. Exiting."

exit

echo "Making gcc..."
echo
sleep 1
sudo make
if [ $? -ne 0 ]; then
	echo "Make command failed."
	echo "Exiting."
	exit 1
fi
echo "Installing gcc..."
echo
sleep 1
sudo make install
if [ $? -ne 0 ]; then
	echo "Installation failed."
	echo "Exiting."
	exit 1
fi
echo "Installation successful."
sudo apt-add-repository ppa:ubuntu-toolchain-r/test
sudo apt-get update
sudo apt-get upgrade
sudo apt-get dist-upgrade
