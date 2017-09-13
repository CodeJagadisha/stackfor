# Remove some stuff
sudo apt-get purge -y acpi acpid busybox dictionaries-common eject gettext-base groff groff-base ispell iamerican ibritish laptop-detect man-db manpages tasksel traceroute vim-common vim-tiny wamerican |& tee $HOME/Deven/Logs/purges.log


LIST OF PACKAGES

Desired=Unknown/Install/Remove/Purge/Hold
| Status=Not/Inst/Conf-files/Unpacked/halF-conf/Half-inst/trig-aWait/Trig-pend
|/ Err?=(none)/Reinst-required (Status,Err: uppercase=bad)
||/ Name                           Version                  Architecture Description
+++-==============================-========================-============-===============================================================================
ii  acl                            2.2.52-2                 i386         Access control list utilities
ii  adduser                        3.113+nmu3               all          add and remove users and groups
ii  apt                            1.0.9.8.2                i386         commandline package manager
ii  apt-utils                      1.0.9.8.2                i386         package management related utility programs
ii  base-files                     8+deb8u3                 i386         Debian base system miscellaneous files
ii  base-passwd                    3.5.37                   i386         Debian base system master password and group files
ii  bash                           4.3-11+b1                i386         GNU Bourne Again SHell
ii  binutils                       2.25-5                   i386         GNU assembler, linker and binary utilities
ii  bsdmainutils                   9.0.6                    i386         collection of more utilities from FreeBSD
ii  bsdutils                       1:2.25.2-6               i386         basic utilities from 4.4BSD-Lite
ii  busybox                        1:1.22.0-9+deb8u1        i386         Tiny utilities for small and embedded systems
ii  bzip2                          1.0.6-7+b3               i386         high-quality block-sorting file compressor - utilities
ii  console-setup                  1.123                    all          console font and keymap setup program
ii  console-setup-linux            1.123                    all          Linux specific part of console-setup
ii  coreutils                      8.23-4                   i386         GNU core utilities
ii  cpio                           2.11+dfsg-4.1+deb8u1     i386         GNU cpio -- a program to manage archives of files
ii  cpp                            4:4.9.2-2                i386         GNU C preprocessor (cpp)
ii  cpp-4.8                        4.8.4-1                  i386         GNU C preprocessor
ii  cpp-4.9                        4.9.2-10                 i386         GNU C preprocessor
ii  cron                           3.0pl1-127+deb8u1        i386         process scheduling daemon
ii  dash                           0.5.7-4+b1               i386         POSIX-compliant shell
ii  debconf                        1.5.56                   all          Debian configuration management system
ii  debconf-i18n                   1.5.56                   all          full internationalization support for debconf
ii  debian-archive-keyring         2014.3                   all          GnuPG archive keys of the Debian archive
ii  debianutils                    4.4+b1                   i386         Miscellaneous utilities specific to Debian
ii  dh-python                      1.20141111-2             all          Debian helper tools for packaging Python libraries and applications
rc  dictionaries-common            1.23.17                  all          spelling dictionaries - common utilities
ii  diffutils                      1:3.3-1+b1               i386         File comparison utilities
ii  discover                       2.1.2-7                  i386         hardware identification system
ii  discover-data                  2.2013.01.11             all          Data lists for Discover hardware detection system
ii  dkms                           2.2.0.3-2                all          Dynamic Kernel Module Support Framework
ii  dmidecode                      2.12-3                   i386         SMBIOS/DMI table decoder
ii  dmsetup                        2:1.02.90-2.2            i386         Linux Kernel Device Mapper userspace library
ii  dpkg                           1.17.26                  i386         Debian package management system
ii  e2fslibs:i386                  1.42.12-1.1              i386         ext2/ext3/ext4 file system libraries
ii  e2fsprogs                      1.42.12-1.1              i386         ext2/ext3/ext4 file system utilities
rc  emacsen-common                 2.0.8                    all          Common facilities for all emacsen
ii  findutils                      4.4.2-9+b1               i386         utilities for finding files--find, xargs
ii  gcc                            4:4.9.2-2                i386         GNU C compiler
ii  gcc-4.8                        4.8.4-1                  i386         GNU C compiler
ii  gcc-4.8-base:i386              4.8.4-1                  i386         GCC, the GNU Compiler Collection (base package)
ii  gcc-4.9                        4.9.2-10                 i386         GNU C compiler
ii  gcc-4.9-base:i386              4.9.2-10                 i386         GCC, the GNU Compiler Collection (base package)
ii  gnupg                          1.4.18-7                 i386         GNU privacy guard - a free PGP replacement
ii  gpgv                           1.4.18-7                 i386         GNU privacy guard - signature verification tool
ii  grep                           2.20-4.1                 i386         GNU grep, egrep and fgrep
ii  groff-base                     1.22.2-8                 i386         GNU troff text-formatting system (base system components)
ii  gzip                           1.6-4                    i386         GNU compression utilities
ii  hostname                       3.15                     i386         utility to set/show the host name or domain name
ii  ifupdown                       0.7.53.1                 i386         high level tools to configure network interfaces
ii  init                           1.22                     i386         System-V-like init utilities - metapackage
ii  init-system-helpers            1.22                     all          helper tools for all init systems
ii  initramfs-tools                0.120                    all          generic modular initramfs generator
ii  initscripts                    2.88dsf-59               i386         scripts for initializing and shutting down the system
ii  insserv                        1.14.0-5                 i386         boot sequence organizer using LSB init.d script dependency information
ii  installation-report            2.58                     all          system installation report
ii  iproute2                       3.16.0-2                 i386         networking and traffic control tools
ii  iptables                       1.4.21-2+b1              i386         administration tools for packet filtering and NAT
ii  iputils-ping                   3:20121221-5+b2          i386         Tools to test the reachability of network hosts
ii  isc-dhcp-client                4.3.1-6+deb8u2           i386         DHCP client for automatically obtaining an IP address
ii  isc-dhcp-common                4.3.1-6+deb8u2           i386         common files used by all of the isc-dhcp packages
ii  kbd                            1.15.5-2                 i386         Linux console font and keytable utilities
ii  keyboard-configuration         1.123                    all          system-wide keyboard preferences
ii  klibc-utils                    2.0.4-2                  i386         small utilities built with klibc for early boot
ii  kmod                           18-3                     i386         tools for managing Linux kernel modules
ii  less                           458-3                    i386         pager program similar to more
ii  libacl1:i386                   2.2.52-2                 i386         Access control list shared library
ii  libapt-inst1.5:i386            1.0.9.8.2                i386         deb package format runtime library
ii  libapt-pkg4.12:i386            1.0.9.8.2                i386         package management runtime library
ii  libasan0:i386                  4.8.4-1                  i386         AddressSanitizer -- a fast memory error detector
ii  libasan1:i386                  4.9.2-10                 i386         AddressSanitizer -- a fast memory error detector
ii  libatomic1:i386                4.9.2-10                 i386         support library providing __atomic built-in functions
ii  libattr1:i386                  1:2.4.47-2               i386         Extended attribute shared library
ii  libaudit-common                1:2.4-1                  all          Dynamic library for security auditing - common files
ii  libaudit1:i386                 1:2.4-1+b1               i386         Dynamic library for security auditing
ii  libblkid1:i386                 2.25.2-6                 i386         block device id library
ii  libboost-iostreams1.55.0:i386  1.55.0+dfsg-3            i386         Boost.Iostreams Library
ii  libbz2-1.0:i386                1.0.6-7+b3               i386         high-quality block-sorting file compressor library - runtime
ii  libc-bin                       2.19-18+deb8u3           i386         GNU C Library: Binaries
ii  libc6:i386                     2.19-18+deb8u3           i386         GNU C Library: Shared libraries
ii  libc6-i686:i386                2.19-18+deb8u3           i386         GNU C Library: Shared libraries [i686 optimized]
ii  libcap2:i386                   1:2.24-8                 i386         POSIX 1003.1e capabilities (library)
ii  libcap2-bin                    1:2.24-8                 i386         POSIX 1003.1e capabilities (utilities)
ii  libcilkrts5:i386               4.9.2-10                 i386         Intel Cilk Plus language extensions (runtime)
ii  libcloog-isl4:i386             0.18.2-1+b2              i386         Chunky Loop Generator (runtime library)
ii  libcomerr2:i386                1.42.12-1.1              i386         common error description library
ii  libcryptsetup4:i386            2:1.6.6-5                i386         disk encryption support - shared library
ii  libdb5.3:i386                  5.3.28-9                 i386         Berkeley v5.3 Database Libraries [runtime]
ii  libdebconfclient0:i386         0.192                    i386         Debian Configuration Management System (C-implementation library)
ii  libdevmapper1.02.1:i386        2:1.02.90-2.2            i386         Linux Kernel Device Mapper userspace library
ii  libdiscover2                   2.1.2-7                  i386         hardware identification library
ii  libdns-export100               1:9.9.5.dfsg-9+deb8u6    i386         Exported DNS Shared Library
ii  libestr0                       0.1.9-1.1                i386         Helper functions for handling strings (lib)
ii  libexpat1:i386                 2.1.0-6+deb8u1           i386         XML parsing C library - runtime library
ii  libffi6:i386                   3.1-2+b2                 i386         Foreign Function Interface library runtime
rc  libfreetype6:i386              2.5.2-3+deb8u1           i386         FreeType 2 font engine, shared library files
rc  libfuse2:i386                  2.9.3-15+deb8u2          i386         Filesystem in Userspace (library)
ii  libgcc-4.8-dev:i386            4.8.4-1                  i386         GCC support library (development files)
ii  libgcc-4.9-dev:i386            4.9.2-10                 i386         GCC support library (development files)
ii  libgcc1:i386                   1:4.9.2-10               i386         GCC support library
ii  libgcrypt20:i386               1.6.3-2+deb8u1           i386         LGPL Crypto library - runtime library
ii  libgdbm3:i386                  1.8.3-13.1               i386         GNU dbm database routines (runtime version)
ii  libgmp10:i386                  2:6.0.0+dfsg-6           i386         Multiprecision arithmetic library
ii  libgnutls-deb0-28:i386         3.3.8-6+deb8u3           i386         GNU TLS library - main runtime library
ii  libgnutls-openssl27:i386       3.3.8-6+deb8u3           i386         GNU TLS library - OpenSSL wrapper
ii  libgomp1:i386                  4.9.2-10                 i386         GCC OpenMP (GOMP) support library
ii  libgpg-error0:i386             1.17-3                   i386         library for common error values and messages in GnuPG components
ii  libhogweed2:i386               2.7.1-5                  i386         low level cryptographic library (public-key cryptos)
ii  libicu52:i386                  52.1-8+deb8u3            i386         International Components for Unicode
ii  libidn11:i386                  1.29-1+b2                i386         GNU Libidn library, implementation of IETF IDN specifications
ii  libirs-export91                1:9.9.5.dfsg-9+deb8u6    i386         Exported IRS Shared Library
ii  libisc-export95                1:9.9.5.dfsg-9+deb8u6    i386         Exported ISC Shared Library
ii  libisccfg-export90             1:9.9.5.dfsg-9+deb8u6    i386         Exported ISC CFG Shared Library
ii  libisl10:i386                  0.12.2-2                 i386         manipulating sets and relations of integer points bounded by linear constraints
ii  libitm1:i386                   4.9.2-10                 i386         GNU Transactional Memory Library
ii  libjson-c2:i386                0.11-4                   i386         JSON manipulation library - shared library
ii  libklibc                       2.0.4-2                  i386         minimal libc subset for use with initramfs
ii  libkmod2:i386                  18-3                     i386         libkmod shared library
ii  liblocale-gettext-perl         1.05-8+b1                i386         module using libc functions for internationalization in Perl
ii  liblogging-stdlog0:i386        1.0.4-1                  i386         easy to use and lightweight logging library
ii  liblognorm1:i386               1.0.1-3                  i386         Log normalizing library
ii  liblzma5:i386                  5.1.1alpha+20120614-2+b3 i386         XZ-format compression library
ii  libmnl0:i386                   1.0.3-5                  i386         minimalistic Netlink communication library
ii  libmount1:i386                 2.25.2-6                 i386         device mounting library
ii  libmpc3:i386                   1.0.2-1                  i386         multiple precision complex floating-point library
ii  libmpdec2:i386                 2.4.1-1                  i386         library for decimal floating point arithmetic (runtime library)
ii  libmpfr4:i386                  3.1.2-2                  i386         multiple precision floating-point computation
ii  libncurses5:i386               5.9+20140913-1+b1        i386         shared libraries for terminal handling
ii  libncursesw5:i386              5.9+20140913-1+b1        i386         shared libraries for terminal handling (wide character support)
ii  libnetfilter-acct1:i386        1.0.2-1.1                i386         Netfilter acct library
ii  libnettle4:i386                2.7.1-5                  i386         low level cryptographic library (symmetric and one-way cryptos)
ii  libnewt0.52:i386               0.52.17-1+b1             i386         Not Erik's Windowing Toolkit - text mode windowing with slang
ii  libnfnetlink0:i386             1.0.1-3                  i386         Netfilter netlink library
ii  libp11-kit0:i386               0.20.7-1                 i386         Library for loading and coordinating access to PKCS#11 modules - runtime
ii  libpam-modules:i386            1.1.8-3.1+deb8u1         i386         Pluggable Authentication Modules for PAM
ii  libpam-modules-bin             1.1.8-3.1+deb8u1         i386         Pluggable Authentication Modules for PAM - helper binaries
ii  libpam-runtime                 1.1.8-3.1+deb8u1         all          Runtime support for the PAM library
ii  libpam0g:i386                  1.1.8-3.1+deb8u1         i386         Pluggable Authentication Modules library
ii  libpci3:i386                   1:3.2.1-3                i386         Linux PCI Utilities (shared library)
ii  libpcre3:i386                  2:8.35-3.3+deb8u2        i386         Perl 5 Compatible Regular Expression Library - runtime files
ii  libpipeline1:i386              1.4.0-1                  i386         pipeline manipulation library
ii  libpng12-0:i386                1.2.50-2+deb8u2          i386         PNG library - runtime
ii  libpopt0:i386                  1.16-10                  i386         lib for parsing cmdline parameters
ii  libprocps3:i386                2:3.3.9-9                i386         library for accessing process information from /proc
ii  libpsl0:i386                   0.5.1-1                  i386         Library for Public Suffix List (shared libraries)
ii  libpython3-stdlib:i386         3.4.2-2                  i386         interactive high-level object-oriented language (default python3 version)
ii  libpython3.4-minimal:i386      3.4.2-1                  i386         Minimal subset of the Python language (version 3.4)
ii  libpython3.4-stdlib:i386       3.4.2-1                  i386         Interactive high-level object-oriented language (standard library, version 3.4)
ii  libquadmath0:i386              4.9.2-10                 i386         GCC Quad-Precision Math Library
ii  libreadline6:i386              6.3-8+b3                 i386         GNU readline and history libraries, run-time libraries
ii  libselinux1:i386               2.3-2                    i386         SELinux runtime shared libraries
ii  libsemanage-common             2.3-1                    all          Common files for SELinux policy management libraries
ii  libsemanage1:i386              2.3-1+b1                 i386         SELinux policy management library
ii  libsepol1:i386                 2.3-2                    i386         SELinux library for manipulating binary security policies
ii  libsigc++-2.0-0c2a:i386        2.4.0-1                  i386         type-safe Signal Framework for C++ - runtime
ii  libslang2:i386                 2.3.0-2                  i386         S-Lang programming library - runtime version
ii  libsmartcols1:i386             2.25.2-6                 i386         smart column output alignment library
ii  libsqlite3-0:i386              3.8.7.1-1+deb8u1         i386         SQLite 3 shared library
ii  libss2:i386                    1.42.12-1.1              i386         command-line interface parsing library
ii  libssl1.0.0:i386               1.0.1k-3+deb8u4          i386         Secure Sockets Layer toolkit - shared libraries
ii  libstdc++6:i386                4.9.2-10                 i386         GNU Standard C++ Library v3
ii  libsystemd0:i386               215-17+deb8u3            i386         systemd utility library
ii  libtasn1-6:i386                4.2-3+deb8u1             i386         Manage ASN.1 structures (runtime)
ii  libtext-charwidth-perl         0.04-7+b3                i386         get display widths of characters on the terminal
ii  libtext-iconv-perl             1.7-5+b2                 i386         converts between character sets in Perl
ii  libtext-wrapi18n-perl          0.06-7                   all          internationalized substitute of Text::Wrap
ii  libtinfo5:i386                 5.9+20140913-1+b1        i386         shared low-level terminfo library for terminal handling
ii  libubsan0:i386                 4.9.2-10                 i386         UBSan -- undefined behaviour sanitizer (runtime)
ii  libudev1:i386                  215-17+deb8u3            i386         libudev shared library
ii  libusb-0.1-4:i386              2:0.1.12-25              i386         userspace USB programming library
ii  libusb-1.0-0:i386              2:1.0.19-1               i386         userspace USB programming library
ii  libustr-1.0-1:i386             1.0.4-3+b2               i386         Micro string library: shared library
ii  libuuid-perl                   0.05-1+b1                i386         Perl extension for using UUID interfaces as defined in e2fsprogs
ii  libuuid1:i386                  2.25.2-6                 i386         Universally Unique ID library
ii  libxtables10                   1.4.21-2+b1              i386         netfilter xtables library
ii  linux-base                     3.5                      all          Linux image base package
ii  linux-compiler-gcc-4.8-x86     3.16.7-ckt20-1+deb8u4    i386         Compiler for Linux on x86 (meta-package)
ii  linux-headers-3.16.0-4-686-pae 3.16.7-ckt20-1+deb8u4    i386         Header files for Linux 3.16.0-4-686-pae
ii  linux-headers-3.16.0-4-common  3.16.7-ckt20-1+deb8u4    i386         Common header files for Linux 3.16.0-4
ii  linux-image-3.16.0-4-686-pae   3.16.7-ckt20-1+deb8u4    i386         Linux 3.16 for modern PCs
ii  linux-image-686-pae            3.16+63                  i386         Linux for modern PCs (meta-package)
ii  linux-kbuild-3.16              3.16.7-ckt20-1           i386         Kbuild infrastructure for Linux 3.16
ii  localepurge                    0.7.3.4                  all          reclaim disk space by removing unneeded localizations
ii  locales                        2.19-18+deb8u3           all          GNU C Library: National Language (locale) data [support]
ii  login                          1:4.2-3+deb8u1           i386         system login tools
ii  logrotate                      3.8.7-1+b1               i386         Log rotation utility
ii  lsb-base                       4.1+Debian13+nmu1        all          Linux Standard Base 4.1 init script functionality
ii  make                           4.0-8.1                  i386         utility for directing compilation
ii  man-db                         2.7.0.2-5                i386         on-line manual pager
ii  mawk                           1.3.3-17                 i386         a pattern scanning and text processing language
ii  mime-support                   3.58                     all          MIME files 'mime.types' & 'mailcap', and support programs
ii  mount                          2.25.2-6                 i386         Tools for mounting and manipulating filesystems
ii  multiarch-support              2.19-18+deb8u3           i386         Transitional package to ensure multiarch compatibility
ii  nano                           2.2.6-3                  i386         small, friendly text editor inspired by Pico
ii  ncurses-base                   5.9+20140913-1           all          basic terminal type definitions
ii  ncurses-bin                    5.9+20140913-1+b1        i386         terminal-related programs and man pages
ii  net-tools                      1.60-26+b1               i386         NET-3 networking toolkit
ii  netbase                        5.3                      all          Basic TCP/IP networking system
ii  netcat-traditional             1.10-41                  i386         TCP/IP swiss army knife
ii  nfacct                         1.0.1-1.1                i386         netfilter accounting object tool
ii  passwd                         1:4.2-3+deb8u1           i386         change and administer password and group data
ii  patch                          2.7.5-1                  i386         Apply a diff file to an original
ii  pciutils                       1:3.2.1-3                i386         Linux PCI Utilities
ii  perl-base                      5.20.2-3+deb8u4          i386         minimal Perl system
ii  procps                         2:3.3.9-9                i386         /proc file system utilities
ii  python3                        3.4.2-2                  i386         interactive high-level object-oriented language (default python3 version)
ii  python3-minimal                3.4.2-2                  i386         minimal subset of the Python language (default python3 version)
ii  python3.4                      3.4.2-1                  i386         Interactive high-level object-oriented language (version 3.4)
ii  python3.4-minimal              3.4.2-1                  i386         Minimal subset of the Python language (version 3.4)
ii  readline-common                6.3-8                    all          GNU readline and history libraries, common files
ii  rsyslog                        8.4.2-1+deb8u2           i386         reliable system and kernel logging daemon
ii  sed                            4.2.2-4+b1               i386         The GNU sed stream editor
ii  sensible-utils                 0.0.9                    all          Utilities for sensible alternative selection
ii  startpar                       0.59-3                   i386         run processes in parallel and multiplex their output
ii  sudo                           1.8.10p3-1+deb8u3        i386         Provide limited super user privileges to specific users
ii  systemd                        215-17+deb8u3            i386         system and service manager
ii  systemd-sysv                   215-17+deb8u3            i386         system and service manager - SysV links
ii  sysv-rc                        2.88dsf-59               all          System-V-like runlevel change mechanism
ii  sysvinit-utils                 2.88dsf-59               i386         System-V-like utilities
ii  tar                            1.27.1-2+b1              i386         GNU version of the tar archiving utility
ii  tzdata                         2015g-0+deb8u1           all          time zone and daylight-saving time data
ii  ucf                            3.0030                   all          Update Configuration File(s): preserve user changes to config files
ii  udev                           215-17+deb8u3            i386         /dev/ and hotplug management daemon
ii  usbutils                       1:007-2                  i386         Linux USB utilities
ii  util-linux                     2.25.2-6                 i386         Miscellaneous system utilities
ii  util-linux-locales             2.25.2-6                 all          Locales files for util-linux
ii  wget                           1.16-1                   i386         retrieves files from the web
ii  whiptail                       0.52.17-1+b1             i386         Displays user-friendly dialog boxes from shell scripts
ii  xkb-data                       2.12-1                   all          X Keyboard Extension (XKB) configuration data
ii  zlib1g:i386                    1:1.2.8.dfsg-2+b1        i386         compression library - runtime



LIST OF PACKAGES BY SIZE

5	init
7	gcc
14	libnetfilter-acct1
17	nfacct
18	libestr0
18	libuuid-perl
22	cpp
24	libatomic1
24	liblogging-stdlog0
28	libtext-wrapi18n-perl
29	libattr1
29	libcap2
34	libffi6
37	linux-image-686-pae
39	systemd-sysv
42	libusb-0.1-4
48	libacl1
49	libaudit-common
52	libpython3-stdlib
53	whiptail
58	hostname
60	libcap2-bin
60	libmnl0
60	libnfnetlink0
64	discover
65	libsemanage-common
66	libpipeline1
66	netbase
68	libcomerr2
68	libsigc++-2.0-0c2a
72	lsb-base
74	installation-report
77	libss2
78	bzip2
84	libdebconfclient0
84	libgdbm3
84	libtext-charwidth-perl
87	libjson-c2
87	libpci3
90	libbz2-1.0
90	logrotate
92	libtext-iconv-perl
93	startpar
97	init-system-helpers
97	liblognorm1
97	localepurge
99	libklibc
99	libprocps3
99	libtasn1-6
100	liblocale-gettext-perl
100	python3
103	libgomp1
103	libirs-export91
106	libudev1
106	netcat-traditional
108	debian-archive-keyring
108	libisccfg-export90
109	readline-common
110	sensible-utils
114	iputils-ping
114	libxtables10
118	libgcc1
119	libuuid1
121	libaudit1
124	ifupdown
124	libboost-iostreams1.55.0
125	dmsetup
125	sysv-rc
126	libitm1
129	libpopt0
134	libcilkrts5
135	sysvinit-utils
136	emacsen-common
139	linux-base
140	debianutils
140	python3-minimal
145	libmpc3
145	libusb-1.0-0
146	mime-support
151	zlib1g
153	libkmod2
157	acl
161	initscripts
170	dmidecode
172	libgnutls-openssl27
173	libnewt0.52
178	gcc-4.9-base
182	insserv
184	base-passwd
187	libcloog-isl4
187	mawk
190	dash
192	libpam-modules-bin
192	libselinux1
193	multiarch-support
197	libsystemd0
206	libpam0g
210	patch
211	libasan0
212	gcc-4.8-base
220	base-files
224	bsdutils
226	libhogweed2
229	ucf
230	libmpdec2
230	libubsan0
234	libdiscover2
238	gzip
251	libustr-1.0-1
253	libcryptsetup4
255	libsmartcols1
261	python3.4
262	libsemanage1
277	dh-python
282	libncurses5
286	libpng12-0
297	kmod
301	liblzma5
303	linux-compiler-gcc-4.8-x86
310	less
314	libfuse2
317	cron
318	libidn11
320	libp11-kit0
338	libsepol1
339	dkms
342	initramfs-tools
342	libnettle4
347	libapt-inst1.5
362	klibc-utils
367	libreadline6
371	ncurses-base
372	libdevmapper1.02.1
376	libncursesw5
385	libexpat1
387	libblkid1
412	mount
413	libisc-export95
414	libtinfo5
423	libpsl0
426	libmount1
430	e2fslibs
448	gpgv
448	libgpg-error0
453	bsdmainutils
469	console-setup
490	ncurses-bin
538	procps
550	isc-dhcp-common
570	libquadmath0
573	sed
606	busybox
611	libgmp10
614	debconf
629	libpcre3
657	cpio
688	linux-kbuild-3.16
696	usbutils
707	isc-dhcp-client
707	libasan1
748	libpam-modules
774	net-tools
780	libmpfr4
802	libgcrypt20
814	dictionaries-common
902	grep
915	libfreetype6
938	apt-utils
941	libsqlite3-0
946	diffutils
1042	console-setup-linux
1057	make
1066	adduser
1067	pciutils
1091	debconf-i18n
1210	libstdc++6
1227	kbd
1246	iproute2
1271	libslang2
1274	tzdata
1282	findutils
1365	iptables
1384	nano
1447	libpam-runtime
1473	libdns-export100
1638	libisl10
1755	wget
1808	rsyslog
1916	man-db
1942	libgnutls-deb0-28
2006	libdb5.3
2156	passwd
2180	login
2241	linux-headers-3.16.0-4-686-pae
2286	tar
2430	sudo
2477	keyboard-configuration
2606	libapt-pkg4.12
2809	e2fsprogs
2937	util-linux
2965	groff-base
3053	libc-bin
3085	apt
3169	libc6-i686
3237	libpython3.4-minimal
4392	discover-data
4582	python3.4-minimal
4735	perl-base
5005	gnupg
5073	bash
5127	libgcc-4.8-dev
5154	util-linux-locales
5578	xkb-data
5922	udev
6673	dpkg
7430	libssl1.0.0
7718	libgcc-4.9-dev
8973	libc6
9185	libpython3.4-stdlib
11885	systemd
13409	cpp-4.8  >>>>???
14311	coreutils
14361	gcc-4.8  >>>>???
16265	locales
16749	cpp-4.9
17926	gcc-4.9
20296	binutils
21938	linux-headers-3.16.0-4-common
27387	libicu52
118152	linux-image-3.16.0-4-686-pae
