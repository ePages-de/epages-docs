# Use official Ruby image
FROM ruby:2.1

####################
# Configure basics #
####################

# Configure timezone server
ENV TZ="Europe/Berlin"
RUN echo "${TZ}" | tee /etc/timezone && \
    dpkg-reconfigure --frontend noninteractive tzdata

# Install missing packages
RUN echo "deb http://ftp.de.debian.org/debian jessie main" >> /etc/apt/sources.list && \
    apt-get update && apt-get install --yes \
    locales

# Set server locale
ENV LANG="en_US.UTF-8" \
    LANGUAGE="en_US.UTF-8"
RUN locale-gen en_US.UTF-8 && \
    localedef en_US.UTF-8 -i en_US -fUTF-8

#################################
# Setup epages-docs environment #
#################################

ENV EPAGES_DOCS="/usr/src/epages-docs"

# Create the workdir for epages-docs
RUN mkdir -p ${EPAGES_DOCS}
WORKDIR ${EPAGES_DOCS}

# Install gems
COPY Gemfile Gemfile.lock ${EPAGES_DOCS}/
RUN bundle install

# Copy repo to enable running without the mounted volume.
COPY . ${EPAGES_DOCS}

# Set mountpoint
VOLUME ${EPAGES_DOCS}

# Open port
EXPOSE 4000

# Copy our entrypoint script
COPY _docker/ruby/docker-entrypoint.sh /
RUN chmod +x /docker-entrypoint.sh
ENTRYPOINT ["/docker-entrypoint.sh"]

# Set default command
CMD ["rake"]
