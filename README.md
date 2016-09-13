# Docker Bundle Cache

Features:

* No extra compose service
* Simple Dockerfile change
* Manual caching command
* Easy to clear cache
* Generally easy to understand

```
# build the image, and do the first slow bundle install 
docker build . -t my_app

# bundle good? cache it with
docker run -it -v "$(pwd):/app" my_app cache-bundle

# edit the Gemfile
# vi Gemfile

# build the image again
docker build . -t my_app

# note "Using..."

# profit? 💰 
```
