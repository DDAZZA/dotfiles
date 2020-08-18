if ! command -v aws &> /dev/null
then
  # echo "creating docker function for 'aws'"
  function aws {
    docker run --rm -i -v ~/.aws:/root/.aws -v `pwd`:/aws amazon/aws-cli $*
  }
  export -f aws
fi


# function gorun {
#   docker run --rm -it \
#     -P -p 8080:8080 \
#     -e GOBIN=/go/bin \
#     -v `pwd`:/go golang \
#     go $*
# }


# function rust {
#   docker run --rm --user "$(id -u)":"$(id -g)" -v "$PWD":/usr/src/myapp -w /usr/src/myapp rust:1.23.0 cargo build --release
# }
