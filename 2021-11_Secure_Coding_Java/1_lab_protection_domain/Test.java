import java.nio.file.Files;
import java.nio.file.Paths;

public class Test {
    public static void main(String[] args) throws Exception {
        String fileName = "output.txt";
        String messageText = "Hello this advertises the features of the security manager";
        // System.out.print(System.getProperty("java.home"));
        Files.write(Paths.get(fileName), messageText.getBytes());
System.out.println("Finished");
    }
}
