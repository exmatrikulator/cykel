FROM  andrejreznik/python-gdal
EXPOSE 8000

HEALTHCHECK CMD curl -sf http://localhost:8000/ 


# set environment variables
ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

WORKDIR /cykel

RUN apt update && apt install -y curl nginx && apt clean && rm -rf /var/lib/apt/*
ADD nginx/nginx.conf /etc/nginx/nginx.conf
COPY . /cykel/

RUN pip install -r requirements.txt
RUN pip install gunicorn

ADD docker-*.sh /usr/local/bin/
ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]