#!/usr/bin/env bash
set -e
echo "⚙️ Copy files to remotes"
IPs=$arm64,$amd64
for ip in ${IPs//,/ }
do
  echo "Remote: $ip"
  ssh -o StrictHostKeyChecking=no -i $AWS_AMI_PRIVATE_KEY_FILE -p 22 ubuntu@$ip "mkdir -p /home/ubuntu/repo"
  rsync -av -e "ssh -o StrictHostKeyChecking=no -i $AWS_AMI_PRIVATE_KEY_FILE -p 22" ./ ubuntu@$ip:/home/ubuntu/repo --exclude=".*"
done
