# bundlecache

Reduce re-bundling time in docker builds using a cached bundle.

Features:

* Simple Dockerfile change
* Manual caching command
* No extra compose service
* Easy to clear cache (checkout bundle archive)

## Using this repo

This repo implements an example 'app' using bundlecache. The workflow is outlined below.

1. Create an empty bundle archive to use in the first build:

  ```bash
  touch bundle.tar.gz
  ```
2. Build the image, and do the first slow bundle install:

  ```bash
  docker build . -t bundlecache_example
  ```
3. (Optional) Make some edits to the Gemfile (new gems, change versions etc.)
3. Bundle install to get the Gemfile.lock out:

  ```bash
  docker run -it -v "$(pwd):/app" bundlecache_example bundle install
  ```
4. Cache the bundle's current state (can take upto 30 seconds for larger bundles):

  ```bash
  docker run -it -v "$(pwd):/app" bundlecache_example bundlecache
  ```
5. Build the image a second time:

  ```bash
  docker build . -t bundlecache_example
  ```
Note how this time during `bundle install` that gems in the existing bundle are used, rather than installing from scratch.

## Using bundlecache in an existing image

1. Create an empty bundle archive:

  ```bash
  touch bundle.tar.gz
  ```
2. Ignore the bundle cache archive:

  ```bash
  echo "bundle.tar.gz" >> .gitignore
  ```
3. Add the following to your Dockerfile:

  ```Dockerfile
  # include alongside adding Gemfile (requires use of ADD for unarchiving)
  ADD ./bundle.tar.gz /

  # include anywhere, this enables the `bundecache` command
  RUN printf '#!/bin/sh\ntar -zcf /app/bundle.tar.gz /usr/local/bundle\n' > /usr/local/bin/bundlecache
  RUN chmod +x /usr/local/bin/bundlecache
  ```

Then follow the workflow outlined above, making adjustments to the application name and WORKDIR where required.
