FROM --platform=linux/amd64 redhat/ubi8

ARG USERNAME=mcdc
ARG USER_UID=1001170000
ARG USER_GID=1001170000

RUN yum install -y curl shadow-utils && \
    yum clean all

RUN groupadd --gid ${USER_GID} ${USERNAME} && \
    useradd --uid ${USER_UID} --gid ${USER_GID} --create-home --home-dir /home/${USERNAME} ${USERNAME}

RUN chown -R ${USERNAME}:${USERNAME} /home/${USERNAME}

WORKDIR /home/${USERNAME}

USER ${USERNAME}

RUN  mkdir -p ~/m2c && cd ~/m2c &&\
     curl -O "https://mcdc-release.storage.googleapis.com/$(curl -s https://mcdc-release.storage.googleapis.com/latest)/mcdc" &&\
     chmod +x mcdc &&\
     mkdir -p ~/m2c/.mcdc && touch ~/m2c/.mcdc/db &&
     export PATH=$PATH:/home/${USERNAME}/mcdc

ENV  MCDC_DB="~/m2c/.mcdc/db"

#ENTRYPOINT  ["~/m2c/mcdc"]

#CMD ["version"]


