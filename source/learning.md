# Learning

## Asking questions

It is important to have independent learning skills, for example finding information on your own.
However, it is also important to engage others and ask questions when you are stuck.
While not knowing something is okay, being unwilling to learn or asking questions without minimally trying to find the answer yourself is not acceptable.

When asking questions, be sure to:

- **Show you've tried**: Before asking, try to find the answer yourself. This can be by searching the internet, reading the documentation, or trying different things. If you've tried and failed, then ask for help.
- **Be clear and specific**: The more specific you are, the more likely you are to get a specific answer. For example, if you are asking about a specific error message, include the error message in your question.
- **Be polite and patient**: People are more likely to help you if you are polite and patient. Remember that people are volunteering their time to help you.
- **Be ready to give details**: If someone asks you a question to understand your problem better, be ready to answer it with details and don't second guess the reason for the questions asked.
- **Be ready to help**: Be ready to help someone else in the future. No matter how much you (think you) know, there is always someone who knows less than you and who could benefit from your help.

## Topics to learn

As a member of the lab you are responsible to be aware, understand, and eventually master the following topics:

- Data Science / statistics:
  - Mean / variance relationship
  - Homo/heteroskedastic variables
  - Common data transformations: log, normalize by total, centering and scaling
  - Unsupervised analysis:
    - Correlation analysis
    - Dimensionality reduction: SVD, NMF, PCA, Isomap, Diffmap, UMAP
  - Supervised analysis:
    - Regression
    - Classification
    - Cross-validation
    - Performance metrics
  - Regularization
  - Causality
- Machine learning / deep learning:
  - (see above basics regarding supervised learning)
  - Components and steps to train a model:
    - Model architecture
    - Model parameters / weights
    - Optimizer and learning rates
    - Loss function
  - Vision models
  - Feature extraction
  - Graph neural networks
  - Self-supervised learning
  - Federated learning ([https://federated.withgoogle.com/](https://federated.withgoogle.com/))
- Image analysis:
  - Common data formats
  - Storing and manipulating images in a computer
  - Transformations (registration, normalization, augmentation techniques)
  - Segmentation (computer vision- and deep learning-based)
- Anatomy, histology, and physiology:
  - Position and basic function of all major organs in the human body
  - Basic histology
- Aging:
  - Theories of aging
    - Reproductive fitness / repair trade-off
    - Inter-species comparative insights (body size - longevity - metabolism)
    - Damage accumulation
  - Hallmarks of aging
  - Altered pathways with age
  - Relationship of age and disease incidence
  - Classical experimental models and interventions

Note that learning is a iterative and continuous process. You will need to revise and revise your knowledge in each topic over the time, each time getting a deeper understanding or a new perspective on it.

## Literature to know

### Reviews

- "Deep learning in histopathology: the path to the clinic", Jeroen van der Laak, Geert Litjens & Francesco Ciompi, Nature Medicine (2021), https://doi.org/10.1038/s41591-021-01343-4
- "The emerging landscape of spatial profiling technologies", Jeffrey R. Moffitt, Emma Lundberg & Holger Heyn, Nature Reviews Genetics (2022), https://doi.org/10.1038/s41576-022-00515-3
- "Graph representation learning in biomedicine and healthcare", Li, M.M., Huang, K. & Zitnik, M. Nature Biomedicine (2022), https://doi.org/10.1038/s41551-022-00942-x

### Data types

- H&E whole slide images (WSI):
  - Coudray et al. Classification and mutation prediction from non–small cell lung cancer histopathology images using deep learning, Nat. Medicine (2018), https://doi.org/10.1038/s41591-018-0177-5
  - Amgad et al. Structured crowdsourcing enables convolutional segmentation of histology images, Bioinformatics (2019), https://doi.org/10.1093/bioinformatics/btz083
- IF (immunofluorescence)
- IHC/ISH (immunohistochemistry)
- Multiplex imaging methods:
  - **mIF:** Gerdes, M. J. et al. Highly multiplexed single-cell analysis of formalin-fixed, paraffin-embedded cancer tissue. Proc. Natl. Acad. Sci. U. S. A. 110, 11982–11987 (2013). https://doi.org/10.1073/pnas.1300136110
  - **4i:** Multiplexed protein maps link subcellular organization to cellular states Gut et al. Science (2018), https://doi.org/10.1126/science.aar7042
  - **IMC:** Giesen, C. et al. Highly multiplexed imaging of tumor tissues with subcellular resolution by mass cytometry. Nat. Methods 11, 417–422 (2014), https://doi.org/10.1038/nmeth.2869
  - **MIBI:** Angelo, M. et al. Multiplexed ion beam imaging of human breast tumors. Nat. Med. 20, 436–442 (2014), https://doi.org/10.1038/nm.3488
  - **CyCIF:** Lin, J.-R., Fallahi-Sichani, M. & Sorger, P. K. Highly multiplexed imaging of single cells using a high-throughput cyclic immunofluorescence method. Nat. Commun. 6, 8390 (2015), https://doi.org/10.1038/ncomms9390
  - **CODEX:** Goltsev, Y. et al. Deep profiling of mouse splenic architecture with CODEX multiplexed imaging. Cell (2018) https://doi.org/10.1016/j.cell.2018.07.010
- Single-molecule fluorescent in-situ hibridization (**smFISH**):
  - Chen, K. H., Boettiger, A. N., Moffitt, J. R., Wang, S. & Zhuang, X. RNA imaging. Spatially resolved, highly multiplexed RNA profiling in single cells. Science 348, aaa6090 (2015), https://doi.org/10.1126/science.aaa6090
  - Eng, C.-H. L. et al. Transcriptome-scale super-resolved imaging in tissues by RNA seqFISH. Nature 568, 235–239 (2019), https://doi.org/10.1038/s41586-019-1049-y
- Spatial transcriptomics (umbrella term):
  - Stickels, R. R. et al. Highly sensitive spatial transcriptomics at near-cellular resolution with SlideseqV2. Nat. Biotechnol. (2020), https://10.1038/s41587-020-0739-1
  - Merritt, C. R. et al. Multiplex digital spatial profiling of proteins and RNA in fixed tissue. Nat. Biotechnol. 38, 586–599 (5/2020), https://doi.org/10.1038/s41587-020-0472-9
  - Salmén, F. et al. Barcoded solid-phase RNA capture for Spatial Transcriptomics profiling in mammalian tissue sections. Nat. Protoc. 13, 2501–2534 (2018), https://doi.org/10.1038/s41596-018-0045-2

### Digital pathology

- Towards a general-purpose foundation model for computational pathology (2024), https://www.nature.com/articles/s41591-024-02857-3
- A whole-slide foundation model for digital pathology from real-world data (2024), https://www.nature.com/articles/s41586-024-07441-w
- A Multimodal Generative AI Copilot for Human Pathology (2024), https://www.nature.com/articles/s41586-024-07618-3
- A visual-language foundation model for computational pathology (2024), https://www.nature.com/articles/s41591-024-02856-4
- A visual–language foundation model for pathology image analysis using medical Twitter (2024), https://www.nature.com/articles/s41591-023-02504-3
- Chen et al. Pan-cancer integrative histology-genomic analysis via multimodal deep learning Cancer Cell (2022), https://10.1016/j.ccell.2022.07.004
- Chen et al. Scaling Vision Transformers to Gigapixel Images via Hierarchical Self-Supervised Learning (2022), https://arxiv.org/abs/2206.02647
- Lu et al. CLAM: Data-efficient and weakly supervised computational pathology on whole-slide images (2021), https://doi.org/10.1038/s41551-020-00682-w
- Pati et al. HACT-Net: A Hierarchical Cell-to-Tissue Graph Neural Network for Histopathological Image Classification (2020), https://arxiv.org/abs/2007.00584

### Specific literature

#### Genetics of tissue and organ shape

- Genetic and functional insights into the fractal structure of the heart (2020), https:doi.org/10.1038/s41586-020-2635-8
- Self-supervised learning for characterising histomorphological diversity and spatial RNA expression prediction across 23 human tissue types (2023), https://doi.org/10.1101/2023.08.22.554251
- The sex of organ geometry (2024), https://www.nature.com/articles/s41586-024-07463-4

### Target discovery, prioritization and drugs

- "A guide to drug discovery", collection at Nature Reviews Drug Discovery: https://www.nature.com/collections/hkgvrspwtn
  - "Target selection in drug discovery", https://www.nature.com/articles/nrd986
  - "Multi-parameter phenotypic profiling: using cellular effects to characterize small-molecule compounds", https://www.nature.com/articles/nrd2876
- "Applications of single-cell RNA sequencing in drug discovery and development", https://www.nature.com/articles/s41573-023-00688-4
- "Computational approaches in target identification and drug discovery", https://www.sciencedirect.com/science/article/pii/S2001037016300058
- "Moving targets in drug discovery", https://www.nature.com/articles/s41598-020-77033-x
- "Drug target prediction through deep learning functional representation of gene signatures", https://www.nature.com/articles/s41467-024-46089-y
- Integrative multi-omics and drug response profiling of childhood acute lymphoblastic leukemia cell lines, https://www.nature.com/articles/s41467-022-29224-5 \<- prototypical study of "let's throw all the omics at cell lines and pray"
- Two-step multi-omics modelling of drug sensitivity in cancer cell lines to identify driving mechanisms, https://journals.plos.org/plosone/article?id=10.1371/journal.pone.0238961 \<- prototypical study of "let's take a bunch of data, train classifiers and find anecdotal evidence"
- "Network medicine for disease module identification and drug repurposing with the NeDRex platform", https://www.nature.com/articles/s41467-021-27138-2 \<- prototypical study of "network of disease module will eventually find something"
- "Genome-wide investigation of gene-cancer associations for the prediction of novel therapeutic targets in oncology", https://www.nature.com/articles/s41598-020-67846-1 \<- prototypical study of "let's put all the data together and pray"
- "Multi-omics reveals clinically relevant proliferative drive associated with mTOR-MYC-OXPHOS activity in chronic lymphocytic leukemia", https://www.nature.com/articles/s43018-021-00216-6 \<- example of great study on primary human samples (leukemia) combining omics with functional readouts (drug sensitivity). Even if it is a great study, it may miss the mark by focusing on a disease for which there are already very good treatment options
- "Systems immunology-based drug repurposing framework to target inflammation in atherosclerosis", https://www.nature.com/articles/s44161-023-00278-y \<- nice example of a study wtih great readouts focused on atherosclerosis that goes straight to drug discovery

## Courses

### Programming, Computer Science

- UNIX, git, security (MIT) (https://www.youtube.com/playlist?list=PLyzOVJj3bHQuloKGG59rS43e29ro7I57J)
- Introduction to Computer Science and Programming Using Python https://www.edx.org/course/introduction-to-computer-science-and-programming-7
- Hypermodern Python (CLAUDIO JOLOWICZ) (https://cjolowicz.github.io/posts/hypermodern-python-01-setup/)

### Machine Learning / Deep Learning

- Deep learning for image analysis, https://www.embl.org/about/info/course-and-conference-office/events/mac23-01/
- Practical deep learning for coders (Fast.ai), https://course.fast.ai/, https://www.youtube.com/watch?v=\_QUEXsHfsA0&list=PLfYUBJiXbdtRL3FMB3GoWHRI8ieU6FhfM
- Deep learning in life sciences (MIT), https://www.youtube.com/playlist?list=PLypiXJdtIca5sxV7aE3-PS9fYX3vUdIOX
- Introduction to Deep Learning - 170 Video Lectures from Adaptive Linear Neurons to Zero-shot Classification with Transformers (Sebastian Raschka), https://sebastianraschka.com/blog/2021/dl-course.html
- Introduction to Coding Neural Networks with PyTorch and Lightning: https://www.youtube.com/watch?app=desktop&v=khMzi6xPbuM&feature=youtu.be&s=09
- Deep learning course (François Fleuret, University of Geneva) (https://fleuret.org/dlc/?s=09)
- The Ancient Secrets of Computer Vision (Univ. Washington) (https://pjreddie.com/courses/computer-vision/, https://www.youtube.com/playlist?list=PLjMXczUzEYcHvw5YYSU92WrY8IwhTuq7p)

### Statistics

- Statistical Rethinking (2022 Edition), https://github.com/rmcelreath/stat_rethinking_2022, https://github.com/pymc-devs/pymc-resources/tree/main/Rethinking_2

### Bioinformatics

- Bioinformatics training materials (Swiss Bioinformatics Institute), https://github.com/sib-swiss/training-collection

### Genomics

- Applied Computational Genomics (University of Utah), https://www.youtube.com/playlist?list=PLCbXw1opqIQeNfF26-wWegdGoCC1aut0P

### Medicine / Anatomy / Histology

- Anatomy and histology:
  - https://www.kenhub.com/
  - https://medicine.nus.edu.sg/pathweb/normal-histology/
  - https://digitalhistology.org/
  - https://histologyguide.com/
- Medicine (Lecturio), https://www.youtube.com/c/Lecturio-Medical-Education-Videos
- Anatomy (Lecturio), https://www.youtube.com/playlist?list=PLVnjTkEwv-uNRNX3D_FAt3ZGvWFvJgKmG
- Pathology:
  - https://pathologia.ed.ac.uk/ (University of Edinburgh MBChB)
  - https://virtualpathology.leeds.ac.uk/slides/library (University of Leeds)
  - https://www.webpathology.com
  - https://www.pathelective.com

### Aging

- The ageing genome: from mechanisms to disease, https://www.embl.org/about/info/course-and-conference-office/events/ees23-04/

### Other courses (paid):

- https://carpentries.org/workshops/
- https://www.biocode.ltd/courses

## Books

- "Deep Medicine", Eric Topol

## Tutorials

- Gradient descent and backpropagation: [https://www.youtube.com/watch?v=VMj-3S1tku0](https://www.youtube.com/watch?v=VMj-3S1tku0)
- Transformers from scratch: [https://e2eml.school/transformers.html](https://e2eml.school/transformers.html)
- Data visualization / figure making with Python: [https://github.com/frankligy/python_visualization_tutorial](https://github.com/frankligy/python_visualization_tutorial)
- Histology @ Yale: [http://medcell.org/histology/histology.php](http://medcell.org/histology/histology.php)
- Systems Cell Biology @ Yale: [http://medcell.med.yale.edu/systems_cell_biology/systems_cell_biology.php](http://medcell.med.yale.edu/systems_cell_biology/systems_cell_biology.php)
- Immunology: [https://www.youtube.com/watch?v=iwB8kKdNgdQ](https://www.youtube.com/watch?v=iwB8kKdNgdQ)
- Software development: many paths to learning: [https://www.youtube.com/watch?v=66tfvFeALBQ](https://www.youtube.com/watch?v=66tfvFeALBQ)

## Software packages

These are some of the software packages we use often in the lab. You can more easily be aware of the direction of their development and new versions by subscribing to their releases on Github (bell sign -> custom -> releases).

### Data science

- Numpy ([https://numpy.org/](https://numpy.org/))
- Pandas ([https://pandas.pydata.org/](https://pandas.pydata.org/))
- Scipy ([https://scipy.org/](https://scipy.org/))
- Scanpy ([https://scanpy.readthedocs.io/en/stable/](https://scanpy.readthedocs.io/en/stable/))
- Squidpy ([https://squidpy.readthedocs.io/en/stable/](https://squidpy.readthedocs.io/en/stable/))
- Networkx ([https://networkx.org/](https://networkx.org/))
- Scikit-networks ([https://scikit-network.readthedocs.io/](https://scikit-network.readthedocs.io/))

### Statistics / machine learning

- pingouin ([https://pingouin-stats.org/](https://pingouin-stats.org/))
- statsmodels ([https://www.statsmodels.org/stable/index.html](https://www.statsmodels.org/stable/index.html))
- sklearn ([https://scikit-learn.org/stable/](https://scikit-learn.org/stable/))
- imbalanced-learn ([https://imbalanced-learn.org/](https://imbalanced-learn.org/))
- pymer4 ([https://eshinjolly.com/pymer4/](https://eshinjolly.com/pymer4/))
- PyMC (\[https://www.pymc.io/welcome.html, https://www.pymc.io/projects/docs/en/stable/learn.html\](https://www.pymc.io/welcome.html, https://www.pymc.io/)projects/docs/en/stable/learn.html)

### Tensor-specific

- einops ([https://github.com/arogozhnikov/einops](https://github.com/arogozhnikov/einops))
- tensorly ([https://tensorly.org/](https://tensorly.org/))

### Deep learning

- weightsandbiases ([https://wandb.ai/site](https://wandb.ai/site)) \<- join the lab's team at [https://wandb.ai/rendeiro-group](https://wandb.ai/rendeiro-group)
- pytorch ([https://pytorch.org/](https://pytorch.org/))
- pytorch-lightning ([https://www.pytorchlightning.ai/](https://www.pytorchlightning.ai/))
- pytorch-geometric ([https://pytorch-geometric.readthedocs.io/en/latest/](https://pytorch-geometric.readthedocs.io/en/latest/))
- captum ([https://captum.ai/](https://captum.ai/))
- fastai ([https://docs.fast.ai/](https://docs.fast.ai/))
- timm, pytorch-image-models ([https://github.com/rwightman/pytorch-image-models](https://github.com/rwightman/pytorch-image-models))
- TabPFN ([https://github.com/automl/TabPFN](https://github.com/automl/TabPFN))
- fiftyone ([https://voxel51.com/docs/fiftyone/](https://voxel51.com/docs/fiftyone/))
- transformers ([https://github.com/huggingface/transformers](https://github.com/huggingface/transformers))

### Visualization

- matplotlib ([https://matplotlib.org/](https://matplotlib.org/))
- seaborn ([https://seaborn.pydata.org/](https://seaborn.pydata.org/))
- scikit-yb ([https://www.scikit-yb.org/en/latest](https://www.scikit-yb.org/en/latest))
- inkscape ([https://inkscape.org/)](https://inkscape.org/):)
  - https://www.inkscapeforstem.com/Inkscape-For-STEM-ee6dacb7a2e543218f87a29f69177fee
  - https://bioicons.com/
- napari ([https://napari.org/](https://napari.org/))
- bokeh ([https://docs.bokeh.org/en/latest/](https://docs.bokeh.org/en/latest/))
- plotly ([https://plotly.com/](https://plotly.com/))
- D3.js ([https://d3js.org/](https://d3js.org/))

### Data-specific

#### Imaging:

- skimage ([https://scikit-image.org/](https://scikit-image.org/))
- Deformetrica ([https://gitlab.com/icm-institute/aramislab/deformetrica, http://www.deformetrica.org/](https://gitlab.com/icm-institute/aramislab/)deformetrica, http://www.deformetrica.org/)

#### Survival data:

- Lifelines ([https://lifelines.readthedocs.io/en/latest/](https://lifelines.readthedocs.io/en/latest/))
- Auton-survival ([https://github.com/autonlab/auton-survival](https://github.com/autonlab/auton-survival))

#### Computational Pathology:

- QuPath ([https://qupath.github.io/](https://qupath.github.io/))
- Cytomine (\[https://doc.cytomine.org/, https://cytomine.com/\](https://doc.cytomine.org/, https://cytomine.com/))
- PathML ([https://github.com/Dana-Farber-AIOS/pathml](https://github.com/Dana-Farber-AIOS/pathml))
- HistomicsTK ([https://digitalslidearchive.github.io/HistomicsTK](https://digitalslidearchive.github.io/HistomicsTK))
- CLAM ([https://github.com/mahmoodlab/CLAM](https://github.com/mahmoodlab/CLAM))
- ASAP ([https://github.com/GeertLitjens/ASAP](https://github.com/GeertLitjens/ASAP))

### Web

- Flask ([https://flask.palletsprojects.com/en/2.1.x/](https://flask.palletsprojects.com/en/2.1.x/))
- fastapi ([https://fastapi.tiangolo.com/](https://fastapi.tiangolo.com/))
- nativefier ([https://github.com/nativefier/nativefier](https://github.com/nativefier/nativefier))

### Productivity and logistics

- Note taking:
  - obsidian (\[https://obsidian.md/, https://github.com/obsidianmd\](https://obsidian.md/, https://github.com/obsidianmd))
- Integrated development environment (IDE):
  - sublimetext ([https://www.sublimetext.com/](https://www.sublimetext.com/))
  - vscode ([https://code.visualstudio.com/](https://code.visualstudio.com/))
- Figure editing:
  - inkscape ([https://inkscape.org/](https://inkscape.org/))
- Software management:
  - pip ([https://pip.pypa.io/en/stable/](https://pip.pypa.io/en/stable/))
  - poetry ([https://python-poetry.org/](https://python-poetry.org/))
  - uv ([https://github.com/astral-sh/uv](https://github.com/astral-sh/uv))
  - conda ([https://docs.conda.io/en/latest/](https://docs.conda.io/en/latest/))
  - docker ([https://www.docker.com/](https://www.docker.com/))
- Code improvement:
  - ruff ([https://github.com/astral-sh/ruff](https://github.com/astral-sh/ruff))
  - mypy ([https://mypy-lang.org/](https://mypy-lang.org/))
  - pre-commit ([https://pre-commit.com/](https://pre-commit.com/))
  - sublimemerge ([https://www.sublimemerge.com/](https://www.sublimemerge.com/))
- Documentation:
  - sphinx ([https://www.sphinx-doc.org/en/master/](https://www.sphinx-doc.org/en/master/))
  - pandoc ([https://pandoc.org/](https://pandoc.org/))
- Interactive and environment management:
  - IPython ([https://ipython.org/](https://ipython.org/))
  - virtualenv ([https://virtualenv.pypa.io/en/latest/](https://virtualenv.pypa.io/en/latest/))
  - jupyter-notebook ([https://jupyter.org/](https://jupyter.org/))

### Data repositories

- Generic:
  - Zenodo ([https://zenodo.org/](https://zenodo.org/))
  - GigaDB ([http://gigadb.org/](http://gigadb.org/))
  - Synapse ([https://www.synapse.org/](https://www.synapse.org/))
- Transcriptomics:
  - GEO ([https://www.ncbi.nlm.nih.gov/geo/](https://www.ncbi.nlm.nih.gov/geo/))
  - ArrayExpress ([https://www.ebi.ac.uk/arrayexpress/](https://www.ebi.ac.uk/arrayexpress/))
- Sensitive data:
  - EGA ([https://ega-archive.org/](https://ega-archive.org/))
  - dbGAP ([https://dbgap.ncbi.nlm.nih.gov/](https://dbgap.ncbi.nlm.nih.gov/))
