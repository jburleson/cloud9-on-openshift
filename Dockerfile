FROM fedora:27
MAINTAINER jburleson <jburleson@astate.edu>

# Use a script to configure the container. This way we can
# split up the operations and do it all in a single layer.
ADD run_container.sh /tmp/
RUN /tmp/run_container.sh

VOLUME /workspace
WORKDIR /workspace

EXPOSE 8080

ENV USERNAME ""
ENV PASSWORD ""
ENV HOME "/home/user/"


ADD passwd_template /tmp/
ADD run_usercommand.sh /tmp/

USER 1000
CMD ["/tmp/run_usercommand.sh"]

# Labels for Kubernetes, OpenShift and Atomic
LABEL io.k8s.description="A powerful IDE for the cloud under your control! C9 SDK based on CentOS, Fedora or Ubuntu" \
      io.k8s.display-name="Cloud9 IDE" \
      io.openshift.expose-services="8080:http" \
      io.openshift.tags="ide,development" \
      io.projectatomic.nulecule.environment.optional="USERNAME, PASSWORD" \
      io.projectatomic.nulecule.volume.data="/workspace,1Gi"
