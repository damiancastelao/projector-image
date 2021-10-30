#
# Install project-server (pj) to debian image
# https://github.com/JetBrains/projector-installer
#
# use: 
#
# When container start, attach a shell and 
# $ ~/.local/bin/projector run

# image to install pj
ARG IMAGE
FROM ${IMAGE} AS imageIde

# expose the port of pj server
EXPOSE 9999

# prepare tools:
RUN apt update && \
    apt install -y \
    python3 python3-pip python3-cryptography \
    less libxext6 libxrender1 libxtst6 libfreetype6 libxi6 
RUN python3 -m pip install -U pip 

# TODO 
# change to user that execute pj and add PATH to user profile ${HOME}/.local/bin)
# user that you want to execute pj
# ARG USER=root
# user's home and dir to install pj
# ARG HOME=/root
# Warning! in some image this change it's a problem
# USER ${USER}
# WORKDIR ${HOME}

# install pj-server
RUN pip3 install projector-installer --user

# Prevents projector install from asking for the license acceptance
RUN mkdir -p ~/.projector/configs  
# install IDE
# for IDE_NAME use 'projector ide find' to see names available
ARG IDE_NAME="IntelliJ IDEA Community Edition 2021.2.3"
RUN eval "~/.local/bin/projector autoinstall --config-name miconfig --ide-name '${IDE_NAME}'"
