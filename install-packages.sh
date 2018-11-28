# install the required packages
echo "cloning granitic"
git clone -b dev-1.3.0 --single-branch https://github.com/graniticio/granitic $GOPATH/src/github.com/graniticio/granitic
echo "fetching granitic"
go install github.com/graniticio/granitic

echo "fetching aws"
go get github.com/aws/aws-sdk-go/aws
echo "fetching satori"
go get github.com/satori/go.uuid
echo "fetching granitic yaml"
go get github.com/graniticio/granitic-yaml
echo "installing granitic grnc-yaml-bind"
go install github.com/graniticio/granitic-yaml/cmd/grnc-yaml-bind
echo "installing granitic grnc-yaml-project"
go install github.com/graniticio/granitic-yaml/cmd/grnc-yaml-project
echo "installing granitic grnc-ctl"
go install github.com/graniticio/granitic/cmd/grnc-ctl
