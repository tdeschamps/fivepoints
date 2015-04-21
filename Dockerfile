FROM seapy/ruby:2.2.0

RUN apt-get update

# Install nodejs
RUN apt-get install -qq -y nodejs

# Intall software-properties-common for add-apt-repository
RUN apt-get install -qq -y software-properties-common

# Install Nginx.
RUN add-apt-repository -y ppa:nginx/stable
RUN apt-get update
RUN apt-get install -qq -y nginx
RUN echo "\ndaemon off;" >> /etc/nginx/nginx.conf
RUN chown -R www-data:www-data /var/lib/nginx

# Add default nginx config
ADD nginx-sites.conf /etc/nginx/sites-enabled/default

# Install foreman
RUN gem install foreman

# Install the latest postgresql lib for pg gem
RUN echo "deb http://apt.postgresql.org/pub/repos/apt/ trusty-pgdg main" > /etc/apt/sources.list.d/pgdg.list && \
    apt-get update && \
    DEBIAN_FRONTEND=noninteractive \
    apt-get install -y --force-yes libpq-dev
# Install paperclip dependencies
RUN apt-get install -qq -y  ImageMagick    

# Copy gemfile and bundle in temporary
WORKDIR /tmp
ADD Gemfile Gemfile
ADD Gemfile.lock Gemfile.lock
RUN bundle install -j 4

# Copy app and precompile assets
RUN mkdir /app
ADD . /app
WORKDIR /app
ENV RAILS_ENV production
RUN bundle exec rake assets:precompile

# Nginx
ADD nginx-sites.conf /etc/nginx/sites-enabled/default

EXPOSE 80
RUN echo 'env[RDS_HOSTNAME] = $RDS_HOSTNAME'
CMD bundle exec rake db:migrate && foreman start -f Procfile