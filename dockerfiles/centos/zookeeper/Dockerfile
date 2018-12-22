FROM centos:7

ARG VERSION

# Install Pre-Requisite Packages
RUN yum install -y openssh-server openssh-clients epel-release java-1.8.0-openjdk-devel
RUN yum install -y sshpass vim git redhat-lsb-core wget which python
RUN sed -i 's/^mirror/#mirror/g' /etc/yum.repos.d/epel.repo
RUN sed -i 's/^#base/base/g' /etc/yum.repos.d/epel.repo

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
COPY init-script /usr/bin/start.sh
ENTRYPOINT /usr/bin/start.sh
