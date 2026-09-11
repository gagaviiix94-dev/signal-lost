# Signal Lost

A grid deduction game. A transmitter is hidden somewhere in the sector; you have
a limited number of probes to find it. Open `index.html` in any browser — no
build, no dependencies, one file.

## How it plays

Each probe reports a **signal strength**: `100 · e^(−2.2 · d / diagonal)`, where
`d` is the distance to the transmitter. Higher means closer.

The catch is interference. Every reading is perturbed by Gaussian noise, so a
single number never pins a cell — it narrows the transmitter down to a fuzzy
*ring* at some radius around the probe. Hover a readout to see that ring drawn
on the grid. Two rings intersect at a couple of places; three usually leave one.
That's the whole game: you are triangulating, not playing hot-and-cold.

Probe the transmitter's own cell to clear the sector. Run out of probes and the
run ends.

## Tuning

Interference is defined as a fraction of the steepest one-cell drop in signal,
not as a flat number, so a reading stays about as ambiguous *in cells* on a 6×6
as on a 12×12. Sectors get harder from size and budget rather than from runaway
noise. Past the largest grid the probe budget thins out every three sectors.

Against a perfect Bayesian solver the win rate runs ~99% at sector 1, ~94% at
sector 7, and ~38% by sector 20 — so a run always ends eventually, and the
score gap between good and sloppy probing is real.

## Analyzer

The `ANALYZER` toggle shades every cell by how well it fits the readings so far
(log-likelihood, range-normalised so the map shows a gradient rather than one
lit square). It is a crutch and it costs you: using it at any point in a sector
halves that sector's score.

## Scoring

`(probes remaining + 1) × 120 × sector`, halved if the analyzer was touched.
Best run is kept in `localStorage`.

## Controls

Arrow keys move, `enter` probes, `a` toggles the analyzer, `r` starts a new run.
Mouse works throughout.
