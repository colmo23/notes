# Sample python web server image

# Running

Run the following commands in this directory

## Build the image
```
docker build -t python-web-server:latest .
```

## Run the container
```
docker run -d -p 8080:5000 --name python-app-container python-web-server:latest
```

## Verify
```
http://localhost:8080
```

## Check logs
```
docker logs python-app-container
```
