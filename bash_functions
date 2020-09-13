if ! command -v aws &> /dev/null
then
  # echo "creating docker function for 'aws'"
  function aws {
    docker run --rm -i -v ~/.aws:/root/.aws -v `pwd`:/aws amazon/aws-cli $*
  }
  export -f aws
fi

if ! command -v pdflatex &> /dev/null
then
  function pdflatex {
    docker run --rm --volume "`pwd`:/data" --user `id -u`:`id -g` fbenz/pdflatex pdflatex -output-directory /data/ /data/$*
  }

  export -f pdflatex
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


if ! command -v jq &> /dev/null
then
  function jq {
    read input
    echo $input | docker run -i stedolan/jq $*
  }
  export -f jq
fi


function host_static_page {
  port=8080
  public_dir=$(pwd)
  #read -p "Enter port (default: $(8080))" input

  echo "Hosting '$public_dir' on http://localhost:$port"
  container_id=$(docker run -p $port:80 -v $(pwd):/usr/share/nginx/html:ro -d nginx)
  docker logs $container_id
}

function jekyll {
  export JEKYLL_VERSION=3.8
  docker run --rm \
    --volume="$PWD:/srv/jekyll" \
    -p 4000:4000 \
    -it jekyll/jekyll:$JEKYLL_VERSION \
    jekyll $*
}

function jekyll_builder {
  export JEKYLL_VERSION=3.8
  docker run --rm \
    --volume="$PWD:/srv/jekyll" \
    -it jekyll/builder:$JEKYLL_VERSION \
    jekyll build
  }


