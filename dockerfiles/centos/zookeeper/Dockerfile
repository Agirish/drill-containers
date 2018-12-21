FROM centos:7

ARG VERSION

RUN yum install -y openssh-server openssh-clients wget curl tar which python epel-release

RUN yum install -y pssh sshpass vim clustershell git

RUN sed -i 's/^mirror/#mirror/g' /etc/yum.repos.d/epel.repo
RUN sed -i 's/^#base/base/g' /etc/yum.repos.d/epel.repo

RUN echo 'root:drill' | chpasswd

RUN /usr/bin/ssh-keygen -t rsa -N "" -f /root/.ssh/id_rsa
RUN cp /root/.ssh/id_rsa.pub /root/.ssh/authorized_keys

RUN yum install -y java-1.8.0-openjdk-devel

RUN wget http://apache.claz.org/zookeeper/zookeeper-3.4.10/zookeeper-$VERSION.tar.gz > /dev/null 2>&1
RUN mkdir /opt/zookeeper
RUN tar -xzf zookeeper-$VERSION.tar.gz --directory=/opt/zookeeper --strip-components 1

RUN yum -y install redhat-lsb-core

RUN printf "tickTime=2000\ndataDir=/var/lib/zookeeper\nclientPort=2181" > /opt/zookeeper/conf/zoo.cfg

COPY init-script /usr/bin/init-script
ENTRYPOINT /usr/bin/init-script
