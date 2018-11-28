FROM amazonlinux:2

RUN yum install git -y
RUN amazon-linux-extras install golang1.9

ENV GOPATH=/go
ENV GRANITIC_HOME=$GOPATH/src/github.com/graniticio/granitic
ENV WORKSPACE=$GOPATH/src/service

WORKDIR $WORKSPACE

ADD ./install-packages.sh .
RUN ./install-packages.sh

ADD . $WORKSPACE

ENV PATH=$PATH:$GOPATH/bin

WORKDIR $WORKSPACE
ADD . $WORKSPACE

RUN grnc-yaml-bind && go build service.go

FROM amazonlinux:2

RUN mkdir -p /var/app

WORKDIR /var/app

COPY --from=0 /go/src/service .

EXPOSE 3000

RUN ln -s /dev/stdout access.log

HEALTHCHECK --interval=10s --timeout=4s --retries=3 CMD curl --fail http://localhost:3000/service-status || exit 1

CMD ["./service"]
