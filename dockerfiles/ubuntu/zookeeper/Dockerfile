FROM ubuntu:18.10

ARG VERSION

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

# Install ZooKeeper
RUN wget http://apache.claz.org/zookeeper/zookeeper-3.4.10/zookeeper-$VERSION.tar.gz > /dev/null 2>&1
RUN mkdir /opt/zookeeper
RUN tar -xzf zookeeper-$VERSION.tar.gz --directory=/opt/zookeeper --strip-components 1

# Configure ZooKeeper
RUN printf "tickTime=2000\ndataDir=/var/lib/zookeeper\nclientPort=2181" > /opt/zookeeper/conf/zoo.cfg

# Start ZooKeeper
COPY start.sh /usr/bin/start.sh
ENTRYPOINT /usr/bin/start.sh
