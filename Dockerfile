FROM choffmeister/jekyll

ADD . /epages-docs
WORKDIR /epages-docs

RUN bundle

CMD rake test
