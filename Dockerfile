FROM ruby:2.4.2

RUN apt-get update
RUN apt install -y locales \
    && apt-get install -y \
    cmake \
    node \
    python-pygments \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/

RUN gem install \
    bundler \
    jekyll \
    jekyll-redirect-from \
    kramdown \
    rdiscount \
    rouge

RUN gem install nokogiri -v '1.8.2'
RUN gem install therubyracer -v '0.12.3'
RUN gem install ffi -v '1.9.23' --source 'https://rubygems.org/'
RUN gem install eventmachine -v '1.2.5'

EXPOSE 4000

WORKDIR /src

COPY build.sh .

RUN dpkg-reconfigure locales && \
    locale-gen C.UTF-8 && \
    /usr/sbin/update-locale LANG=C.UTF-8

# Install needed default locale for Makefly
RUN echo 'en_US.UTF-8 UTF-8' >> /etc/locale.gen && \
    locale-gen

# Set default locale for the environment
ENV LC_ALL C.UTF-8
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US.UTF-8

CMD jekyll serve
