# Project planning

This guide can serve as a **standalone reference** for project planning and fellowship writing.
Each section builds on conceptual, strategic, and practical aspects separately, but they should be taken into consideration together for best results.

## Background and concepts

### Ideal vs reality of designing a project for public funding
- **Basic vs applied science**: Funding often requires navigating the balance between fundamental discovery and real-world application.
- **Funding agencies as...**
    - **Investors (ideal)**: They take on risk to enable novel, groundbreaking ideas.
    - **Consumers (reality)**: They seek 'safe bets' by prioritizing projects with a track record of feasibility and evidence.

### **Triangle of knowledge**
- **Hierarchy**: Data → Information → Knowledge → Wisdom
- **Flow between layers**:
    - Data is raw input (e.g., measurements, numbers).
    - Information is data contextualized with meaning.
    - Knowledge is synthesized information with clear insight.
    - Wisdom incorporates experience, values, and context beyond natural science (includes personal experience, philosophy, and metaphysics).

## Strategies

### Project design

#### Balancing feasibility and novelty
- **Aim 1**: Incremental research (low risk, highly feasible).
- **Aim 2**: Novel, higher-risk research (potential for greater impact but riskier).
- **Aim 3**: Hybrid approach, combining incremental and novel aspects (not always necessary).

#### Balancing profiling and perturbing
- **Profiling aim**: Descriptive/observational, e.g., understanding how mutation X is linked to pathway A, or observing population-level traits.
- **Perturbing aim**: Functional/causal, e.g., testing if gene X causes phenotype Y, or clinical trials.

The two strategies can be linked. For instance:  Aim 1 is slightly incremental with profiling only; Aim 2: more ambitious/novel based on perturbations.

### Shallow-pass strategy for project execution
The **Shallow-pass strategy** is a systematic approach to project execution that emphasizes early, rapid, and minimally viable progress through a project’s full timeline, followed by iterative deepening of depth (both conceptually and technically) as needed. It draws on established principles from **Agile development**, **Rapid prototyping**, **Incremental research**, and **Lean startup** approaches.

### Core concept

The strategy envisions a 2D space where:
- **Horizontal axis** = Timeline from start to finish (milestones, objectives, deliverables).
- **Vertical axis** = Depth of conceptual understanding, technical precision, or experimental thoroughness.
Instead of moving **deeply** through each individual task in sequence (e.g., perfecting each aim before moving to the next), the Shallow-pass strategy encourages a **shallow, complete pass** over all key components of the project first.
This approach creates a “minimum viable version” of the entire project, akin to a **minimum viable product (MVP)**, and allows for early identification of bottlenecks, feasibility issues, and unknowns.
Once this shallow layer is complete, **depth is added step-by-step** to specific areas where gains are most needed or most valuable. This "depth-first" progression occurs only when justified by clear metrics or emerging insights.

### Execution
1. **Initial pass (shallow path)**: The goal is to complete a simple, end-to-end version of the project with minimal depth. This quick, rough pass identifies critical barriers, risks, and time-sinks. For example, instead of training a deep learning model on a large dataset, you might start with a simple logistic regression on a small subset, or run a pilot experiment to validate feasibility.
2. **Iterative deepening (vertical progression)**: Revisit earlier steps and selectively add depth to areas that yield the most benefit. If an aspect works well at shallow depth, further refinement may be unnecessary. For example, after a successful logistic regression, you might increase depth by training a neural network, scaling up the dataset, or adding multi-modal inputs.
3. **When to stop (completion)**: Avoid the "infinite perfection" trap by setting **success metrics** (e.g., 90% model accuracy) at the outset. Once these criteria are met, stop. If your classifier achieves 95% accuracy when the goal was 90%, additional work may have little value. Completion is defined by sufficiency, not perfection.

### Common pitfalls and how to avoid them

| **Pitfall**                  | **How to avoid**                                                             |
| ---------------------------- | ---------------------------------------------------------------------------- |
| **Going too deep, too soon** | Focus on the shallow pass first. Move on even if the result isn’t “perfect.” |
| **Perfectionism**            | Set "success metrics" early. If you meet them, stop!                         |
| **Sunk cost fallacy**        | Shallow-pass shows which paths are dead ends. Pivot early.                   |
| **Failure to prioritize**    | Invest time in paths that provide the most "return on depth".                |
| **Getting stuck at step 1**  | Even if step 1 is imperfect, keep moving to step 2.                          |
|                              |                                                                              |

## Writing process

### 1. Planning and supervisor coordination
- **Agree on timeline**: Clarify deadlines for draft and final versions.
- **Clarify expectations**: What level of polish should the draft have?
- **Define the review process**: Involve other stakeholders if needed (e.g., senior lab members).
- **Co-design the project**: Discuss aims and approaches early with the supervisor.
- **Accept constraints**: Some projects are pre-defined due to funding calls, and flexibility is limited.
- **Maintain perspective**: The fellowship is often an "academic exercise" — flexibility in practice is often possible once funding is secured.

### 2. Content development

#### Start with the big picture
- Identify the central question or goal.
- **"Walk back" from the goal** to define specific aims, objectives, and the path to achieving them.

#### **Clarity is everything**
- Be simple, clear, and precise. Over-complication weakens the proposal.
- Make abstract concepts **tangible** by showing concrete outputs, metrics, and practical outcomes.

#### Is a hypothesis necessary?
- Hypotheses are not always required, but without one, the proposal may require stronger justification for the work.

### 3. Proposal structure

#### Top-down approach

1. **Hypothesis/Objectives/Goals**
2. **Impact**:
    - Why should this be addressed?
    - What impact will success have (on science, society, policy, etc.)?
    - What will we learn even if the project fails?
3. **Aims**: Typically 2-3 aims.
4. **Tasks for each aim** (1-2 per aim):
    - Goal of the task
    - Why it matters
    - Required resources, data, or inputs
    - Methods, experiments, and tools required
5. **Introduction** (3-4 points):
    1. The problem being addressed.
    2. What has been tried previously.
    3. Key technologies, datasets, or resources now available to address the problem.
    4. A hint of the specific approach you will take.
6. Challenges and mitigation
    - Think of the top challenges in the proposal design.
    - Separate them by conceptual and technical
    - Try to preemptively address them at design stage

### 4. Proposal writing process

#### Gradual, hierarchical writing
- Expand each bullet point into 1-2 sentences in the order that you designed them:
    - Hypothesis/objectives/goals
    - Impact
    - Aims/tasks (very shallowly)
    - Introduction
- Build each section gradually.

#### Figures & visual aids
- **Sketch first**: Draw rough concepts on paper or whiteboard.
- **Collaborate**: Co-sketch ideas with a supervisor or team member.
- **Repurpose existing visuals**: Use (but adapt) figures from previous grants/papers.
- **Preliminary data**: Include early evidence or preliminary results where relevant.

### 5. Use of AI/LLMs (Large Language Models)

#### Dos and Don'ts
- **Don’t outsource the thinking**: AI works best after you've defined a clear structure with bullet points and key ideas.
- **Provide context**: Add as much detail as possible for the AI (including PDFs of previous work).
- **Emphasize priorities**: Explicitly state which points are most important.
- **LLMs are tools, not authors**: You are in control of the ideas, while the AI is a writing assistant.

#### Why use LLMs?
- **Overcome writer's block**: It’s easier to edit text than to create it from scratch.
- **Improve language quality**: English polish can match the top-tier writing of competitive grant applications.
- **Use parallel sessions**: Write in one session and criticize/review in another.

### 6. Feedback process
- **Be open to feedback**: Supervisors may have different perspectives, and their feedback often reflects reviewers' likely reactions.
- **Ask for clarification**: If something feels unfair or unclear, discuss it with the supervisor.
- **Learn from changes**: Understand why edits were made — this is where the learning happens.

## Summary of key takeaways

1. **Designing a project**: Balance feasibility and novelty. Balance profiling (description) and perturbation (causation).
2. **Executing a project**: Use the "square triangle" approach — shallow, fast progress first; deeper, slower progress later.
3. **Writing a proposal**: Work step-by-step, define key objectives first, and address the big picture.
4. **Clarity and structure** are essential for success.
5. **Involve supervisors early** in project design, figure development, and editing.
6. **Leverage LLMs for support**, but control the process.
7. **Learn from feedback** — it's one of the most valuable aspects of the process.


## Additional Resources
