# project3
cs541 project3 Ultimate Turtle-Bug-Hero!

This is a simple push-block type game where the object is to get to an objective and push it toward a goal.
In this case, the idea is just to get the block off the screen.  But beware, there are VERY HEAVY obstacle blocks in the way,
(like the yellow blocks), and zipping red blocks that can hamper your efforts.  What is the lowest number of moves you need to
GET THE GREEN OFF THE SCREEN?!

Progress Log
9/23:  Set up repository with default project
9/25: Learned to add images to sprites, and created main custom image.  
         Learned to modify sprite coordinates aka SKSpriteNode coordinates
         Added the ability to center hero on mouseclick
9/27: Added the ability to move sprite objects on click and hold, and/or touchesmoved
        Removed excess codes for unnecessary default objects
9/29: Added new sprite node, and code to move that sprite based on click down. 
9/30: Added greensquare to make a goal
        Added code to make red square move randomly
10/1: Added code to move the green square slightly 
10/2: Coded so that green square resets on encounter of screen edge
10/3: Experimented with SKLabel nodes and counters for tracking score and instructions
        Added code for Yellow square. Experimented with contact detection and collision modifications
        Added updates to Redsquare on continuous time-loop to move across screen at constant rate.
        Added Instructions label to the center of the screen
10/4: Implemented on-screen brown classic d-pad for controlling player.  Enhanced player size.  
        Removed player jump-to-click so that d-pad would be relevant. 
        Added "Moves" counter.
10/6:  Changed physics bodies to allow for rotation on collision by using rectangle bodies
          Modified the friction on the greensquare and the player
          Added two more white buttons to screen.  These will affect rotation when implemented
10/8: Added two new yellow squares. 
          Substantially increased the mass of the yellow squares.
          Rearranged starting positions to add some challenge
          Created a repeating "you win" printed statement when the green square is pushed off screen

10/10: Added a "Randomize" text button to randomly set the start positions of the green and yellow squares.
           Added a "Reset" text button to reset to the original start positions of the green and yellow squares.
10/12/10/13: Added an instructions storyboard screen, and fixed the text label to word wrap and show the instructions.
                    Ensured that "Start the game already!" button loaded the game screen
                    Fixed the Randomize and Reset buttons to also reset the "Moves" counter.
                    
