FROM ubuntu:18.10

ARG VERSION
RUN echo $VERSION

# Install Pre-Requisite Packages 
RUN apt-get update
RUN apt-get install --force-yes --yes software-properties-common openssh-server openssh-client ufw
RUN add-apt-repository ppa:openjdk-r/ppa
RUN apt-get update
RUN apt-get install --force-yes --yes openjdk-8-jdk vim wget

# Configure User Login
RUN echo 'root:drill' | chpasswd
RUN /usr/bin/ssh-keygen -t rsa -N "" -f /root/.ssh/id_rsa
RUN cp /root/.ssh/id_rsa.pub /root/.ssh/authorized_keys

# Install Drill
ADD http://apache.claz.org/drill/drill-$VERSION/apache-drill-$VERSION.tar.gz /tmp/
RUN mkdir /opt/drill
RUN tar -xzf /tmp/apache-drill-$VERSION.tar.gz --directory=/opt/drill --strip-components 1
RUN rm -f /tmp/apache-drill-$VERSION.tar.gz

# Test Drill
RUN echo "select * from sys.version;" > /tmp/version.sql
RUN /opt/drill/bin/sqlline -u jdbc:drill:zk=local --run=/tmp/version.sql

# Start Drill 
COPY start.sh /usr/bin/start.sh
ENTRYPOINT /usr/bin/start.sh