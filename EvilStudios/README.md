#EvilStudiosCode

Used a Singleton SoundManager to create a shared Manager Singleton Object which is being passed to the View Controller. 

Constructing the collection of songs/ audio files in songsCollection. 

#SoundManager 
playCurrentSong()- 
Will play all the songs from the audio files pulled from the project Sounds folder. 
and posts a notification with the song name to the View Controller to the Update the song name Label in the UI later. 
sharedManager()- 
creates a singleton SoundManager Object
pauseCurrentSong()- 
if the AVAudioplayer is playing then it will pause the song or else it will continue playing. 
repeatSong()- 
setting the number of loops to a negative number which is -1 in my case so that the audioplayer loops around on the same audio file. 
resumeSong()-
to end the repeat process and setting the numberOfLoops to default value 0. 
computeProgress()- 
calculating the progress of the song to pass it later to a new UI component. 

#ViewController - 

Using NSNotificationCenter, obtaining the current song played from the playCurrentSong() method.

playButton - PlayClicked() plays all the songs one by one. 

pauseButton - Pauses the song and turns its text to Resume to Resume the song.

 
#UI - used a new open source libary to access a custom circular progress view. 
the link to the documentation- https://github.com/matibot/MBCircularProgressBar 

Which provides an easy way to show the progress and interesting ways to customize its color and the value.

