#sed -i -e 's/\r$//' your_script.sh

sudo yum install -y wget httpd php gcc glibc glibc-common gd gd-devel make net-snmp unzip

cd /tmp

sudo wget https://github.com/scorpio7x/nagios/raw/master/nagios-4.2.0.tar.gzip

sudo wget https://github.com/scorpio7x/nagios/raw/master/nagios-plugins-2.1.2.tar.gzip

#wget https://github.com/scorpio7x/nagios/blob/master/nagios-4.3.4.tar.gzip?raw=true -O nagios-4.3.4.tar.gzip

#wget https://github.com/scorpio7x/nagios/blob/master/nagios-3.5.1.tar.gzip?raw=true -O nagios-3.5.1.tar.gzip

#wget https://github.com/scorpio7x/nagios/blob/master/nagios-plugins-2.2.1.tar.gzip?raw=true -O nagios-plugins-2.2.1.tar.gzip

sudo useradd nagios

sudo groupadd nagcmd

sudo usermod -a -G nagcmd nagios

tar -xvf nagios-4.2.0.tar.gzip

tar -xvf nagios-plugins-2.1.2.tar.gzip

cd nagios-4.2.0

sudo ./configure --with-command-group=nagcmd

sudo make all

sudo make install

sudo make install-init

sudo make install-commandmode

sudo make install-config

sudo make install-webconf

#vi /usr/local/nagios/etc/objects/contacts.cfg

clear

echo "THIET LAP MAT KHAU CHO ADMIN NAGIOS"

sudo htpasswd -s -c /usr/local/nagios/etc/htpasswd.users nagiosadmin

sudo systemctl start httpd.service

cd ..

cd nagios-plugins-2.1.2

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

