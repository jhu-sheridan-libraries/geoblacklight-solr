FROM ubuntu:18.04

RUN apt-get update  -y 
RUN apt-get  install -y curl
RUN apt-get  install -y unzip
RUN apt-get  install -y wget
RUN apt-get  install -y tar
RUN apt-get  install -y git
RUN apt-get  install -y lsof
RUN apt-get  install -y openjdk-8-jdk
RUN apt-get install -y python-pip python-dev build-essential

ENV SOLR_VERSION 7.7.2
ENV SOLR solr-$SOLR_VERSION
ENV PATH="/opt/solr/bin:$PATH"

RUN wget http://archive.apache.org/dist/lucene/solr/$SOLR_VERSION/$SOLR.tgz 
RUN tar -C /opt --extract --file "$SOLR.tgz";
RUN mv /opt/$SOLR /opt/solr

RUN useradd --home-dir /opt/solr --comment "Solr Server" solr

##### configure solr logs #####
RUN mkdir -p /opt/solr/server/logs
RUN chown -R solr:solr /opt/solr/server/logs
RUN chown -R solr:solr /opt/solr/

##### load flask configs required for health check #####
RUN mkdir -p /flask
COPY app.py /flask
COPY requirements.txt /flask
RUN chown -R solr:solr /flask
RUN mkdir -p /start
COPY start.sh /start
RUN chown -R solr:solr /start

##### load geoblacklight configs #####
COPY blacklightcore /opt/blacklightcore
RUN chown -R solr:solr /opt/blacklightcore

##### load geoblacklight test data #####
COPY geojsontest/01d-01 /opt/data
RUN chown -R solr:solr /opt/data



USER solr
RUN ln -s /opt/blacklightcore /opt/solr/server/solr/blacklightcore

EXPOSE 8983 5000
WORKDIR /opt/solr

RUN pip install -r /flask/requirements.txt

RUN chmod +x /start/start.sh
CMD /start/start.sh
