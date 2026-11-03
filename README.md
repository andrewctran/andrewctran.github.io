# drewtran.com

The personal site of Andrew Tran, published at [drewtran.com](https://drewtran.com).

The site is written in [Typst](https://typst.app) and compiled by [Rheo](https://rheo.ohrg.org), a static site engine, with [Rookery](https://rookery.ohrg.org) loaded for posts. GitHub Actions builds the site and deploys it to GitHub Pages on every push to `master`.

## Quick start

You need `bash`, `curl` and `unzip` on macOS or Linux, plus [`just`](https://github.com/casey/just), a command runner. Install it with `brew install just`, or, where Homebrew has no prebuilt package and would compile it from source (as on Intel Macs), with the official installer: `curl --proto '=https' --tlsv1.2 -sSf https://just.systems/install.sh | bash -s -- --to ~/.local/bin`. You don't need to install Rheo: `bin/rheo` downloads the version pinned in `rheo.toml` into `.rheo-binary/` the first time it runs.

```sh
just dev
```

This compiles the site, serves it at http://localhost:3000, and opens it in your browser. Saving any file under `content/` or `style.css` rebuilds the site and reloads the page. Stop the server with Ctrl+C.

## Commands

| Command | What it does |
| --- | --- |
| `just dev` | Serves the site at http://localhost:3000 with live reload. |
| `just build` | Builds the deployable site into `build/html`, the same way CI does. |
| `just print` | Builds the PDF and EPUB editions into `build/pdf` and `build/epub`. |
| `just clean` | Deletes `build/`. |

Running `just` on its own lists these recipes, which are defined in `Justfile`. CI doesn't use `just`: the deploy workflow calls `build.sh` directly.

Run `bin/rheo` directly for anything else; it passes its arguments to Rheo, for example `bin/rheo --version`.

## Project layout

```
content/
  index.typ            homepage, published as /index.html
  design.typ           style guide, published as /design.html (linked from nowhere)
  _lib/
    prelude.typ        spliced into the top of every page
    template.typ       header, footer, page titles and the Rookery theme
    components.typ     page-columns, notice, side-box, entity
style.css              every style on the site
rheo.toml              Rheo settings: content directory, stylesheet, PDF/EPUB spines, packages
Justfile               the dev, build, print and clean recipes
bin/rheo               runs the pinned Rheo, downloading it on first use
build.sh               the production build used by CI and `just build`
CNAME                  the custom domain, copied into the build for GitHub Pages
.github/workflows/     the deploy workflow
```

## How a page is built

Every `.typ` file in `content/` outside `_lib/` becomes a page, so `content/notes.typ` is published at `/notes.html`. Rheo splices `content/_lib/prelude.typ` into the top of each one. The prelude imports the components and Rookery's `idea`, `window`, `outline` and `footnote`, and wraps the page in `template`. So a page can call any component without importing it, and gets the header and footer automatically.

A page sets its own title on its first line:

```typst
#set document(title: "Andrew Tran - Notes")
```

`template.typ` emits the header, the page and the footer as siblings of `<body>`, not inside a wrapper element. Typst refuses `#set document` inside a container, so `body` itself is styled as the page column.

Link to another page by its label, which is the file name without `.typ`. Rheo turns `#link(label("index"))[Home]` into a link to `index.html`.

## Design system

Live examples of everything below are at `/design.html` (http://localhost:3000/design.html during `just dev`).

**Type.** Every piece of text, titles and headings included, is `sans-serif` at 14px with a 1.4em line height. Hierarchy comes only from bold. Paragraphs after the first in a container get 1em of space above them.

**Color.**

| Token | Value | Used for |
| --- | --- | --- |
| Ink | `#000` | text |
| Paper | `#fff` | background |
| Muted | `#666` | secondary text, Rookery names and dates |
| Link | `blue` | every link, underlined on hover |
| Side box | `lavender` | `side-box` fill |
| Notice box | `#f0f0f0` | `notice` fill |
| Rule | `#ccc` | the line under the header |
| Box border | `#aaa` | box outlines |

**Lines and spacing.** All lines are 1px. Boxes are padded 8px 14px, and a box heading after the first gets 8px above it. The page column is 960px wide and splits 1.55:1 into a main and a side column with a 26px gap. Side boxes are 14px apart. Below 700px the page becomes one column with the side column first.

The tokens are CSS custom properties at the top of `style.css`. The Rookery theme in `template.typ` repeats the colors, line width, label font and label size, so Rookery's ideas and windows match the rest of the site. The end of `style.css` also forces Rookery's text to the single 14px size, because Rookery's own stylesheet loads after ours and shrinks labels and tags.

## Components

The components live in `content/_lib/components.typ`. In HTML each one emits the classes styled in `style.css`. In the PDF and EPUB it renders as an equivalent filled box or plain block instead.

```typst
// Two columns: writing on the left, information on the right.
#page-columns(
  notice("Nothing published yet.")[...],
  side-box("About the author")[...],
)

// A gray box for a short message, such as an empty state.
#notice("Title")[
  First line.

  Second line.
]

// A lavender box of information.
#side-box("Education")[
  #entity(role: "2020")[M.A. East Asian Studies, Duke University]
]

// One item in a side box, with an optional parenthetical note.
#entity(role: "current")[Ph.D. Comparative Literature]
```

To add a component, define it in `components.typ` with a `context if target() == "html"` branch and a fallback for other outputs. Export it through the import line in `prelude.typ`, style its classes in `style.css`, and add a live example to `content/design.typ`.

## Posts

There are no posts yet. The homepage shows a `notice` in the main column where the list of posts will go. Rookery is already loaded and themed for writing them; see the [Rookery documentation](https://rookery.ohrg.org) for how ideas and windows work. A comment in `site-header` in `template.typ` marks where `@rookery/search`'s search modal goes once there is something to search.

## PDF and EPUB

`just print` compiles every page in the spine into one PDF and one EPUB titled "Andrew Tran". The style guide is left out through the `exclude` lists under `[pdf.spine]` and `[epub.spine]` in `rheo.toml`.

These format-level lists replace the top-level `[spine] exclude` rather than adding to it. That's why each repeats `_lib/**`: without it the PDF build pulls in the helper files and fails. If you add a page that shouldn't be printed, add it to both lists.

## Deployment

`.github/workflows/deploy.yml` runs on every push to `master`, and can also be started by hand from the Actions tab. It restores `.rheo-binary/` from cache, runs `bash build.sh`, and publishes `build/html` to GitHub Pages. The repository's Pages source must stay set to "GitHub Actions".

`build.sh` deletes `build/html` before compiling, because Rheo never removes files it didn't write, and a deleted page or asset would otherwise linger. Rheo publishes only the pages, the one stylesheet named in `rheo.toml` and its package assets. Anything else the site needs has to be copied in by `build.sh`, as `CNAME` is.

## Upgrading Rheo

Change `version` in `rheo.toml`. `bin/rheo` downloads the new release on its next run, and CI picks it up because its cache key is a hash of `rheo.toml`.
