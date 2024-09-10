FROM node:current-alpine3.19

WORKDIR /usr/app

COPY ./src /usr/app

RUN npm install -g aws-cdk-local@2.18.0 aws-cdk@2.155.0
RUN npm install

CMD ["cdklocal", "bootstrap"]
