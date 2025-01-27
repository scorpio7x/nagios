#sed -i -e 's/\r$//' your_script.sh

sudo yum install -y wget httpd php gcc glibc glibc-common gd gd-devel make net-snmp unzip

cd /tmp

sudo wget https://github.com/scorpio7x/nagios/raw/master/nagios-4.3.4.tar.gzip

sudo wget https://github.com/scorpio7x/nagios/raw/master/nagios-plugins-2.2.1.tar.gzip

sudo useradd nagios

sudo groupadd nagcmd

sudo usermod -a -G nagcmd nagios

sudo usermod -a -G nagcmd apache

setenforce 0

tar -xvf nagios-4.3.4.tar.gzip

tar -xvf nagios-plugins-2.2.1.tar.gzip

cd nagios-4.3.4

sudo ./configure --with-command-group=nagcmd

sudo make all

sudo make install

sudo make install-init

sudo make install-commandmode

sudo make install-config

sudo make install-webconf

chown nagios:nagcmd /usr/local/nagios/var/rw

chown nagios:nagcmd /usr/local/nagios/var/rw/nagios.cmd

clear

echo "THIET LAP MAT KHAU CHO ADMIN NAGIOS"

sudo htpasswd -s -c /usr/local/nagios/etc/htpasswd.users nagiosadmin

sudo systemctl start httpd.service

cd ..

cd nagios-plugins-2.2.1

sudo ./configure --with-nagios-user=nagios --with-nagios-group=nagios

sudo make

sudo make install

sudo /usr/local/nagios/bin/nagios -v /usr/local/nagios/etc/nagios.cfg

sudo chkconfig --add nagios

sudo chkconfig --level 35 nagios on

sudo chkconfig --add httpd

sudo chkconfig --level 35 httpd on

sudo systemctl enable nagios

sudo systemctl enable httpd

sudo systemctl start nagios.service

sudo rm -frv /tmp/nagios*

clear
echo "CAI DAT NAGIOS CORE DA HOAN TAT"
echo
echo "DIA CHI DANG NHAP: http://$(ip addr | grep 'state UP' -A2 | tail -n1 | awk '{print $2}' | cut -f1  -d'/')/nagios"
echo
echo "ACCOUNT LOGIN: nagiosadmin"
echo
echo "PASSWORD BAN DA THIET LAP TRUOC DO"
echo





