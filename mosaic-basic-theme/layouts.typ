// Callable Basic layout namespace: base Mosaic layouts with Basic's defaults.
// The facade and the definition share these, so an explicit
// `m.layouts.content()` call builds the same slide an automatic heading does.
#import "@preview/mosaic:0.0.1" as mosaic

// Header and body only. The Touying theme draws no footer, and the frame
// title is the first thing in the slide rather than page furniture, so the
// two-cell content layout is the whole structure a slide needs.
#let content = mosaic.layouts.content.with(variant: "header-body")

// The title page is a grid rather than one of Mosaic's title variants,
// because the Beamer original is a two-column composition -- text in the left
// 60%, an optional logo centered in the right 40% -- and because its metadata
// block sets author and date at one size. Every stock variant scales the
// byline and the date apart from each other, so no combination of fields
// reproduces it. The text cell is composed from `info()` in the definition's
// `cells` defaults; the logo cell is the deck's to fill.
#let title = mosaic.grids.columns(
  mosaic.grids.track(60%, "title-text"),
  mosaic.grids.track(40%, "title-logo"),
)

// A bare centered heading, which is what the Beamer `section page` template
// amounts to. The designed variants all add furniture this theme does not
// have.
#let section = mosaic.layouts.section.with(variant: "plain")

#let image = mosaic.layouts.image
