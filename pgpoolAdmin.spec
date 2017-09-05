# How to build RPM:
#   rpmbuild -ba pgpoolAdmin.spec --define="dist .rhel6" --define="pgpooladmin_version 3.4.0"
#
# expecting RPM name are:
#   pgpoolAdmin-{version}.{rel}pgdg.rhel{v}.noarch.rpm
#   pgpoolAdmin-{version}.{rel}pgdg.rhel{v}.src.rpm
Summary:     PgpoolAdmin - web-based pgpool administration
Name:        pgpoolAdmin
Version:     %{pgpooladmin_version}
Release:     1pgdg%{?dist}
License:     BSD
Group:       Applications/Databases
URL:         http://pgpool.net/
BuildRoot:   %{_tmppath}/%{name}-%{version}-%{release}-root-%(%{__id_u} -n)
Source0:     %{name}-%{version}.tar.gz
#Source1:     %{name}.conf
Requires:    php >= 4.4.2
Requires:    php-pgsql >= 4.4.2
Requires:    webserver
#Requires:    pgpool-II
Buildarch:   noarch

%define      _pgpoolAdmindir    /var/www/html/%{name}

#Patch1:       pgmgt.conf.php.patch
Patch2:      pgpoolAdmin.patch

%description
The pgpool Administration Tool is management tool of pgpool-II. It is
possible to monitor, start, stop pgpool and change settings of pgpool-II.

%prep
%setup -q -n %{name}-%{version}
#%patch1 -p1
%patch2 -p1
%build

%install
rm -rf %{buildroot}
install -d %{buildroot}%{_pgpoolAdmindir}
install -d %{buildroot}%{_pgpoolAdmindir}/conf
install -d %{buildroot}%{_sysconfdir}/%{name}
install -m 644 *.php %{buildroot}%{_pgpoolAdmindir}
cp -a  doc/ images/ install/ js/ lang/ libs/ templates/ templates_c/ screen.css %{buildroot}%{_pgpoolAdmindir}
install -m 755 conf/* %{buildroot}%{_sysconfdir}/%{name}/
mv %{buildroot}%{_sysconfdir}/%{name}/pgmgt.conf.php %{buildroot}%{_pgpoolAdmindir}/conf/pgmgt.conf.php

#if [ -d %{_sysconfdir}/httpd/conf.d/ ]
#then
#    install -d %{buildroot}%{_sysconfdir}/httpd/conf.d/
#    install -m 755 %{SOURCE1} %{buildroot}%{_sysconfdir}/httpd/conf.d/%{name}.conf
#fi

%post
/sbin/service httpd reload > /dev/null 2>&1
#    /bin/chgrp apache /etc/pgpool-II/pgpool.conf
#    /bin/chgrp apache /etc/pgpool-II/pcp.conf
#    /bin/chmod g+w /etc/pgpool-II/pgpool.conf /etc/pgpool-II/pcp.conf
chmod 777 %{_pgpoolAdmindir}/templates_c
chmod 666 %{_pgpoolAdmindir}/conf/pgmgt.conf.php

%postun
/sbin/service httpd reload > /dev/null 2>&1
#if [ /etc/pgpool-II/pgpool.conf ]; then
#    /bin/chgrp root /etc/pgpool-II/pgpool.conf /etc/pgpool-II/pcp.conf
#fi

%clean
rm -rf %{buildroot}

%files
%defattr(0644,nobody,nobody,0755)
%doc README README.euc_jp
%dir %{_pgpoolAdmindir}
#%config(noreplace) %{_sysconfdir}/httpd/conf.d/%{name}.conf
#%config(noreplace) %{_sysconfdir}/%{name}/*
%attr(644,root,root) %{_pgpoolAdmindir}/*.php
%{_pgpoolAdmindir}/conf
%{_pgpoolAdmindir}/doc
%{_pgpoolAdmindir}/images
%{_pgpoolAdmindir}/install
%{_pgpoolAdmindir}/js
%{_pgpoolAdmindir}/lang
%{_pgpoolAdmindir}/libs
%{_pgpoolAdmindir}/templates
%{_pgpoolAdmindir}/templates_c
%{_pgpoolAdmindir}/screen.css


%changelog
* Tue Jan 27 2015 Nozomi Anzai <anzai@sraoss.co.jp> 3.4.1-1
- Add pgpoolAdmin.patch as patch2

* Wed Mar 13 2013 Nozomi Anzai <anzai@sraoss.co.jp> 3.2.2-1
- Update to 3.2.2
- Change directory to install: /usr/share -> /var/www/html

* Tue Feb 20 2007 Devrim Gunduz <devrim@commandprompt.com> 1.0.0-5
- Fix for packaging guidelines of web apps.

* Mon Oct 02 2006 Devrim Gunduz <devrim@commandprompt.com> 1.0.0-4
- chgrp and chmod pgpool-II conf files so that apache can write it.
- Change file ownership from apache to nobody.

* Tue Sep 26 2006 Devrim Gunduz <devrim@commandprompt.com> 1.0.0-3
- Update patch1

* Tue Sep 26 2006 Devrim Gunduz <devrim@commandprompt.com> 1.0.0-2
- Fix file ownership
- Update patch1

* Tue Sep 26 2006 Devrim Gunduz <devrim@commandprompt.com> 1.0.0-1
- Initial build
