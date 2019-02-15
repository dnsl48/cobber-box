FROM php:5.6-cli-stretch as base

RUN apt-get update -y \
 && apt-get install -y \
    unzip wget \
    libfreetype6-dev libjpeg62-turbo-dev libpng-dev libmemcached-dev \
    zlib1g-dev libicu-dev libpq-dev libtidy-dev libzip-dev \
    libldap2-dev libmcrypt-dev \
    libmagickwand-dev  # for the image magick extension (imagick)

RUN docker-php-source extract \
 && docker-php-ext-install iconv \
 && docker-php-ext-configure gd --with-freetype-dir=/usr/include/ --with-jpeg-dir=/usr/include/ && docker-php-ext-install gd \
 && docker-php-ext-install intl \
 && docker-php-ext-install zip \
 && docker-php-ext-install mysqli \
 && docker-php-ext-install pgsql \
 && docker-php-ext-install tidy \
 && docker-php-ext-install exif \
 && docker-php-ext-install bcmath \
 && docker-php-ext-install bz2 \
 && docker-php-ext-configure ldap --with-libdir=lib/x86_64-linux-gnu/ && docker-php-ext-install ldap \
 && docker-php-ext-install mcrypt \
 && yes '' | pecl install memcached-2.2.0 && docker-php-ext-enable memcached \
 && yes '' | pecl install redis && docker-php-ext-enable redis \
 && yes '' | pecl install imagick && docker-php-ext-enable imagick \
 && docker-php-source delete

RUN php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');" \
 && php -r "if (hash_file('sha384', 'composer-setup.php') === '$(wget -q -O - https://composer.github.io/installer.sig)') { echo 'Installer verified'; } else { echo 'Installer corrupt'; unlink('composer-setup.php'); } echo PHP_EOL;" \
 && php composer-setup.php --install-dir=/bin --filename=composer \
 && php -r "unlink('composer-setup.php');"

RUN groupadd -f -g 1000 vagrant \
 && useradd -g 1000 -d /home/vagrant -m -u 1000 vagrant


FROM base as dev

RUN apt-get update -y \
 && apt-get install -y git httpie

USER vagrant

RUN mkdir -p /home/vagrant/.composer/cache/vcs/


FROM dev as debug

USER root

RUN docker-php-source extract \
 && yes '' | pecl install xdebug-2.5.5 && docker-php-ext-enable xdebug \
 && docker-php-source delete

USER vagrant


FROM dev as cow

USER root
RUN apt-get update -y \
 && apt-get install -y python-pip \
 && pip install transifex-client awscli \
 && apt-get install -y ruby \
 && gem install yamlclean

USER vagrant
RUN composer -vvv global require silverstripe/cow:dev-master \
 && composer -vvv global require composer/satis ^1

USER root
RUN ln -s /home/vagrant/.composer/vendor/bin/cow /usr/bin/. \
 && ln -s /home/vagrant/.composer/vendor/bin/satis /usr/bin/.

USER vagrant
