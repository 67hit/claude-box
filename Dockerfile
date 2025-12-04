FROM docker.io/node:current-alpine

RUN apk add --no-cache zsh
RUN npm config set os linux
RUN npm --os=linux install --omit=dev --no-audit --no-fund -g @anthropic-ai/claude-code

RUN apk cache clean
RUN rm -rf /usr/local/lib/node_modules/npm/man/

RUN adduser -D claude

ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ENV SHELL=/bin/zsh
ENV DISABLE_TELEMETRY=1
ENV DISABLE_AUTOUPDATER=1

CMD ["zsh"]
