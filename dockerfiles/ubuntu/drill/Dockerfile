# Specify the Operating System Image
FROM ubuntu:18.10

ARG VERSION

RUN echo 'root:drill' | chpasswd

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

# Install Drill
RUN wget http://apache.claz.org/drill/drill-$VERSION/apache-drill-$VERSION.tar.gz
RUN mkdir /opt/drill
RUN tar -xzf apache-drill-$VERSION.tar.gz --directory=/opt/drill --strip-components 1

# Test Drill
RUN echo "select * from sys.version;" > /tmp/version.sql
RUN /opt/drill/bin/sqlline -u jdbc:drill:zk=local --run=/tmp/version.sql

# Continue with Init Script
COPY init-script /usr/bin/init-script
ENTRYPOINT /usr/bin/init-script
