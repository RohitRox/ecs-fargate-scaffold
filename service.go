package main

import "github.com/graniticio/granitic-yaml"
import "./bindings"  //Change to a non-relative path if you want to use 'go install'

func main() {
	granitic_yaml.StartGraniticWithYaml(bindings.Components())
}
