cp mongodb-org-7,0.repo /etc/yum.repos.d/mongodb-org-7.0.repo

dnf install -y mongodb-org

systemctl enable mongod
systemctl start mongod