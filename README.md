# mosaic-basic-theme

A [Mosaic](https://github.com/vincentarelbundock/mosaic) theme for Typst
presentations that replicates
[`touying-basic-theme`](https://github.com/rlridenour/touying-basic-theme),
which in turn replicates the `basicwhite` Beamer theme.

Sans-serif type, bold titles in the accent color, a body centered in
whatever room the title leaves, and no chrome at all — no slide numbers,
no footer, no progress indicator, no rules.

Rendered side by side against the Touying original, the title and
section slides are pixel-identical and the content slide's body sits
within 3px; every text run measures the same width. See
[Fidelity](#fidelity).

## Install

This theme builds on **Mosaic 0.0.2**, which is the development version
and is not on Typst Universe, so it has to be installed first:

```sh
git clone https://github.com/vincentarelbundock/mosaic.git
cd mosaic && make install
```

Then symlink this theme, the same way the Touying theme is installed:

```sh
mkdir -p ~/Library/Application\ Support/typst/packages/local/mosaic-basic-theme
ln -sfn "$PWD/mosaic-basic-theme" \
  ~/Library/Application\ Support/typst/packages/local/mosaic-basic-theme/0.1.0
```

0.0.2 is what brings the presenter console — see
[Presenting](#presenting). Pin `@preview/mosaic:0.0.1` in the three
`.typ` files under `mosaic-basic-theme/` if you would rather have a
theme that needs no local install; everything except the console
outputs works there too.

## Usage

```typ
#import "@local/mosaic-basic-theme:0.1.0" as m

#show: m.setup.with(
  title: [A Basic Talk],
  subtitle: [A subtitle],
  authors: [Randy Ridenour],
  date: [August 1, 2026],
)

#m.slide(layout: "title")

= First Section

== A bulleted slide

- First point
- Second point
```

A level-one heading opens a section slide and a level-two heading a
content slide, which is Mosaic's own model and matches the Touying
theme's default `slide-level: 2`.

Everything else is ordinary Mosaic: `m.slide`, `m.note`, `m.steps`,
`m.components`, `m.grids`, `m.surface`, and `m.fit` are re-exported from
Mosaic unchanged, so any Mosaic documentation applies.

### Variants

The Touying theme's four variants are palettes here, which is Mosaic's
own spelling for a change of polarity:

```typ
#show: m.setup.with(colors: m.variants.black, ..)
```

| Variant | Canvas | Text | Accent |
| --- | --- | --- | --- |
| `white` (default) | white | black | black |
| `black` | black | white | white |
| `gray` | `#eeeeee` | black | black |
| `obu` | white | black | OBU green |

Each is a plain dictionary, so tuning one is addition:
`m.variants.white + (accent: rgb("#b91c1c"))`. Mosaic's own curated
palettes remain available as `m.palettes`.

### The title slide's logo

The title page is a two-column grid — text in the left 60%, an optional
logo centered in the right 40%. Two logos ship with the theme, so a talk
needs no copy of its own beside it:

```typ
#show: m.setup.with(logo: m.univ-logo(), ..)    // OBU
#show: m.setup.with(logo: m.school-logo(), ..)  // OBU School of Theology
```

Both take a `width`, defaulting to `90%`. Any other image works the same
way — `logo: image("logos/mine.png", width: 90%)`, resolved against the
deck.

Left alone the half is empty and the text simply keeps the left 60%,
which is what the Beamer theme does without a logo.

Setting it per slide works too, and is what you want if a deck has more
than one title slide:

```typ
#m.slide(layout: "title", cells: (title-logo: m.univ-logo()))
```

Note that `cells:` does **not** work for this on `setup`. A deck's
`cells:` replaces the theme's outright rather than merging key by key,
so `setup(cells: (title-logo: ..))` would take the composed title text
down with it and leave a slide holding nothing but a logo. That
asymmetry is why the logo is an option: per slide, `cells:` overrides
one ID at a time and is the right tool; deck-wide, it is not.

## Presenting

Mosaic 0.0.2's outputs all work with this theme:

```typ
#show: m.setup.with(output: "split", ..)    // slide beside its notes
#show: m.setup.with(output: "speaker", ..)  // printed: thumbnail + notes
#show: m.setup.with(output: "notes", ..)    // printed: notes alone
```

`split` puts every frame on a double-width page — the slide at true size
on the left, its notes on the right — which
[pympress](https://pympress.xyz/) splits automatically and
[pdfpc](https://pdfpc.github.io/) splits with `--notes=right`. Write
notes with `m.note[..]`.

The theme sizes the notes at 16pt rather than leaving Mosaic's 10pt,
which is set for a printed A4 companion and is too small to read off a
laptop while presenting. It also restates the note body's weight, since
Mosaic's bold heading rule otherwise carries into the body and renders
the whole notes half bold. Override either with an ordinary rule after
`setup`.

The notes half stays black on white whatever variant the deck carries,
which is the polarity you want under house lights.

## Authoring in Org

[`ox-rlr-mosaic`](https://github.com/rlridenour/ox-rlr-mosaic) drives
this theme with no changes — point its package keyword at the theme and
omit `#+MOSAIC_THEME:`, which selects a *bundled* Mosaic facade:

```org
#+TITLE: A Basic Talk
#+AUTHOR: Randy Ridenour
#+MOSAIC_PACKAGE: @local/mosaic-basic-theme:0.1.0
#+MOSAIC_COLORS: m.variants.obu
#+MOSAIC_SETUP: logo: m.univ-logo()
```

`#+MOSAIC_SETUP:` passes an argument straight to `setup`, which is how
the logo and any other theme option are reached from Org. Paths there
resolve against the exported `.typ`, which sits beside the `.org`.

For the presenter console, add `#+MOSAIC_OUTPUT: split`.

## Fidelity

Measured against the Touying original at 70ppi, same content, same page
(841.89 × 473.563pt), comparing the bounding box of every text line:

| Slide | Result |
| --- | --- |
| Title | identical — every line matches in position and width |
| Section | identical |
| Content | widths identical; body 2–3px lower |

Mean deviation is 0.9px per text line.

Three findings from that comparison are worth recording, because they
are places where the Touying theme's source and its output disagree.
This theme matches the **output**, since that is what a replica is for.

- **The frame title renders at body size**, not the `1.2em` its source
  asks for. The same is true of the section heading's `1.4em`. Both `em`
  values are resolved where the theme is defined rather than inside a
  slide, so neither reaches the deck's 25pt. In both themes the title is
  set apart by weight and color rather than by scale.
- **The title page's byline and date are one size** (0.8em). No stock
  Mosaic title variant can reproduce that — each scales the byline
  (0.7) and the date (0.62) apart — which is why the title page here is
  a grid composed from `info()` rather than a configured title layout.
- **Mosaic insets edge cells at 0.55× vertically**, by design, so a
  one-line header band is not deeper than the text it carries. That puts
  the frame title higher than Beamer's flat 2em margin, so the header
  cell is padded down by 23pt and pulled back by the same amount, which
  restores the title's position without taking the space from the body.

## Layout

- `mosaic-basic-theme/` — the package.
  - `lib.typ` — the facade: binds `setup`, re-exports Mosaic's API.
  - `definition.typ` — the design: typography, cell rules, the composed
    title page.
  - `layouts.typ` — the callable layout namespace.
  - `tokens.typ` — the four variant palettes.
  - `logos/` — the bundled logos, reached with `m.univ-logo()` and
    `m.school-logo()`.
- `examples/demo.typ` — a deck exercising the theme.

## Differences from the Touying theme

- **No subsection slides.** Mosaic's heading model is two levels: `=` is
  a section, `==` is a slide. The Touying theme's `slide-level: 3`
  arrangement, where `==` is a subsection, has no equivalent.
- **Speaker notes are Mosaic's**, written with `m.note[..]`, and the
  presenter outputs are Mosaic's `speaker`, `notes`, and `split` — see
  [Presenting](#presenting). The Touying theme has its own note
  machinery and a second-screen view built on Touying's.
- **Incremental reveals are Mosaic's** `m.steps`, not Touying's
  `#pause`.
