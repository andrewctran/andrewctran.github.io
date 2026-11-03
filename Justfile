[private]
default:
    @just --list

# Serve the site at http://localhost:3000, rebuilding and reloading on save.
dev:
    bin/rheo watch . --open --html

# Build the deployable site into build/html.
build:
    bash build.sh

# Build the PDF and EPUB into build/pdf and build/epub.
print:
    bin/rheo compile . --pdf --epub

# Remove build/.
clean:
    rm -rf build
