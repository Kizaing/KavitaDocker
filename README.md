# What is Kavita?
Kavita is a free and open source web based Manga e-reader. 

It was developed by majora2007 and the source is [here](https://github.com/Kareadita/Kavita)

# How to use
Running your Kavita server in docker is super easy! Barely an inconvenience. You can run it with this command: 

```
docker run --name kavita -p 5000:5000 \
-v /your/manga/directory:/manga \
-v ./data/temp:/kavita/temp \
-v ./data/cache:/kavita/cache \
-v ./data:/kavita/data \
-v ./data/logs:/kavita/logs \
--restart unless-stopped \
-d kizaing/kavita:latest
```

You can also run it via the docker-compose file:

```
version: '3.9'
services:
    kavita:
        image: kizaing/kavita:latest
        volumes:
            - ./manga:/manga
            - ./data/temp:/kavita/temp
            - ./data/cache:/kavita/cache
            - ./data:/kavita/data
            - ./data/logs:/kavita/logs
        ports:
            - "5000:5000"
        restart: unless-stopped
```

Note: Kavita is under heavy development and is being updated all the time, so the tag for current builds is :nightly. It has support for x64, arm and arm64. The :latest tag will be the latest stable release.

### Nightly Builds

The folder structure for nightly has now changed, so please run with the following volumes:

```
docker run --name kavita -p 5000:5000 \
-v /your/manga/directory:/manga \
-v ./data:/kavita/data \
--restart unless-stopped \
-d kizaing/kavita:nightly
```
or with docker-compose

```
version: '3.9'
services:
    kavita:
        image: kizaing/kavita:nightly
        volumes:
            - ./manga:/manga
            - ./data:/kavita/data
        ports:
            - "5000:5000"
        restart: unless-stopped
```

Once it's running head to http://localhost:5000 and set up your admin account. After you login, you can set your manga library folder as /manga
