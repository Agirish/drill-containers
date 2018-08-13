FROM centos:6.6

RUN yum install -y openssh-server openssh-clients wget curl tar which python epel-release ; yum clean all ; rm -rf /var/cache/yum

RUN yum install -y pssh sshpass vim clustershell git ; yum clean all ; rm -rf /var/cache/yum

RUN sed -i 's/^mirror/#mirror/g' /etc/yum.repos.d/epel.repo
RUN sed -i 's/^#base/base/g' /etc/yum.repos.d/epel.repo

RUN echo 'root:mapr' | chpasswd

RUN /usr/bin/ssh-keygen -t rsa -N "" -f /root/.ssh/id_rsa
RUN cp /root/.ssh/id_rsa.pub /root/.ssh/authorized_keys

RUN yum install -y java-1.8.0-openjdk-devel ; yum clean all ; rm -rf /var/cache/yum

RUN wget http://apache.claz.org/drill/drill-1.14.0/apache-drill-1.14.0.tar.gz 
RUN mkdir /opt/drill
RUN tar -xzf apache-drill-1.14.0.tar.gz --directory=/opt/drill --strip-components 1

RUN yum -y install redhat-lsb-core ; yum clean all ; rm -rf /var/cache/yum

RUN echo "select * from sys.version;" > /tmp/version.sql
RUN /opt/drill/bin/sqlline -u jdbc:drill:zk=local --run=/tmp/version.sql

RUN chkconfig iptables off

COPY init-script /usr/bin/init-script
ENTRYPOINT /usr/bin/init-script
