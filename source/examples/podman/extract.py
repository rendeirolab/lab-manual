#!/usr/bin/env python3
"""LazySlide feature extraction. Writes only to /out. Caches stay in /tmp."""

import os
import shutil
from pathlib import Path

os.environ.setdefault("HOME", "/tmp")
os.environ.setdefault("HF_HOME", "/tmp/hf_home")
os.environ.setdefault("TORCH_HOME", "/tmp/torch")
os.environ.setdefault("XDG_CACHE_HOME", "/tmp/cache")

import pandas as pd

pd.options.future.infer_string = False

import lazyslide as zs
import torch
from wsidata import open_wsi

OUT = Path("/out")
OUT.mkdir(parents=True, exist_ok=True)

slide = os.environ.get("SLIDE", "").strip()
device = "cuda" if torch.cuda.is_available() else "cpu"

if slide:
    slide_path = Path(slide)
    store = OUT / f"{slide_path.stem}.zarr"
    wsi = open_wsi(str(slide_path), store=str(store))
else:
    store = OUT / "sample.zarr"
    wsi = zs.datasets.sample(with_data=False)

zs.pp.find_tissues(wsi)
zs.pp.tile_tissues(wsi, tile_px=256, mpp=0.5)
zs.tl.feature_extraction(wsi, model="resnet50", device=device)

if store.exists():
    shutil.rmtree(store)
wsi.write(str(store))

print(f"device={device}")
print(f"wrote {store}")
print(wsi["resnet50_tiles"])
