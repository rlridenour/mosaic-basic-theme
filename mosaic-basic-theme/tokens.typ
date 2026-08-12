// Basic design tokens.
//
// The Touying original selects its look with `basic-theme(variant: ..)`,
// where a variant is nothing but a background, a foreground, and an accent.
// Mosaic already has a name for that shape: a palette. So the four variants
// ship here as palettes and a deck picks one through `setup(colors: ..)`,
// which is the same spelling every other Mosaic deck uses to change polarity.
//
// Each palette states the eight colors Mosaic expects. Three are carried over
// from the Touying theme unchanged -- `canvas` (its `bg`), `text` (its `fg`),
// and `accent` -- and the rest are derived so that components, tables, and
// captions have somewhere to sit. The original had no use for them because it
// drew no components; they stay close to the canvas so they never assert
// themselves in a design whose whole point is that it has no chrome.
//
// `white` is the default and matches the Beamer `basicwhite` theme it
// descends from: black on white, headings in the same black as the body.

// Oklahoma Baptist University green, carried across from the Touying theme
// verbatim rather than converted, so the two render the same ink.
#let obu-green = cmyk(80%, 9%, 88%, 60%)

#let white = (
  canvas: rgb("#ffffff"),
  surface: luma(246),
  text: rgb("#000000"),
  muted: luma(90),
  line: luma(190),
  accent: rgb("#000000"),
  warning: rgb("#9a6700"),
  error: rgb("#b42318"),
)

#let black = (
  canvas: rgb("#000000"),
  surface: luma(26),
  text: rgb("#ffffff"),
  muted: luma(170),
  line: luma(70),
  accent: rgb("#ffffff"),
  warning: rgb("#e3b341"),
  error: rgb("#ff7b72"),
)

#let gray = (
  canvas: rgb("#eeeeee"),
  surface: luma(228),
  text: rgb("#000000"),
  muted: luma(90),
  line: luma(180),
  accent: rgb("#000000"),
  warning: rgb("#9a6700"),
  error: rgb("#b42318"),
)

#let obu = (
  canvas: rgb("#ffffff"),
  surface: luma(246),
  text: rgb("#000000"),
  muted: luma(90),
  line: luma(190),
  accent: obu-green,
  warning: rgb("#9a6700"),
  error: rgb("#b42318"),
)

// The four variants under the names the Touying theme uses for them.
#let variants = (
  white: white,
  black: black,
  gray: gray,
  obu: obu,
)
