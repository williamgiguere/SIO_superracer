part of super_racer;

//J'ai essayé ici d'introduire la musique quand on clique sur le start game mais
//j'ai aucune idée comment faire ça.
//L'exemple est tiré de http://practicaldart.wordpress.com/


void addSound(Element element) {
  AudioContext audioContext = new AudioContext();

  // async request for the wave file
  XMLHttpRequest xhr = new XMLHttpRequest();
  xhr.open("GET", "media/map1.ogg", true);
  xhr.responseType = "arraybuffer";
  xhr.on.load.add((e) {
    // asynchronous decoding
    audioContext.decodeAudioData(xhr.response, (buffer) {
      // Success Callback

      // define function to play the sound
      doPlaySound() {
        AudioBufferSourceNode source = audioContext.createBufferSource();
        source.connect(audioContext.destination, 0, 0);
        source.buffer = buffer;
        source.noteOn(0);
      }

      // add the doPlaySound invocation to the click event handler
      element.on.click.add((_) {
        doPlaySound();
      });

    }, (error) {
      // Error Callback
      print('Error decoding OGG file');
    });

  });

  xhr.send();
}