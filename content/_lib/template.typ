#import "@rookery/core:0.1.0": rookery

// Rookery's theme, set from the tokens in `style.css` so ideas and windows
// match the rest of the site once there are posts.
#let THEME = (
  link-color: "rgba(230, 230, 250, 0.8)",
  fold-color: "rgba(230, 230, 250, 0.4)",
  name-color: rgb("#666666"),
  date-color: rgb("#666666"),
  border-color: rgb("#aaaaaa"),
  rule-width: "1px",
  label-font: "sans-serif",
  label-size: "14px",
)

#let SITE = "Andrew Tran"
#let EMAIL = "hi@drewtran.com"

#let site-header() = html.elem("header", attrs: (class: "site-header"))[
  #html.elem("h1", attrs: (class: "site-title"), link(label("index"))[#SITE])
  // Once there are posts, `@rookery/search`'s
  // `#search-modal(placeholder: "Search posts")` goes beside Subscribe.
  #html.elem("span", attrs: (class: "site-subscribe"))[
    #link("mailto:" + EMAIL + "?subject=subscribe")[Subscribe]
  ]
]

#let site-footer() = html.elem("footer", attrs: (class: "site-footer"))[
  #html.elem("span", attrs: (class: "last-updated"))[
    Last updated #datetime.today().display("[year]-[month]-[day]")
  ]
  #html.elem("span", attrs: (class: "colophon"))[
    Built with #link("https://rheo.ohrg.org")[Rheo] and #link("https://rookery.ohrg.org")[Rookery]
  ]
]

// `doc` is not wrapped in an element: pages open on `#set document(..)`,
// which Typst refuses inside a container.
#let chrome(doc) = {
  context if target() == "html" { site-header() }
  doc
  context if target() == "html" { site-footer() }
}

#let idea-page(id: none, note: (:), doc) = {
  let name = if note.len() == 0 {
    [Ideas]
  } else if note.at("title", default: none) != none {
    note.title
  } else {
    raw(id.split(":").last())
  }
  set document(title: [#SITE - #name])
  show: chrome
  doc
}

#let template(doc) = {
  show: rookery.with(theme: THEME, idea-page-template: idea-page)
  show: chrome
  doc
}
