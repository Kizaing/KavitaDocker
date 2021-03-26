FROM ubuntu:20.04

MAINTAINER Chris P

#Installs the needed required apps and then deletes the apt cache
RUN apt-get update \
  && apt-get install -y wget libicu-dev pwgen \
  && rm -rf /var/lib/apt/lists/*

#Downloads Kavita, unzips and moves the folders to where they need to be
RUN wget https://github.com/Kareadita/Kavita/releases/download/v0.3.1/kavita-linux-x64.tar.gz \
    && tar -xzf kavita-linux-x64.tar.gz \
    && mv Kavita/ /kavita/ \
    && rm kavita-linux-x64.tar.gz \
    && chmod +x /kavita/Kavita

#Creates the manga storage directory
RUN mkdir /manga

RUN cp /kavita/appsettings.Development.json /kavita/appsettings.json

#Generates a random token and sets it in the appsettings.json
#RUN export TOKEN_KEY="$(pwgen -s 16 1)" \
#  && sed -i "s/super secret unguessable key/${TOKEN_KEY}/g" /kavita/appsettings.json
	
COPY entrypoint.sh /entrypoint.sh

EXPOSE 5000

WORKDIR /kavita

ENTRYPOINT ["/bin/bash"]
CMD ["/entrypoint.sh"]
#CMD /kavita/Kavita
