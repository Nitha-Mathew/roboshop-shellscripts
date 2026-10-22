log_file=/tmp/roboshop.log
rm -f roboshop.log
nodejs_setup()
{
  echo -e \\e[36m Configure Nodejs Repo \\e[0m
  curl -fsSL https://rpm.nodesource.com/setup_20.x | bash - &>>${log_file}
  echo $?

  echo -e \\e[36m Install Nodejs \\e[0m
  dnf install -y nodejs &>>${log_file}
  echo $?

  cp ${appname}.service /etc/systemd/system/${app_name}.service

  echo -e \\e[36m Create appuser \\e[0m
  useradd -r -s /bin/false appuser &>>${log_file}
  echo $?
  mkdir -p /app

  echo -e \\e[36m Download APP code \\e[0m
  curl -L -o /tmp/${app_name}.zip https://raw.githubusercontent.com/raghudevopsb89/roboshop-microservices/main/artifacts/${app_name}.zip &>>${log_file}
  echo $?

  cd /app

  echo -e \\e[36m Extract App code \\e[0m
  unzip /tmp/${app_name}.zip &>>${log_file}
  echo $?

  echo -e \\e[36m Compile App code  \\e[0m
  npm install --production >>${log_file}
  echo $?

  echo -e \\e[36m Set permissions to app code \\e[0m
  chown -R appuser:appuser /app &>>${log_file}
  chmod o-rwx /app -R &>>${log_file}
  echo $?

  echo -e \\e[36m Start service \\e[0m
  systemctl daemon-reload &>>${log_file}
  systemctl enable ${app_name} &>>${log_file}
  systemctl restart ${app_name} &>>${log_file}
  echo $?
}