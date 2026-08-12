// Public Basic facade: the shared Mosaic API plus Basic's setup and layouts.
//
// A deck imports this in place of Mosaic itself and is otherwise an ordinary
// Mosaic deck -- `slide`, `note`, `steps`, `components`, `grids`, `surface`,
// and `fit` are Mosaic's own, re-exported here so that `m.` reaches
// everything from one import.
#import "@preview/mosaic:0.0.1" as mosaic
#import "@preview/mosaic:0.0.1": slide, info, note, fit, surface, grids, steps, components, palettes
#import "definition.typ": definition
#import "layouts.typ" as layouts
#import "tokens.typ": variants

#let setup = mosaic.themes.setup(definition)
