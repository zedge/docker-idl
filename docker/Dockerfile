FROM node:7

RUN npm install idl --global

# Make a dumb .irlrc and .git so simple commands like 'idl version'
# have a chance to run.
RUN mkdir /dummy
COPY .idlrc /dummy/
COPY dot.git /dummy/.git
WORKDIR /dummy
COPY entrypoint.sh /sbin/entrypoint.sh

ENTRYPOINT ["/sbin/entrypoint.sh"]
CMD []
