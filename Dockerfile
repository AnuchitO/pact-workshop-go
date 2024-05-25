FROM golang:1.20 as builder

WORKDIR /app
COPY . .

# install CLI tools
RUN go install github.com/pact-foundation/pact-go/v2@v2.0.2
# download and install the required libraries. The pact-go will be installed into $GOPATH/bin, which is $HOME/go/bin by default.
RUN pact-go -l DEBUG install

CMD bash