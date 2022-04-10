FROM ruby:2.7.5
RUN apt-get update -qq && apt-get install -y nodejs npm postgresql-client
RUN ["apt-get", "install", "-y", "vim"]
RUN mkdir /api
WORKDIR /api
COPY Gemfile /api/Gemfile
COPY . /api
# install yarn
RUN npm install --global yarn
# Add a script to be executed every time the container starts.
COPY entrypoint.sh /usr/bin/
RUN chmod +x /usr/bin/entrypoint.sh
ENTRYPOINT ["sh","entrypoint.sh"]
EXPOSE 4000
RUN bundler install
# Start the main process.
RUN rails webpacker:install
CMD ["rails", "server", "-b", "0.0.0.0"]

