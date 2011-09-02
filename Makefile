
clean:
	@echo "Cleaning barclamp-hive"

distclean:
	@echo "Dist-Cleaning barclamp-hive"

all: clean build install

build:
	@echo "Building barclamp-hive"

install:
	@echo "Installing barclamp-hive"
	mkdir -p ${DESTDIR}/opt/crowbar/openstack_manager
	cp -r app ${DESTDIR}/opt/crowbar/openstack_manager
	mkdir -p ${DESTDIR}/usr/share/barclamp-hive
	cp -r chef ${DESTDIR}/usr/share/barclamp-hive
	mkdir -p ${DESTDIR}/usr/bin
	cp -r command_line/* ${DESTDIR}/usr/bin

