FROM centos:7
MAINTAINER Jason Ish <ish@unx.ca>

ENV DAQ_VERSION 2.0.6
ENV SNORT_VERSION 2.9.7.6

RUN yum -y install epel-release
RUN yum -y install \
 https://codemonkey.net/files/snort/daq-${DAQ_VERSION}-1.centos7.x86_64.rpm \
 https://codemonkey.net/files/snort/snort-${SNORT_VERSION}-1.centos7.x86_64.rpm

RUN ln -s /usr/lib64/snort-${SNORT_VERSION}_dynamicengine \
       /usr/local/lib/snort_dynamicengine && \
    ln -s /usr/lib64/snort-${SNORT_VERSION}_dynamicpreprocessor \
       /usr/local/lib/snort_dynamicpreprocessor

# Cleanup.
RUN yum clean all && \
    rm -rf /var/log/* || true \
    rm -rf /var/tmp/* \
    rm -rf /tmp/*

RUN /usr/sbin/snort -V
