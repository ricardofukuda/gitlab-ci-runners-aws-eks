# Build Gitlab Runner Docker image
sudo docker build --tag gitlab-ci-runners:latest .
sudo docker tag gitlab-ci-runners:latest 123456789.dkr.ecr.us-east-1.amazonaws.com/gitlab-ci-runners:latest
sudo docker push 123456789.dkr.ecr.us-east-1.amazonaws.com/gitlab-ci-runners:latest

aws ecr get-login-password --region us-east-1 | sudo docker login --username AWS --password-stdin 123456789.dkr.ecr.us-east-1.amazonaws.com