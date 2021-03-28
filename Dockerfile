FROM ubuntu:20.04

MAINTAINER Chris P

#Installs the needed required apps and then deletes the apt cache
RUN apt-get update \
  && apt-get install -y wget libicu-dev pwgen \
  && rm -rf /var/lib/apt/lists/*
  
#Downloads Kavita, unzips and moves the folders to where they need to be
RUN wget https://github.com/Kareadita/Kavita/releases/download/v0.3.6/kavita-v0.3.6-linux-x64.tar.gz \
    && tar -xzf kavita*.tar.gz \
    && mv Kavita/ /kavita/ \
    && rm kavita*.tar.gz \
    && chmod +x /kavita/Kavita

#Creates the manga storage directory
RUN mkdir /manga

RUN sed -i 's/Data source=kavita.db/Data source=data\/kavita.db/g' /kavita/appsettings.json
	
COPY entrypoint.sh /entrypoint.sh

EXPOSE 5000

WORKDIR /kavita

ENTRYPOINT ["/bin/bash"]
CMD ["/entrypoint.sh"]
