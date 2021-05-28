PKG_NAME = hinic
# Parse the package version from the changelog, "borrowed" from acpi_call
PKG_VER := $(shell dpkg-parsechangelog | grep '^Version:' | cut -d' ' -f2 |\
     rev | cut -d- -f2- | rev | cut -d':' -f2)

all: install

install: clean build
	tar Jxf hinic-*.tar.?z*
	echo "CONFIG_HINIC = m" > hinic/Kbuild
	cat hinic/Makefile >> hinic/Kbuild
	cp build hinic/
	mkdir -p debian/hinic-dkms/usr/src
	cp -r hinic debian/hinic-dkms/usr/src/$(PKG_NAME)-$(PKG_VER)
clean:
	rm -rf hinic
build:
