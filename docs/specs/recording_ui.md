# The core structure

## Three buttons in a row:
1. Play teacher's pronunciation
2. Play user's pronunciation (Either play button or slot for the button)
3. Record user's pronunciation

### Teacher's play button's states:
 
1. Idle - shows play button
2. Playing shows equalizer, disables the click listener

### User's pronunciation (middle buttons)'s states:
1. Empty - shows dotted circle as a slot when there is no recording
2. Has recording but idle - shows Play button 
3. Playing - Shows equalizer

### Record button's states
1. Idle - shows microphone button
2. Recording - shows stop icon - stops and saves the recording when clicked


# Technical
* When swiping away both recording and playback should be cancelled.
* Use same player manager to avoid playing multiple things at once.