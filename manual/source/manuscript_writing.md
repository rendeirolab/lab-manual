# Manuscript writing

## Figures

Here are Andre's tips for figure making based on practice.
This has changed a little over the time, but mostly coalesced on a fairly simple system.

Making plots (Python, matplotlib, seaborn):

- Try to compartmentalize data processing from visualization (not just the early 'pipeline'-like processing, but also the analytical analysis) - but that does not mean that 
- Each script produces a set of plots into a `results` directory, with subdirectories matching the script or analysis name (more hierarchical if needed, e.g. different datasets).
- Each plot file name should be self explanatory and contain enough information to track down its origin.
- Except for obvious groupings or interrelations, avoid making figures with many subplots.
- Create figures in matplotlib/seaborn always explicitly: `fig, ax = plt.subplots(figsize=(3, 3)`
- For the most part aim for each subplot to have a square shape with about 3 by 3 inches. If creating a figure with multiple subplots, scale the figure size accordingly: `fig, axes = plt.subplots(4, 2, figsize=(2 * 3, 4 * 3)`
- Always label the axes, and make use of a single statement to set many properties at once: `ax.set(xlabel="Time", ylabel="Expression (log)", yscale="log")`
- For plot elements with many objects (e.g. scatter), rasterize that specific single element in order to reduce the size of the figure: `g = sns.clustermap(...); g.ax_heatmap.set(rasterized=True)`. Do not rasterized the whole axes as that will make e.g. text element uneditable.
- Choose consistent colors across a project. Consider thinking of all factors being highlighted in the paper before starting the project. See colormaps here: [https://matplotlib.org/stable/gallery/color/colormap_reference.html](https://matplotlib.org/stable/gallery/color/colormap_reference.html)
- Choose continuous colormaps for continuous variables (magma, viridis). Use divergent colormaps (coolwarm, RdBu_r, PuOr_r) only when a central value has meaning (e.g. a Z-score).
- Export figures as SVG format, but explicitly set `dpi=300` to make sure any rasterized elements have good quality. Set `bbox_inches='tight` to make sure the whole content is visible.


Assemble plots manually into a figure (inkscape):

- Check the journal requirements and limitations for figures and their dimensions. Use A4 by default, not letter.
- Here is a template figure: [https://gist.github.com/afrendeiro/2d9975793629774ad73ea9d18bd7abf3](https://gist.github.com/afrendeiro/2d9975793629774ad73ea9d18bd7abf3)
- Add a plot to the canvas, resize it to an approximate desired size, remove all groupings, remove redundant objects, possibly despine plot (i.e. remove top right, top axes). Make whole plot into a group (or layer).
- Be wary of resize operations that change aspect ratio. Be sure not to create artifacts. Here's some help: [https://github.com/burghoff/Scientific-Inkscape](https://github.com/burghoff/Scientific-Inkscape) (hasn't worked recently for me).
- Use a consistent font family (Arial) for all text elements and only one or two font sizes (12 and 10). You can use the Find/Replace tool with `Object types = 'text'` to do this.
- Add a lowercase letter label to each panel (font 16).
- Add a label to the top of the Figure (i.e. Figure 1)
- Name the figure files consistently Figure1.svg, SupplementaryFigure1.svg


Post assembly, automatic assembly and conversion of file types (bash, inkscape, minify, pdfunite):

- Use script here: [https://gist.github.com/afrendeiro/a656eca139381eec55da6357e33173ce](https://gist.github.com/afrendeiro/a656eca139381eec55da6357e33173ce)
- Use generated individual PDFs to embed in a manuscript tex file.
- Use generated individual PNGs to embed in a manuscript file like docx.
- Use the joint PDFs to print, share or submit to journal.

Only in very rare cases it is worth it to have a full final figure generated as a whole.

## Text

### Structure

Template

## File formats

refer to [research page](research.md#asdasd)
