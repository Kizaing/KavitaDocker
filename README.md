# What is Kavita?
Kavita is a free and open source web based Manga e-reader. 

It was developed by Kareadita and the source is [here](https://github.com/Kareadita/Kavita)

# How to use
Running your Kavita server in docker is super easy! You can run it with this command: 

`docker run --name kavita -p 5000:5000 -v /your/manga/directory:/manga -d kizaing/kavita:latest`

This command will run the container, but the database will not persist. It is encouraged to run the docker-compose file

`version: '3.9'
services:
    kavita:
        image: kizaing/kavita:latest
        volumes:
            - ./manga:/manga
            - ./data/temp:/kavita/temp
            - ./data/cache:/kavita/cache
            - ./data:/kavita/data
        ports:
            - "5000:5000"`

Once it's running head to http://localhost:5000 and set up your admin account. After you login, you can set your manga library folder as /manga

**This is a beta image, and isn't fully polished. Most things are working, but your data may not persist if the container updates.
Mostly everything is working, but the appsettings.json file will not persist upon creation of a new container, will be fixed soon.
