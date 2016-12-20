#!/bin/sh

#This script will install the network monitor

echo "Installing rrdtool..."
sudo apt-get install rrdtool
echo ""
echo ""

echo "Installing apache2, python, php5, libapache2-mod-php5..."
sudo apt-get install apache2 php5 libapache2-mod-php5 python
echo ""
echo ""

echo "Cloning and installing speedtest-cli from github..."
cd ~/networkmonit
sudo git clone https://github.com/sivel/speedtest-cli.git
sudo python speedtest-cli/setup.py install

echo "Creating networkmonit folder in /var/www..."
sudo mkdir /var/www/networkmonit
sudo mkdir /var/www/networkmonit/speedtest
sudo mkdir /var/www/networkmonit/resources
echo ""
echo ""

echo "Configuring apache 2 allow access in /var/www/networkmonit/*"
sudo cp ~/networkmonit/apache2-config/networkmonit.conf /etc/apache2/sites-available
sudo cp ~/networkmonit/apache2-config/www-speedtest/* /var/www/networkmonit/speedtest/
sudo cp ~/networkmonit/apache2-config/www-resources/* /var/www/networkmonit/resources/
echo ""
echo ""

echo "Restarting apache..."
sudo /etc/init.d/apache2 restart
echo ""
echo ""

echo "Creating RRD files..."
sudo /bin/sh ~/networkmonit/speedtest/create_speedtest_rrd.sh
sudo /bin/sh ~/networkmonit/resources/create_resource_rrd.sh

echo "Adding pooling scripts to root crontab..."
HOME_DIR=`echo $(cd ~ && pwd)`
echo "You need to copy/paste the following lines in root crontab (sudo crontab -e)"
echo "----"
echo "#Pooler for networkmonit"
echo "*/5 * * * * /bin/sh $HOME_DIR/networkmonit/speedtest/run_speedtest.sh 2>$HOME_DIR/networkmonit/speedtest/LOG/crontab_err.log"
echo "*/5 * * * * /bin/sh $HOME_DIR/networkmonit/resources/update_resource_rrd.sh 2>$HOME_DIR/networkmonit/resources/LOG/crontab_err.log"
echo "----"
echo ""

echo "You need to add the following configuration to apache2 (/etc/apache2/sites-available/000-default.conf)"
echo "----"
echo 'Alias /networkmonit/ "/var/www/networkmonit/"'
echo 'Alias /networkmonit/speedtest "/var/www/networkmonit/speedtest"'
echo 'Alias /networkmonit/resources "/var/www/networkmonit/resources"'
echo "<Directory /var/www/>"
echo "Order allow,deny"
echo "Allow from all"
echo "Require all granted"
echo "</Directory>"
echo "----"
echo "Restart apache (sudo /etc/init.d/apache2 restart)"

