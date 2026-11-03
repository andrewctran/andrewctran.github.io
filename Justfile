default:
    @echo "drewtran.com: 'just watch' to live-rebuild, 'just build' for a one-shot"

watch:
    rheo watch . --open --html

build:
    bash build.sh
