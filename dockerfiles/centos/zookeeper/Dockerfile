FROM centos:7

ARG VERSION_ARG
ENV VERSION_ENV=$VERSION_ARG
RUN echo $VERSION_ENV

# Install Pre-Requisite Packages
RUN yum install -y openssh-server openssh-clients epel-release; yum clean all ; rm -rf /var/cache/yum
RUN yum install -y java-1.8.0-openjdk-devel redhat-lsb-core vim wget; yum clean all ; rm -rf /var/cache/yum
RUN sed -i 's/^mirror/#mirror/g' /etc/yum.repos.d/epel.repo
RUN sed -i 's/^#base/base/g' /etc/yum.repos.d/epel.repo

# Configure User Login
RUN echo 'root:drill' | chpasswd
RUN /usr/bin/ssh-keygen -t rsa -N "" -f /root/.ssh/id_rsa
RUN cp /root/.ssh/id_rsa.pub /root/.ssh/authorized_keys

# Install ZooKeeper
RUN wget http://apache.claz.org/zookeeper/zookeeper-$VERSION_ENV/zookeeper-$VERSION_ENV.tar.gz
RUN mkdir /opt/zookeeper
RUN tar -xzf zookeeper-$VERSION_ENV.tar.gz --directory=/opt/zookeeper --strip-components 1

# Configure ZooKeeper
RUN printf "tickTime=2000\ndataDir=/var/lib/zookeeper\nclientPort=2181" > /opt/zookeeper/conf/zoo.cfg

# Start ZooKeeper
COPY start.sh /usr/bin/start.sh
ENTRYPOINT /usr/bin/start.sh
