include ./make/config.mk

install:
	@if [ ! -d pact/bin ]; then\
		echo "--- Installing Pact CLI dependencies";\
		curl -fsSL https://raw.githubusercontent.com/pact-foundation/pact-ruby-standalone/master/install.sh | bash;\
    fi

install_pact_ffi_lib:
	go install github.com/pact-foundation/pact-go/v2@2.x.x
	sudo mkdir -p /usr/local/lib/
	sudo $$HOME/go/bin/pact-go -l DEBUG install

run-consumer:
	@go run consumer/client/cmd/main.go

run-provider:
	@go run provider/cmd/usersvc/main.go

unit:
	@echo "--- 🔨Running Unit tests "
	go test -tags=unit -count=1 github.com/pact-foundation/pact-workshop-go/consumer/client -run 'TestClientUnit' -v

consumer: export PACT_TEST := true
consumer: install
	@echo "--- 🔨Running Consumer Pact tests "
	go test -tags=integration -count=1 github.com/pact-foundation/pact-workshop-go/consumer/client -run 'TestClientPact' -v

provider: export PACT_TEST := true
provider: install
	@echo "--- 🔨Running Provider Pact tests "
	go test -count=1 -tags=integration github.com/pact-foundation/pact-workshop-go/provider -run "TestPactProvider" -v

.PHONY: install unit consumer provider run-provider run-consumer

.PHONY: build-docker-pact
build-docker-pact:
	@echo "--- Building Docker image"
	docker build -t pact-workshop-go .

.PHONY: run-docker-pact
run-docker-pact: build-docker-pact
	@echo "--- Running Docker image"
	docker run --rm -it pact-workshop-go