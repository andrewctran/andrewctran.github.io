#set document(title: "Andrew Tran - Design")

// The style guide: every token and component in `style.css` and
// `components.typ`, rendered live. Published at /design.html, linked from nowhere.

#let section(title, body) = html.elem("section", attrs: (class: "guide-section"))[
  #html.elem("h2", title)
  #body
]

#let spec(body) = html.elem("div", body)

#let row(sample, body) = html.elem("div", attrs: (class: "guide-row"))[#sample#html.elem("span", body)]

#let swatch(value, name) = row(
  html.elem("span", attrs: (class: "guide-swatch", style: "background-color: " + value)),
  [#name: #raw(value)],
)

#let line-sample(value, name) = row(
  html.elem("span", attrs: (class: "guide-line", style: "border-top: 1px solid " + value)),
  [#name: 1px #raw(value)],
)

#let example(source, rendered) = [
  #html.elem("div", attrs: (class: "guide-example"), rendered)
  #html.elem("div", attrs: (class: "guide-code"), raw(block: true, source))
]

#section("Design")[
  The tokens and components drewtran.com is built from.
]

#section("Color")[
  #swatch("#000", "Ink")
  #swatch("#fff", "Paper")
  #swatch("#666", "Muted")
  #swatch("blue", "Link")
  #swatch("lavender", "Side box")
  #swatch("#f0f0f0", "Notice box")
]

#section("Type")[
  Every piece of text is #raw("sans-serif") at 14px with a line height of 1.4em,
  titles and headings included. Hierarchy comes from weight alone.

  The quick brown fox jumps over the lazy dog.

  *The quick brown fox jumps over the lazy dog.*

  Links are #link("https://drewtran.com")[blue], underlined on hover.
]

#section("Lines")[
  #line-sample("#ccc", "Rule")
  #line-sample("#aaa", "Box border")
]

#section("Spacing")[
  #spec[Box padding: 8px 14px]
  #spec[Box heading after the first: 8px above]
  #spec[Notice line: 4px above]
  #spec[Paragraph after the first: 1em above]
  #spec[Entity hanging indent: 12px]
  #spec[Column: 960px, split 1.55:1 with a 26px gap]
  #spec[Side boxes: 14px apart]
  #spec[Below 700px: one column, side column first]
]

#section("Notice")[
  #example(
    "#notice(\"Nothing published yet.\")[\n  Essays, reviews and notes will be listed here, newest first.\n]",
    notice("Nothing published yet.")[
      Essays, reviews and notes will be listed here, newest first.
    ],
  )
]

#section("Side box and entity")[
  #example(
    "#side-box(\"Education\")[\n  #entity(role: \"2020\")[M.A. East Asian Studies, Duke University]\n  #entity(role: \"2016\")[B.S. Computer Science, Princeton University]\n]",
    side-box("Education")[
      #entity(role: "2020")[M.A. East Asian Studies, Duke University]
      #entity(role: "2016")[B.S. Computer Science, Princeton University]
    ],
  )
]

#section("Page columns")[
  #example(
    "#page-columns(\n  notice(\"Main\")[Writing goes here.],\n  side-box(\"Side\")[Information goes here.],\n)",
    page-columns(
      notice("Main")[Writing goes here.],
      side-box("Side")[Information goes here.],
    ),
  )
]
