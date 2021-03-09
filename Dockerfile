FROM debian

RUN apt-get update
RUN apt-get install -y \
    vim \
    python3 \
    curl \
    make \
    unzip

RUN curl https://raw.githubusercontent.com/dsw7/VimTools/master/Makefile > Makefile
