FROM ubuntu:latest

ENV TZ UTC
ENV DEBIAN_FRONTEND noninteractive
ENV PATH /usr/local/app/.local/bin:$PATH
MAINTAINER Piratkin piratkin@tut.by

RUN apt-get update --yes && \
apt-get -y install \
sudo \
dialog \
apt-utils \
python3-dev \
python3-pip

RUN pip3 install --upgrade pip
RUN useradd -m -d /usr/local/app -g users -G daemon,adm,staff user 

USER user
WORKDIR /usr/local/app

COPY --chown=user:users . /usr/local/app
RUN pip3 install -r requirements.txt --user

EXPOSE 5000
ENTRYPOINT [ "python3" ]
CMD [ "app.py" ]
