#!/bin/bash
sudo apt-get update -y
sudo apt-get install -y apache2
sudo apt-get install -y php
sudo systemctl start apache2
sudo systemctl enable apache2
echo "<html><body><h1>Hostname: <?php \$hostname = gethostname(); echo \$hostname; ?></h1></body></html>" | sudo tee /var/www/html/index.php
