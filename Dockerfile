FROM debian

RUN apt-get update \
apt-get install -y \
curl \
make \
python3 \
unzip \
vim

# System defaults to root user
RUN useradd -m qa
USER qa

# Running without -it does not set PWD
# The PWD env var is needed for running the Makefile
ENV PWD=/home/qa

# All work will take place in qa home from this point on
WORKDIR $PWD

# Will need to rebuild image every time Makefile is changed
RUN curl https://raw.githubusercontent.com/dsw7/VimTools/master/Makefile > Makefile

CMD make
