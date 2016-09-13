# Docker Bundle Cache

Features:

* no extra service
* simple Dockerfile
* manual caching command
* easy to understand

```
# build the image, and do the first slow bundle install 
docker build . -t my_app

# bundle good? cache it with
docker run -it -v "$(pwd):/app" my_app ./cache_bundle.sh

# edit the Gemfile
# vi Gemfile

# build the image again
docker build . -t my_app

# note "Using..."

# profit? 💰 
```
