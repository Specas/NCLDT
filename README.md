# NCLDT - Non Cooperative Locally Dynamic Trees
NCLDT is a novel path planning algorithm that uses multiple spawning trees to find a collision free path to the goal location. It aims to solve the narrow passage problem in a more sample efficient manner.

## The algorithm

NCLDT uses a tree based approach, but unlike RRT, it spawns and grows multiple trees. The individual trees then connect together to reach the goal state.

### Dynamic trees

When a root node of a tree is sampled, its children are not sampled randomly in space. Instead, they are sampled in biased directions, that depend on the goal and root positions. This enables the trees to grow towards the goal while also being able to actively avoid obstacles in its path. The growth sampling is probabilistically modeled, such that the ability to maneuver through the cluttered space is maximized.

### The multi tree model

The algorithm first spawns multiple tree nodes through radial bias sampling centered at the start position. The following steps are then followed:

* Each tree is given an energy value, and at each iteration, is grown depending on this value.
* If the energy value is below a certain threshold, the tree is decayed.
* Each tree is dynamic, and given the right conditions, can grow around obstacles.
* More trees may be spawned depending on the energies of the existing trees. If most of the trees are decaying, the next iteration would see a lot more new tree roots being spawned.
* The problem is solved when a set of trees that connect the start to the end configuration is found.

### Narrow passage problem

The dynamically growing trees, help deal with narrow passages in the planning space. Given a tree root position that is favourable, it will almost always find its way out of the narrow passage. Trees on either side of the passage would then be able to form a valid path.

The narrow passage problem gets nastier in higher dimensions due to the set of valid sample points in the space becoming more sparse. Naive probabilistic approaches would take longer to find solutions, whereas NCLDT would only need a single favourable spawn to find a path through the passage.

### Theoretical guarantees

The algorithm is probabilistically complete, as in the trivial case the trees aren't grown after spawning and the root nodes serve as regular RRT sampled points. RRT being probabilistically complete implies that NCLDT is too.

## Results

Results for a two dimensional configuration space containing obstacles are shown below:

### Dynamic trees
<p align="center">
<img src="https://drive.google.com/uc?export=view&id=10HtPxD481BdC3KtoDZymud2qYby8DsW-" alt="tree 1" width="600" />
</p>

<p align="center">
<img src="https://drive.google.com/uc?export=view&id=1_0ih30vUUF_iuHwX1XFr1xx1KdJCytq7" alt="tree 2" width="600" />
</p>

### Single tree narrow passage

<p align="center">
<img src="https://drive.google.com/uc?export=view&id=1MkYqPlFPn6wn5kL_uTcYMlMSgajv4uLG" alt="narrow passage" width="600" />
</p>

### Multi tree solution

<p align="center">
<img src="https://drive.google.com/uc?export=view&id=1Y-0p43AsftZNJ2LAZrKLp0qrWtfcRKCg" alt="multi tree" width="600" />
</p>
