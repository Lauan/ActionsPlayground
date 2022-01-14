ARG NGINX_VERSION=1.21.5
FROM nginx:$NGINX_VERSION-alpine

LABEL maintainer="DigInsights | Tech"

RUN addgroup nonroot && adduser -S -G nonroot nonroot

RUN rm /etc/nginx/conf.d/* && \
    rm -Rf /usr/share/nginx && \
    rm -Rf /etc/nginx/*.default && \
    mkdir -p /app

ADD nginx/ /etc/nginx/

RUN chown -R nonroot:0 /var/cache/nginx && \
    chmod -R g+w /var/cache/nginx && \
    chown -R nonroot:nonroot /app

WORKDIR /app

EXPOSE 8080

USER nonroot

CMD ["nginx", "-g", "daemon off;"]