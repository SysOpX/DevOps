For OPS
dpkg -l | grep jenkins
java -version          # Make sure Java is present (typically OpenJDK 21)
systemctl status jenkins
sudo cat /var/lib/jenkins/config.xml | grep -i version
##Back Up Jenkins
sudo systemctl stop jenkins
sudo systemctl status jenkins
sudo tar -czvf /root/jenkins_backup_$(date +%F).tar.gz /var/lib/jenkins
sudo cp -a /etc/default/jenkins /root/jenkins_default_$(date +%F).bak
sudo cp -a /etc/init.d/jenkins /root/jenkins_init_$(date +%F).bak 2>/dev/null || true
sudo cp -a /etc/systemd/system/jenkins.service /root/jenkins_service_$(date +%F).bak 2>/dev/null || true
##Upgrade Jenkins
sudo apt-get update
apt-cache policy jenkins
sudo apt-mark unhold jenkins
sudo apt-get install jenkins
##Start Jenkins
sudo systemctl daemon-reload  # just in case service file changed
sudo systemctl start jenkins
sudo systemctl enable jenkins
sudo systemctl status jenkins
sudo journalctl -u jenkins -f

##Lock Jenkins package 
If you want to avoid accidental upgrades in the future:
sudo apt-mark hold jenkins
To undo later:
sudo apt-mark unhold jenkins