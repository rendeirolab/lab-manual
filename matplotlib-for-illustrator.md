# How to import matplotlib plots gracefully in illustrator?

## Step 1: When coding

Include following code snippets before drawing anything, and always save your plot in `.pdf` format:

```python
import matplotlib.pyplot as plt

plt.rcParams['savefig.bbox'] = 'tight'
plt.rcParams['savefig.transparent'] = True
plt.rcParams['pdf.fonttype'] = 42
plt.rcParams['ps.fonttype'] = 42
```

In case you're curious about what each setting does:

To ensure that legends and elements outside the axes are included:

```python
plt.rcParams['savefig.bbox'] = 'tight'
```

To remove the white background:

```python
plt.rcParams['savefig.transparent'] = True
```

To allow text to be editable in Illustrator:

```python
plt.rcParams['pdf.fonttype'] = 42
plt.rcParams['ps.fonttype'] = 42
```

## Step 2: Open PDF in Adobe Illustrator

- Select everything:
    - Mac: <kbd>&#8984; Command</kbd> + <kbd>A</kbd>
    - Windows: <kbd>Ctrl</kbd> + <kbd>A</kbd>
- Go to `Object` -> `Clipping Mask` -> `Release`, press until it can't be pressed anymore:
    - Mac: <kbd>⌥ Option</kbd> + <kbd>&#8984; Command</kbd> + <kbd>7</kbd>
    - Windows: <kbd>Alt</kbd> + <kbd>Ctrl</kbd> + <kbd>7</kbd>

Congratulations! Now you have a clean plot ready for editing.

> [!CAUTION]
> Removing clipping masks may affect elements, such as bars that extend offscreen.