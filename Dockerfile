FROM ubuntu:20.04

MAINTAINER Chris P

#Installs the needed required apps and then deletes the apt cache
RUN apt-get update \
  && apt-get install -y wget libicu-dev pwgen \
  && rm -rf /var/lib/apt/lists/*
  
#Installs the dotnet sdk to build Kavita
#RUN wget https://packages.microsoft.com/config/ubuntu/20.04/packages-microsoft-prod.deb -O packages-microsoft-prod.deb \
#  && dpkg -i packages-microsoft-prod.deb \
#  && apt-get update \
#  && apt-get install -y apt-transport-https dotnet-sdk-5.0 npm \
#  && rm -rf /var/lib/apt/lists/*

#Downloads Kavita, unzips and moves the folders to where they need to be
RUN wget https://github.com/Kareadita/Kavita/releases/download/v0.3.5/kavita-v0.3.5-linux-x64.tar.gz \
    && tar -xzf kavita-v0.3.5-linux-x64.tar.gz \
    && mv Kavita/ /kavita/ \
    && rm kavita-v0.3.5-linux-x64.tar.gz \
    && chmod +x /kavita/Kavita
	
#Testing for building the app directly
#RUN git clone https://github.com/Kareadita/Kavita.git \
#  && mv Kavita/ kavita \
#  && git clone https://github.com/Kareadita/Kavita-webui.git \
#  && mv Kavita-webui/ kavita-webui \
#  && cd Kavita \
#  && chmod +x build.sh \
#  && ./build.sh

#After a successful build, cleanup extra space to shrink container size
#RUN apt-get purge -y dotnet-sdk-5.0 npm git

#Creates the manga storage directory
RUN mkdir /manga

RUN cp /kavita/appsettings.Development.json /kavita/appsettings.json \
  && sed -i 's/Data source=kavita.db/Data source=data\/kavita.db/g' /kavita/appsettings.json
	
COPY entrypoint.sh /entrypoint.sh

EXPOSE 5000

WORKDIR /kavita

ENTRYPOINT ["/bin/bash"]
CMD ["/entrypoint.sh"]
#CMD /kavita/Kavita
