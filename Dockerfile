FROM debian

RUN apt-get update && \
apt-get install -y \
curl \
make \
python3 \
unzip \
vim

ENV PWD=/root/.vim/tests
WORKDIR $PWD

CMD python3 run_tests.py
