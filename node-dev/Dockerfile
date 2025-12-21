FROM node:25.2

ARG APP_UID=1000
ARG APP_GID=1000

RUN groupmod -g "$APP_UID" node && usermod -u "$APP_UID" -g "$APP_GID" node

ENTRYPOINT ["npm"]
