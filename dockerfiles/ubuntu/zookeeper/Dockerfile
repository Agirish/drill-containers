FROM ubuntu:18.04

ARG VERSION

RUN echo 'root:mapr' | chpasswd

# Update Sources and install some basic packages
RUN apt-get update
RUN apt-get install --force-yes --yes software-properties-common openssh-server openssh-client python ufw 
RUN apt-get install --force-yes --yes vim tar wget git screen pssh sshpass clustershell curl

RUN /usr/bin/ssh-keygen -t rsa -N "" -f /root/.ssh/id_rsa
RUN cp /root/.ssh/id_rsa.pub /root/.ssh/authorized_keys

# Install Java
RUN add-apt-repository ppa:openjdk-r/ppa
RUN apt-get update
RUN apt-get install --force-yes --yes openjdk-8-jdk

# Install Zookeeper
RUN wget http://apache.claz.org/zookeeper/zookeeper-3.4.10/zookeeper-$VERSION.tar.gz > /dev/null 2>&1
RUN mkdir /opt/zookeeper
RUN tar -xzf zookeeper-$VERSION.tar.gz --directory=/opt/zookeeper --strip-components 1

# Configure Zookeeper
RUN printf "tickTime=2000\ndataDir=/var/lib/zookeeper\nclientPort=2181" > /opt/zookeeper/conf/zoo.cfg

# Continue with Init Script
COPY init-script /usr/bin/init-script
ENTRYPOINT /usr/bin/init-script
