# Kappenball

A simple iOS game app written as part of my fourth year assignment for the **Software Development for Mobile Devices**
module at the University of Sheffield.

## Game Background
Kappenball is an iOS game app that has one main objective: direct the green Kappenball into one of the three goal areas
at the bottom of the game screen. Each time the Kappenball has successfully entered the goal, a point is awarded.

There is also an energy expended score associated to each point you scored - such energy score contributes to the
average energy expended over each successful scoring attempt; the idea is that the smaller amount of energy you have
expended, in addition to the number of points you scored, the better.

The amount of energy you expend on average is likely to increase with the strength of the random force applied to the Kappenball,
which has an effect on its sideway motion. The strength of the random force may be controlled by adjusting the slider
near the bottom right of the game screen.

When the strength of the random force is high, it is typically better to wait until the Kappenball is near the goal before
expending energy, explaining why the short description of the repository claims that the game models
the mathematical notion of procrastination.

## How To Play
To play the game, you need at least a Macintosh with XCode installed. Given that you meet these requirements,
simply clone this repository and load the Xcode project up and play this via the **iPhone 6s Plus** Simulator. Or better still,
if you have an **iPhone 6s Plus**, plug it into your Macintosh, install the game through XCode and play the game in
your physical device.

Once you have loaded up the game, to control the sideway motion of the Kappenball, tap to the left of the falling Kappenball
to nudge it to the right or tap to the right to nudge it to the left. Note that tapping multiple times (say three times to the
left of the Kappenball) will increase the sideway speed of the Kappenball towards the other direction (i.e. to the right in
my given example).

To control the strength of the random force (which affects how much the Kappenball wobbles around horizontally), adjust the slider
near the bottom right of the game screen. To pause/resume the game, simply press the pause/resume button.

Currently, the **iPhone 6s Plus** (or any other iPhone with the same screen size) is the only phone which the game guarantees
to work correctly. I'm aware that this is a silly limitation, but I may do extension work on this (in addition to many other
improvements, such as pausing the game when you sent the app to the background...) so that it works on devices of all screen sizes.
All I can say for now is watch this space!
