FROM docker.io/node:current-alpine

RUN npm config set os linux
RUN apk add --no-cache zsh

CMD ["zsh"]
