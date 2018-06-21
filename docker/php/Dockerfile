FROM php:7-fpm
ARG uid
ARG gid

RUN groupadd -g ${gid} mlo
RUN useradd -mr -u ${uid} -g ${gid} appuser

ENV TZ=Europe/Zurich
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone

USER appuser
