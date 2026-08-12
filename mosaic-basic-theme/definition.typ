// Passive Basic design definition; the Mosaic engine owns setup.
//
// Basic is a deliberately plain voice, carried over from the `basicwhite`
// Beamer theme by way of its Touying port: sans-serif type, bold titles in
// the accent color, a body centered in whatever room the title leaves, and no
// chrome whatsoever -- no slide numbers, no footer, no progress indicator, no
// rules. Everything the deck says is in the type.
//
// The engine emits no typography of its own, so this states the whole look.
#import "@preview/mosaic:0.0.1": info
#import "layouts.typ" as layouts
#import "tokens.typ"

#let apply(body, colors: (:), options: (:)) = {
  let base = options.base-size

  // Beamer's default font theme is sans-serif and Typst's default is serif,
  // so naming a family here is a fidelity decision rather than a preference.
  // The chain ends in families that ship with essentially every system.
  set text(
    font: options.font,
    size: base,
    weight: "medium",
    fill: colors.text,
    fallback: true,
  )
  set list(marker: [•], spacing: 1em, indent: 1em)
  set enum(numbering: "1.a.i.", spacing: 1em, indent: 1em)
  set terms(spacing: 1em)
  show footnote.entry: set text(size: 0.6em)
  set table(stroke: 0.8pt + colors.line)
  show figure.caption: set text(size: 0.8em, fill: colors.muted)
  show link: set text(fill: colors.accent)

  // Typst scales headings by level on its own, which would compound with the
  // cell rules below -- a level-two heading in the header cell would come out
  // 1.2 x 1.2. Neutralize the level scaling here and let each cell state the
  // size it wants, which is also how a heading written inside a slide body
  // ends up at body size, as it is in the Touying original.
  show heading: set text(size: 1em, weight: "bold")
  show heading: set block(below: 0.8em)

  // The frame title. In the Touying theme this is `subslide-preamble`: the
  // current heading, bold, in the accent color, set one step up from the body
  // with clear air beneath it. Here it is the header cell, which the content
  // layout already places at the top of the slide.
  //
  // The size is the body size, matching what the Touying theme actually
  // renders. Its source asks for `1.2em`, but that value is evaluated where
  // the theme is defined rather than inside a slide, so it resolves against
  // Typst's default size instead of the deck's 25pt and lands back at body
  // size. The title is set apart by weight and color, not by scale.
  show label("mosaic-cell-header"): set text(
    size: base, weight: "bold", fill: colors.accent,
  )
  show label("mosaic-cell-header"): set align(left + top)
  show label("mosaic-cell-header"): it => pad(top: 23pt, bottom: -23pt, it)

  // The body is centered in the space the title leaves, which is what gives
  // a short slide its poise in the original. A multi-column content slide
  // names its cells `body-1`, `body-2`, and so on rather than `body`, so each
  // column is centered on its own terms; three covers any column count a
  // slide can carry legibly.
  show label("mosaic-cell-body"): set align(left + horizon)
  show label("mosaic-cell-body-1"): set align(left + horizon)
  show label("mosaic-cell-body-2"): set align(left + horizon)
  show label("mosaic-cell-body-3"): set align(left + horizon)

  // The title page. Its two cells are composed in `defaults` below, in em
  // units against this rule's size; the only thing left to state here is the
  // ink, which a definition's static data cannot reach.
  show label("basic-title-line"): set text(fill: colors.accent)
  show label("mosaic-cell-title-text"): set align(left + horizon)
  show label("mosaic-cell-title-logo"): set align(center + horizon)

  // The section slide: one bold heading in the accent color, centered both
  // ways, on an otherwise blank slide.
  show label("mosaic-cell-section"): set text(
    size: base, weight: "bold", fill: colors.accent,
  )
  show label("mosaic-cell-section"): set align(center + horizon)

  body
}

#let definition = (
  name: "Basic",
  colors: tokens.white,
  defaults: (
    // The Beamer theme's 2em page margin, which in Mosaic is the inset every
    // cell holds back from the slide edge. Stated absolutely: a definition is
    // read before the deck's text size is set, so `2em` here would resolve
    // against Typst's default size rather than the 25pt below.
    spacing: (inset: 50pt),
    cells: (
      // The Beamer title page's text column, in the order and at the sizes
      // that theme sets it: title, subtitle, authors with their affiliations,
      // then the date. Sizes are `em` against the deck's own size, which is
      // live by the time a cell renders, so they need no absolute values.
      // The one thing this cannot state is color, since a definition is
      // passive data with no access to the resolved palette -- hence the
      // label on the title line, which `apply` paints.
      title-text: context {
        let deck = info()
        block(below: 0.8em, [
          #text(size: 1.3em, weight: "bold", deck.title)#label("basic-title-line")
        ])
        if deck.subtitle != none {
          block(below: 1em, text(size: 0.9em, weight: "bold", deck.subtitle))
        }
        for who in deck.authors {
          block(below: 0.6em, text(size: 0.8em, who.name))
          for where in who.affiliations {
            block(below: 0.6em, text(size: 0.8em, where))
          }
        }
        if deck.date != none {
          block(below: 0.6em, text(size: 0.8em, deck.date))
        }
      },
      // The logo half. A deck fills it with `cells: (title-logo: image(..))`
      // on its title slide; left alone, the text simply keeps the left 60%,
      // which is what the Beamer theme does without a logo.
      title-logo: [],
    ),
  ),
  options: (
    font: ("SF Pro", "Helvetica Neue", "Arial", "Fira Sans", "DejaVu Sans"),
    base-size: 25pt,
  ),
  layouts: (
    content: layouts.content(),
    title: layouts.title,
    section: layouts.section(),
  ),
  apply: apply,
)
