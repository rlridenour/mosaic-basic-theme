// A deck exercising the Basic theme. Swap the palette on the setup call
// to see the other variants: m.variants.black, .gray, or .obu.
//
// Add `output: "split"` to the setup call for the presenter console --
// every frame beside its notes on a double-width page, which pympress
// splits automatically and pdfpc splits with `--notes=right`. The
// `speaker` and `notes` outputs print the same notes on A4 instead.
#import "@local/mosaic-basic-theme:0.1.0" as m

#show: m.setup.with(
  title: [A Basic Talk],
  subtitle: [Mosaic, in the Beamer basicwhite voice],
  authors: [Randy Ridenour],
  date: [August 1, 2026],
  logo: m.univ-logo(),
)

#m.slide(layout: "title")

= First Section

== A bulleted slide

- Ordinary Typst markup, *bold* and _italic_
- Lists carry the theme's bullet and rhythm
- The body is centered in the room the title leaves

== Lists, tables, and math

#table(
  columns: 3,
  table.header([Method], [Estimate], [SE]),
  [OLS], [0.42], [0.11],
  [IV], [0.38], [0.19],
)

$ hat(beta) = (X^top X)^(-1) X^top y $

#m.slide(variant: "header-body", columns: 2)[== Two columns][
  - Left column
  - Two bullets
][
  - Right column
  - Two more
]

= Second Section

== Reveals and notes

- The estimate is positive.
#m.steps.pause
- The interval excludes zero.

#m.note[Notes work exactly as they do in any Mosaic deck.]
