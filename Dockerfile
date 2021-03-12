FROM debian

RUN apt-get update && \
apt-get install -y \
curl \
make \
python3 \
unzip \
vim

# System defaults to root user
#RUN useradd -m qa
#USER qa

# All work will take place in qa home from this point on
#ENV PWD=/home/qa
#WORKDIR $PWD

RUN curl https://raw.githubusercontent.com/dsw7/VimTools/master/Makefile > Makefile

CMD ["make"]
