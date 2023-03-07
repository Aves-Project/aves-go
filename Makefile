# This Makefile is meant to be used by people that do not usually work
# with Go source code. If you know what GOPATH is then you probably
# don't need to bother with make.

.PHONY: geth android ios evm all test clean
GOOS=windows 
GOARCH=amd64
GOBIN = ./build/bin
GO ?= latest
GORUN = CGO_ENABLED=0 env GO111MODULE=on go run 
CGO_ENABLED=0
aves:
	$(GORUN) build/ci.go install ./cmd/geth
	CGO_ENABLED=0
	mv $(GOBIN)/geth $(GOBIN)/aves
	@echo "Done building."
	@echo "Run \"$(GOBIN)/aves\" to launch aves."
aves_win:
	env GOOS=windows GOARCH=amd64 GO111MODULE=on go build -o $(GOBIN)/aves.exe ./cmd/geth
	@echo "Done building."
	@echo "Run \"$(GOBIN)/aves.exe\" to launch aves."
	
aves_larm:
	env GOOS=linux GOARCH=arm GO111MODULE=on go build -o $(GOBIN)/aves-arm ./cmd/geth
	@echo "Done building."
	@echo "Run \"$(GOBIN)/aves-arm\" to launch aves."
all:
	$(GORUN) build/ci.go install

android:
	$(GORUN) build/ci.go aar --local

	@echo "Done building."
	@echo "Import \"$(GOBIN)/geth.aar\" to use the library."
	@echo "Import \"$(GOBIN)/geth-sources.jar\" to add javadocs"
	@echo "For more info see https://stackoverflow.com/questions/20994336/android-studio-how-to-attach-javadoc"

ios:
	$(GORUN) build/ci.go xcode --local
	@echo "Done building."
	@echo "Import \"$(GOBIN)/Geth.framework\" to use the library."

test: all
	$(GORUN) build/ci.go test

lint: ## Run linters.
	$(GORUN) build/ci.go lint

clean:
	env GO111MODULE=on go clean -cache
	rm -fr build/_workspace/pkg/ $(GOBIN)/*

# The devtools target installs tools required for 'go generate'.
# You need to put $GOBIN (or $GOPATH/bin) in your PATH to use 'go generate'.

devtools:
	env GOBIN= go install golang.org/x/tools/cmd/stringer@latest
	env GOBIN= go install github.com/fjl/gencodec@latest
	env GOBIN= go install github.com/golang/protobuf/protoc-gen-go@latest
	env GOBIN= go install ./cmd/abigen
	@type "solc" 2> /dev/null || echo 'Please install solc'
	@type "protoc" 2> /dev/null || echo 'Please install protoc'
