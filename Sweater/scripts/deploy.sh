#!/usr/bin/env bash

mvn clean package

echo 'Copy files...'

scp -i ~/.ssh/sweater-london.pem \
    target/sweater-1.0-SNAPSHOT.jar \
    ec2-user@ec2-52-56-225-166.eu-west-2.compute.amazonaws.com:/home/ec2-user/
echo 'Restart server...'

ssh -i ~/.ssh/sweater-london.pem ec2-user@ec2-52-56-225-166.eu-west-2.compute.amazonaws.com << EOF
pgrep java | xargs kill -9
nohup java -jar sweater-1.0-SNAPSHOT.jar > log.txt &
EOF

echo 'Bye'