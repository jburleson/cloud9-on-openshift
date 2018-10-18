FROM fedora:27
MAINTAINER jburleson <jburleson@astate.edu>

# Use a script to configure the container. This way we can
# split up the operations and do it all in a single layer.
ADD run_container.sh /tmp/
RUN /tmp/run_container.sh

VOLUME /workspace
WORKDIR /workspace

EXPOSE 8181

ENV USERNAME ""
ENV PASSWORD ""
ENV HOME "/home/user/"


ADD passwd_template /tmp/
ADD run_usercommand.sh /tmp/

USER 1000
CMD ["/tmp/run_usercommand.sh"]
