FROM node:14.7.0-alpine

WORKDIR /app
ENV PATH /app/node_modules/.bin:$PATH

# install and cache app dependencies
COPY package.json /app/package.json

RUN set -x \
  && apk update \
  && apk upgrade \
	&& yarn

COPY . ./

EXPOSE 3000

CMD ["yarn", "start"]
