FROM debian

RUN apt-get update && \
    apt-get install -y \
    curl \
    make \
    python3 \
    unzip \
    vim

ENV PWD=/root \
GIT_BRANCH=master

WORKDIR $PWD

CMD curl https://raw.githubusercontent.com/dsw7/VimTools/${GIT_BRANCH}/Makefile > Makefile && \
    GIT_BRANCH=${GIT_BRANCH} make
