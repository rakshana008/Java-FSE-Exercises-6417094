// AdapterPatternDemo.java

// Target interface representing a media player
interface AudioInterface {
    void play(String format, String fileName);
}

// Concrete implementation that supports only MP3 files
class SimpleMusicPlayer implements AudioInterface {
    public void play(String format, String fileName) {
        if (format.equalsIgnoreCase("mp3")) {
            System.out.println("Now playing MP3 track: " + fileName);
        } else {
            System.out.println("Format not supported: " + format + ". Adapter needed.");
        }
    }
}

// Main class to test the media player
public class AdapterPatternDemo {
    public static void main(String[] args) {
        SimpleMusicPlayer player = new SimpleMusicPlayer();
        player.play("mp3", "beats.mp3");
        player.play("wav", "soundtrack.wav"); // Would require an adapter in real scenario
    }
}
