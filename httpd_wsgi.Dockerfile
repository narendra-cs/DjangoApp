FROM httpd:2.4
LABEL author="Narendra Singh" \
      description="Apache-2.4 Webserver with django and python-3.4 on docker"

RUN mkdir /app

WORKDIR /app

RUN apt-get update \
    && apt-get install -y --no-install-recommends python3.4 python3-dev python3-pip libapache2-mod-wsgi-py3 libmysqlclient-dev ca-certificates gcc \
    && ln -s /usr/lib/apache2/modules/mod_wsgi.so* /usr/local/apache2/modules/ \
    && ln -s /usr/bin/python3 /usr/bin/python \
    && ln -s /usr/bin/pip3 /usr/bin/pip \
    && apt-get autoremove -y \
    && rm -rf /var/lib/apt/lists/* \
    && apt-get clean


RUN chown -R :www-data /app \
    && chmod -R 775 /app

ADD conf/httpd.conf /usr/local/apache2/conf
ADD conf/httpd_override.conf .
ARG DJANGO_PROJECT_NAME

RUN sed -i "s/\$DJANGO_PROJECT_NAME/$DJANGO_PROJECT_NAME/g" httpd_override.conf \
    && cat httpd_override.conf >> /usr/local/apache2/conf/httpd.conf

ENV DJANGO_PROJECT_NAME $DJANGO_PROJECT_NAME

ADD requirements.txt .
RUN pip install -r requirements.txt
