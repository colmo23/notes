Create a direcotry

```
[centos@colmmini smtptest]$ cat Dockerfile
FROM node:7
ADD smtp_server /smtp_server
RUN chmod +x /smtp_server
ENTRYPOINT ["/smtp_server"]
```
Copy smtp_server binary into it (or whatever program you need)

sudo docker build -t smtptest .

sudo docker images | grep smtp

# Run the created image and forward port 1025 to 1025 inside the container (smtp_server program listens on 1025)
 sudo docker run --name smtp-test-container -p 1025:1025 -d smtptest

sudo docker stop smtp-test-container

# Downloading an image tarball and loading it manually into another system (eg if docker repo is down)

## Pull an image from a remote repo into the local repo:
sudo docker pull docker.adaptivemobile.com/npp/pxp:2.14.0-1147

## Save the pulled image to a local file
sudo docker save docker.adaptivemobile.com/npp/pxp:2.14.0-1147 > pxp-147.tar

## Then copy file to remove VM and load it using
sudo docker load < pxp-147.tar
