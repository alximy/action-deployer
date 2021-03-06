FROM php:8.0-cli-alpine

LABEL "repository" = "https://github.com/alximy/action-deployer"
LABEL "homepage" = "https://github.com/alximy/action-deployer"

LABEL "com.github.actions.name"="Action - Deployer"
LABEL "com.github.actions.description"="Use your Deployer script with your github action workflow."
LABEL "com.github.actions.icon"="server"
LABEL "com.github.actions.color"="blue"

ENV DEPLOYER_VERSION=7.0.0-beta.24

RUN apk update --no-cache \
    && apk add --no-cache \
    bash \
    openssh-client \
    rsync

# Change default shell to bash (needed for conveniently adding an ssh key)
RUN sed -i -e "s/bin\/ash/bin\/bash/" /etc/passwd

RUN curl -L https://deployer.org/releases/v$DEPLOYER_VERSION/deployer.phar > /usr/local/bin/deployer \
    && chmod +x /usr/local/bin/deployer

COPY entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]