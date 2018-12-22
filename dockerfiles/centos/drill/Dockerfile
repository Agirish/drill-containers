FROM centos:7

ARG VERSION

# Install Pre-Requisite Packages
RUN yum install -y openssh-server openssh-clients epel-release; yum clean all ; rm -rf /var/cache/yum
RUN yum install -y java-1.8.0-openjdk-devel redhat-lsb-core vim wget which; yum clean all ; rm -rf /var/cache/yum
RUN sed -i 's/^mirror/#mirror/g' /etc/yum.repos.d/epel.repo
RUN sed -i 's/^#base/base/g' /etc/yum.repos.d/epel.repo

# Configure User Login
RUN echo 'root:drill' | chpasswd
RUN /usr/bin/ssh-keygen -t rsa -N "" -f /root/.ssh/id_rsa
RUN cp /root/.ssh/id_rsa.pub /root/.ssh/authorized_keys

# Install Drill
RUN wget http://apache.claz.org/drill/drill-$VERSION/apache-drill-$VERSION.tar.gz > /dev/null 2>&1
RUN mkdir /opt/drill
RUN tar -xzf apache-drill-$VERSION.tar.gz --directory=/opt/drill --strip-components 1

# Test Drill
RUN echo "select * from sys.version;" > /tmp/version.sql
RUN /opt/drill/bin/sqlline -u jdbc:drill:zk=local --run=/tmp/version.sql

# Start Drill
COPY init-script /usr/bin/start.sh
ENTRYPOINT /usr/bin/start.sh
