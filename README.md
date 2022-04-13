# README
## 環境構築
1. ローカルディレクトリに以下のファイルを用意する
    1. Dockerfile
        ```
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
        ```

    1. docker-compose.yml
        ```
        version: '3.9'
        services:
          db:
            image: mysql:8.0
            volumes:
              - db-volume:/var/lib/mysql
            environment:
              MYSQL_ROOT_PASSWORD: password
              MYSQL_DATABASE: root
            ports:
              - "5000:3306"
            platform: linux/x86_64 
          web:
            build: .
            command: bash -c "rm -f tmp/pids/server.pid && bundle exec rails s -p 3000 -b '0.0.0.0'"
            volumes:
              - .:/api
              - ~/.ssh/id_rsa:/.ssh/id_rsa
            ports:
              - "4000:3000"
            depends_on:
              - db
        volumes:
          db-volume:
            driver: local
        ```

    1. Gemfile
        ```
        source 'https://rubygems.org'
        gem 'rails', '~> 6.1.4'
        ```

    1. entrypoint.sh
        ```
        #!/bin/bash
        set -e

        # Remove a potentially pre-existing server.pid for Rails.
        rm -f /myapp/tmp/pids/server.pid

        # Then exec the container's main process (what's set as CMD in the Dockerfile).
        exec "$@"
        ```

    1. Gemfile.lock
        - 中身空で作成
1. 以下コマンドを実行しRailsプロジェクトを作成
    ```
    docker-compose run web rails new . --force --no-deps --database=mysql
    ```
1. 以下コマンドを実行しビルド
    ```
    docker-compose build 
    ```
1. 以下コマンドを実行しDB作成
    ```
    docker-compose run web rails db:create
    ```
