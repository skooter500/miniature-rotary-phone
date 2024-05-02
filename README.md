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
[![YouTube](https://github.com/PanicAtTheKernal/miniature-rotary-phone/assets/98461233/17c84673-4376-4d21-a9a4-f3100aff07c0)](https://www.youtube.com/watch?v=J2kHSSFA4NU](https://youtu.be/qU3tOcJ82fo))

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
| Music | From [Daniel](https://github.com/PanicAtTheKernal/FinalYearProject/tree/main/Assets/Sounds) |
| map.gd | Self-Made |
| ArriveToFlowers.gd | Modified Arrive |
| spawn_butterfly.gd | Self-Made |
| butterfly.gd | Self-Made |
| user_interface.gd | Self-Made |
| Parameters.gd | Self-Made |
| SFX/Music_Slider.gd | Referenced [SliderTutorial](https://www.youtube.com/watch?v=aFkRmtGiZCw&t=44s) |


## Contributions
### Wen Ting Song
I was tasked with the map making, some UI design and butterflies for this portion of the project.
The map was designed by me using a mixture of the godot engine, blender and some free assets to help decorate the map and give it more life.
The butterflies were introduced to elevate the feeling of nature, there were lots of flowers and i felt like some butterflies would bring far more
life to the map as a whole.

The sounds and music were kindly provided by Daniel and I had the pleasure to incorporate it within the map. The night and day button was also dne by me.

### Daniel Kondabarov

### Olabode Balinga
I was tasked with designing the features with the robot. The robot was made using the Blender application, where the design theme was to create a friendly robot inspired by the robot character Bastion from Overwatch. Like with Bastion, the robot is very curious about nature and to show this, the robot was designed to pursue the birds to scan and observe them. The birds, however, will begin to flee once the robot is seen, leading to a chase. 

# References
* Grass_Tutorial: https://www.youtube.com/watch?v=3ftcGTp-Se8&t=144s
