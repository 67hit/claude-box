FROM docker.io/node:23-alpine

RUN apk add --no-cache zsh curl jq python3 py3-pip

RUN npm config set os linux
RUN npm install --omit=dev --no-audit --no-fund -g @anthropic-ai/claude-code
RUN rm -rf /usr/local/lib/node_modules/npm/man/

RUN adduser -D -u 1001 claude

ENV PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin
ENV SHELL=/bin/zsh
ENV DISABLE_TELEMETRY=1
ENV DISABLE_AUTOUPDATER=1

CMD ["zsh"]
