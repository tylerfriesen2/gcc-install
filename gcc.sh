#!/bin/bash
sudo apt-get install gcc
sudo apt-get install g++
sudp apt-get install gdb
echo "Fetching gcc..."
echo
sleep 1
curl -s https://ftp.gnu.org/gnu/gcc/gcc-11.1.0/gcc-11.1.0.tar.gz | tar -zxv
clear
if [ $? -ne 0 ]; then
	echo "Failed to fetch gcc."
	echo "Exiting."
	exit 1
fi
echo "Fetching gmp..."
echo
sleep 1
curl -s https://ftp.gnu.org/gnu/gmp/gmp-6.2.1.tar.xz | tar -Jxv
if [ $? -ne 0 ]; then
	echo "Failed to fetch gmp."
	echo "Exiting."
	exit 1
fi
mv -v gmp-6.2.1 gcc-11.1.0/gmp
clear
echo "Fetching mpc..."
echo
sleep 1
curl -s https://ftp.gnu.org/gnu/mpc/mpc-1.2.1.tar.gz | tar -zxv
if [ $? -ne 0 ]; then
	echo "Failed to fetch mpc."
	echo "Exiting."
	exit 1
fi
mv -v mpc-1.2.1 gcc-11.1.0/mpc
clear
echo "Fetching mpfr..."
echo
sleep 1
curl -s https://ftp.gnu.org/gnu/mpfr/mpfr-4.1.0.tar.xz | tar -Jxv
if [ $? -ne 0 ]; then
	echo "Failed to fetch mpfr."
	echo "Exiting."
	exit 1
fi
mv -v mpfr-4.1.0 gcc-11.1.0/mpfr
clear
mkdir build
cd build
clear
echo "Configuring gcc..."
echo
sleep 1
../gcc-11.1.0/configure --program-suffix=-11.1.0 --enable-languages=c,c++ --disable-multilib
if [ $? -ne 0 ]; then
	echo "Failed to configure properly."
	echo "Exiting."
	exit 1
fi
clear
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
