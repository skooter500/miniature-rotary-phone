# Birds, Butterflies and Robot

## Team Members:
Daniel kondabarov C20456964

Olabode Balinga C20478706

Wen Ting Song C20325896

Class Group: TU856

# Description
Birds, Butterflies and Robot is a team project that showcases the simplicity yet intricate wonders and beauty of nature,
In this simulation, the user can observe a small island with lifeforms  such as butterflies that float and wander the island seeking nearby flowers, birds that 
soar through the skies enjoying the winds and finally a curious robot fascinated by these living beings all whilst listening to a beautiful melody.

The simulation allows many customisations in the UI including how many butterflies to spawn, the birds wing size, their speed, night or day, volume control and much more.

## Video:

[![YouTube](http://img.youtube.com/vi/J2kHSSFA4NU/0.jpg)](https://www.youtube.com/watch?v=J2kHSSFA4NU)

## Screenshots
![image](https://github.com/PanicAtTheKernal/miniature-rotary-phone/assets/98461233/6b71848a-c5c4-4fe6-bf9e-e192cab1d180)
![image](https://github.com/PanicAtTheKernal/miniature-rotary-phone/assets/98461233/52be68c4-41e2-4231-bef1-7ea87e5e9d46)
![image](https://github.com/PanicAtTheKernal/miniature-rotary-phone/assets/98461233/33d94cab-c71f-4c03-84df-c7556224ef33)
![image](https://github.com/PanicAtTheKernal/miniature-rotary-phone/assets/98461233/d4ea7154-983b-47f2-8949-864556f8c6e8)
![image](https://github.com/PanicAtTheKernal/miniature-rotary-phone/assets/98917947/e975d0a1-f320-4058-a6f3-d8a6c2fd8a94)



# Instructions
Use the WSAD keys to move the camera around

Press Shift to hide or use mouse cursor

Interact with the UI to spawn butterflies, birds etc

You can configure various settings from the UI to see how different values change the simulation


# How it works
### Butterfly
The butterflies works by inheriting several nodes provided the forked repo that facilitates several behaviours,
these include Wander, Avoidance, NoiseWander, Constrain and a modified Arrive called ArriveToFlowers. These behaviours enable
the butterflies to simply fly around in a contrained space, they avoid obstacles such as the ground and they seek out flowers on the map.

The arrive function tells the butterflies to arrive to the various flowers located on the map, a timer is used to tell the butterflies to find a different flower every 15 seconds
to simulate how butterflies behave, always looking for different flowers.

The animation of the wings flapping is done using a sin wave that manipulates the rotation and the Y axis of the butterfly's wings and body
to simulate the quick flapping of wings a butterfly would do in real life.

### Birds
#### Wings
The wings are animated using a sine wave where the vertical shift and the amplitude are interpolated between 1 and -1. This creates an effect where the wings are flapping, similar to how a bird flaps their wings. There is a defined wind direction and threshold. If the bird is facing in the direction of the wind or facing down, the wing will go into a glide state. This creates a nice effect where the birds aren't constantly flapping their wings, giving them a more natural behaviour. The wings have three states: flapping, gliding and slowdown. The flapping state has the wings flapping up and down, whereas the gliding state, where the wing is down to mimic a bird gliding, and the slowdown state, where the bird's wings are up to mimic how birds have the wings up to apply to drag to themselves to slow down while landing. The wings are created using procedural geometry, and the mesh is updated for every frame using ImmediateMesh. The [Godot docs](https://docs.godotengine.org/en/stable/tutorials/3d/procedural_geometry/immediatemesh.html) state that ImmediateMesh is the most efficient for creating meshes every frame, which is why it's used. To create the procedural mesh, the vertices, normals, and uv need to be defined in each frame. There is a parameter called num_of_points, which is plotted against the sine wave. These points are used to create each wing segment. The eight corners that make up a segment are done using two points from the sine wave where a thickness and width offset is applied. Only the front, back, top and bottom faces are created since the camera can't see the side faces in each segment. When the last point of the sine wave is reached, a pointy effect is created by not having the last point offset the thickness. 

#### Body Animation
This is a basic script that controls the wings and also defines two different tweens, which interpolate the body parts into specific positions and rotations. The states are walking, where the bird's head is up and the wings are retracted, and flying, where the bird's wings are extended and the body is brought up in line with the head. 

#### Custom Steering
The ground wander steering is just a modified jitter wander script with the y-axis zeroed out. This is used for the birds on the ground since birds move in random directions on the ground. The avoidance script was also modified with a new force direction called ground, which is just the normal force direction but with the y-axis also zeroed out.  

#### UI
Three custom UI nodes were created: a dropdown, a slider and a button. Each UI node is a custom scene containing said UI node and a label along with spacing containers like an hbox or margin container. Using the @tool, the scene was made to feel like a custom node, where the text property of the label gets updated through the root node. The scene has three parameters set up, which are used to emit a signal. The parameters are signal name, node name and property name. The signal name corresponds to one in parameter.gd. The crow has a logic setup to listen to the signal and use the property and node name to adjust the value of the property.

#### States
Birds transition between five different states. The default state is the flock. A stamina system was created where the birds' stamina drains while they are flying, and then they can recharge by descending onto the ground. 
Flock state: This state aims to have the birds fly around in the sky and flock with neighbouring birds. It also includes obstacle avoidance to ensure the birds don't hit any trees. This state has separation, allignment, cohesion, harmonic, noise wander, constrain, avoidance, and flee behaviours enabled. 
Descend state: This state is activated from the flock state when the bird's stamina reaches zero. A random landing spot is assigned to the spot, and using the arrive steering behaviour, the bird descends. This state has constrain, arrive, avoidance, and flee behaviours enabled. 
- Land state: This landing state activates when the bird gets close to the ground. In this state, avoidance is set to incident, which causes a force that levels out the bird. When the bird's collider hits the ground, it transitions to a walking state. This state has avoidance and arrive behaviours enabled.
- Ground state: When the bird lands, the bird begins to wander on the ground. It has obstacle avoidance enabled to have the bird to avoid the walls and the pond. While on the ground, the bird's stamina begins to recharge. This state has ground wander, avoidance, and flee enabled.
- Take off state: When the bird's stamina recharges, or the robot is near it, it begins to fly up into the sky to a certain height. It transitions to the flying state by flapping its wings. Once it reaches that height, it enters the flocking state. This state has the arrive behaviour enabled.

### Robot
Robot works similarly like with the butterflies, it implements the Wander, Avoidance, NoiseWander and Constrain nodes into the robot node. It additionally, uses the pursue node that is used to pursue birds if they exist within the scene. There are two different "states" for the robot, which involve the wander that simply moves around the map if they are no birds, noted by a blue glow on its eye. The other "state" is the pursue state, noted by a pink glow on its eye. This will enable the pursue behavior and set it to the first bird in the scene and disable the constrain behavior, allow the robot to freely roam around. When at the pursue state, a red exclamation mark will briefly appear on the robot, alerting that it has found a bird. This is done using timers and boolean to check for this state, allowing for the pursuing of birds to occur. If the robot, locates a bird and is around a certain distance for around 10 seconds, it switches to the next bird by incrementing the index.

# List of classes/assets
Assets for the bird, butterfly and robot were all self-made in the godot engine or blender. The map is made using a godot meshes and was decorated using
assets provided by low_poly_stylized_nature_pack from sketchfab. The grass resource was self made using blender but a tutorial was followed in from Grass_Tutorial.

The majority of the scripts were self-made or were referencing and modfying some scripts provided within the miniature-rotatry-phone folder.
| Class/asset | Source |
|-----------|-----------|
| low_poly_stylized_nature_pack (Trees, Rocks and Flowers | From [SketchFab](https://sketchfab.com/3d-models/low-poly-stylized-nature-pack-9c773e846c6e4448b26b2cdecb2b91bf) |
| AllFreeSky | From [Godot Asset Libary](https://godotengine.org/asset-library/asset/579) |
| Music | From [Daniel's FYP](https://github.com/PanicAtTheKernal/FinalYearProject/tree/main/Assets/Sounds) |
| map.gd | Self-Made |
| ArriveToFlowers.gd | Modified Arrive |
| spawn_butterfly.gd | Self-Made |
| butterfly.gd | Self-Made |
| user_interface.gd | Self-Made |
| Parameters.gd | Self-Made |
| SFX/Music_Slider.gd | Referenced [SliderTutorial](https://www.youtube.com/watch?v=aFkRmtGiZCw&t=44s) |
| BirdSound | Self-Made |
| BodyAnimation | Self-Made |
| GroundWander | Modified Wander |
| Stamina | Self-Made |
| WingsLines | Self-Made |
| WingScript | Self-Made |
| Murder | Self-Made |
| SceneSetup | Self-Made |
| BirdGlobalState | Self-Made |
| DescendToGroundState | Self-Made |
| FlockState | Self-Made |
| State | Modified State |
| Avoidance | Modified Avoidance |
| GroudnState | Self-Made |
| LandState | Self-Made |
| TakeOffState | Self-Made |
| Bird | Self-Made |
| Ground | Self-Made |


## Contributions
### Wen Ting Song
I was tasked with the map making, some UI design and butterflies for this portion of the project.
The map was designed by me using a mixture of the godot engine, blender and some free assets to help decorate the map and give it more life.
The butterflies were introduced to elevate the feeling of nature, there were lots of flowers and i felt like some butterflies would bring far more
life to the map as a whole.

The sounds and music were kindly provided by Daniel and I had the pleasure to incorporate it within the map. The night and day button was also dne by me.

### Daniel Kondabarov
I was tasked with creating the bird, which comprises the wings animation, the body, the bird UI, the sound effects and the state machine. I'm most proud of the wings. It was really fun to learn about procedural geometry. When the bird is flying in, and the birds transition between gliding and flapping, it feels realistic compared to how birds flap their wings. I learned about procedural geometry and discovered new ways of using the @tool to create nodes that update in the editor

### Olabode Balinga
I was tasked with designing the features with the robot. The robot was made using the Blender application, where the design theme was to create a friendly robot inspired by the robot character Bastion from Overwatch. Like with Bastion, the robot is very curious about nature and to show this, the robot was designed to pursue the birds to scan and observe them. The birds, however, will begin to flee once the robot is seen, leading to a chase. 

# References
* Grass_Tutorial: https://www.youtube.com/watch?v=3ftcGTp-Se8&t=144s
* Procedural Geometry Tutorial: https://docs.godotengine.org/en/stable/tutorials/3d/procedural_geometry/immediatemesh.html
* 3D Tutorial: https://docs.godotengine.org/en/stable/tutorials/3d/using_transforms.html
