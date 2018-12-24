FROM ubuntu:18.10

ARG VERSION
RUN echo $VERSION
ARG MIRROR=http://apache.claz.org/zookeeper
RUN echo $MIRROR

# Install Pre-Requisite Packages
RUN apt-get update
RUN apt-get install --force-yes --yes software-properties-common
RUN add-apt-repository ppa:openjdk-r/ppa
RUN apt-get update
RUN apt-get install --force-yes --yes openjdk-8-jdk vim

# Configure User Login
RUN echo 'root:drill' | chpasswd

# Install ZooKeeper
ADD $MIRROR/zookeeper-$VERSION/zookeeper-$VERSION.tar.gz /tmp/
RUN mkdir /opt/zookeeper
RUN tar -xzf /tmp/zookeeper-$VERSION.tar.gz --directory=/opt/zookeeper --strip-components 1
RUN rm -f /tmp/zookeeper-$VERSION.tar.gz

# Configure ZooKeeper
RUN printf "tickTime=2000\ndataDir=/var/lib/zookeeper\nclientPort=2181" > /opt/zookeeper/conf/zoo.cfg

# Start ZooKeeper
COPY start.sh /usr/bin/start.sh
ENTRYPOINT /usr/bin/start.sh