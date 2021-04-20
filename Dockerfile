#This Dockerfile pulls the latest git commit and builds Kavita from source
FROM mcr.microsoft.com/dotnet/sdk:5.0-focal AS builder

MAINTAINER Chris P

ENV DEBIAN_FRONTEND=noninteractive

#Installs the needed required apps and then deletes the apt cache
RUN apt-get update \
  && apt-get install -y curl git \
  && rm -rf /var/lib/apt/lists/*

#Installs nodejs and npm
RUN curl -fsSL https://deb.nodesource.com/setup_14.x | bash - \
  && apt-get install -y nodejs \
  && rm -rf /var/lib/apt/lists/*

#Testing for building the app directly
RUN mkdir Projects \
  && cd Projects \
  && git clone https://github.com/Kareadita/Kavita.git \
  && git clone https://github.com/Kareadita/Kavita-webui.git \
  && cd Kavita \
  && sed -i 's+../kavita-webui/+../Kavita-webui/+g' build.sh \
  && sed -i 's+../kavita/+../Kavita/+g' build.sh \
  && chmod +x build.sh \
  && ./build.sh linux-x64

#Production image for amd64 build
FROM ubuntu:focal AS linux-x64

MAINTAINER Chris P

#Move the output files to where they need to be
COPY --from=builder /Projects/Kavita/_output/linux-x64/Kavita /kavita

#Installs program dependencies
RUN apt-get update \
  && apt-get install -y libicu-dev libssl1.1 pwgen \
  && rm -rf /var/lib/apt/lists/*

#Creates the manga storage directory
RUN mkdir /manga /kavita/data

RUN cp /kavita/appsettings.Development.json /kavita/appsettings.json \
  && sed -i 's/Data source=kavita.db/Data source=data\/kavita.db/g' /kavita/appsettings.json

COPY entrypoint.sh /entrypoint.sh

EXPOSE 5000

WORKDIR /kavita

ENTRYPOINT ["/bin/bash"]
CMD ["/entrypoint.sh"]
