FROM nginx:stable
ARG uid
ARG gid

RUN groupadd -g ${gid} mlo
RUN useradd -mr -u ${uid} -g ${gid} appuser

RUN touch /var/run/nginx.pid && \
  chown -R appuser:mlo /var/run/nginx.pid && \
  chown -R appuser:mlo /var/cache/nginx

COPY default.conf /etc/nginx/conf.d/default.conf

ENV TZ=Europe/Zurich
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

USER appuser

# CMD ["nginx", "-g", "daemon off;"]
