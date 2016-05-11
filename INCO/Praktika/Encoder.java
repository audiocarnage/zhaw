import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.List;
import java.util.ArrayList;

public class Encoder {
	
	private static final String filepath = "C:\\Users\\Remi\\Google Drive\\00 Studium\\01 Hauptstudium\\INCO\\Praktika\\";
	//private static final String filepath = "D:\\Google Drive\\00 Studium\\01 Hauptstudium\\INCO\\Praktika\\";
	private static String input = "";
	private String inputFile;
	private String outputFile;
	private static final int PREVIEWBUFFERSIZE = 32;
	private static final int SEARCHBUFFERSIZE = 1024;
	private String previewBuffer = "";
	private String searchBuffer = "";
	private List<String> tokens = new ArrayList<String>();
	
	public Encoder() throws IOException {
		inputFile = filepath + "data_2.txt";
		outputFile = filepath + "data_2.lz77";
		
		getInput();
		getPreviewBuffer();
		startEncoding();
		writeTokensToFile();
		System.out.println("End of processing.");
	}
	
	private void startEncoding() throws IOException {
		tokens.clear();
		clearOutputFile();
		System.out.println("LZ77 ENCODER\nEntering data loop...\n");
		
		// write first token
		printToken(0, 0, Character.toString(previewBuffer.charAt(0)));
		searchBuffer += Character.toString(previewBuffer.charAt(0));
		previewBuffer = previewBuffer.substring(1);
		//printBuffers();
		getPreviewBuffer();
				
		while (previewBuffer.length() > 0) {
			int offset = 0;
			int matchLength = 0;
			String nextChar = "";
			int searchBufferMatchIndex = searchBuffer.lastIndexOf(previewBuffer.charAt(0), (searchBuffer.length()));
					
			if (searchBufferMatchIndex == -1) {
				// keine Uebereinstimmung			
				nextChar = Character.toString(previewBuffer.charAt(0));
				searchBuffer += Character.toString(previewBuffer.charAt(0));
				previewBuffer = previewBuffer.substring(1);
				getPreviewBuffer();
			} else {
				// mindestends eine Uebereinstimmung
				String bestMatch = "";
				int matchedIndex = searchBuffer.lastIndexOf(Character.toString(previewBuffer.charAt(0)), searchBuffer.length()-1);
				while (matchedIndex > -1 && previewBuffer.length() > 1) {
					bestMatch += Character.toString(previewBuffer.charAt(0));
					matchLength++;
					offset = searchBuffer.length() - searchBuffer.lastIndexOf(bestMatch, searchBuffer.length()-1);
					nextChar = Character.toString(previewBuffer.charAt(1));	
					previewBuffer = previewBuffer.substring(1);
					matchedIndex = searchBuffer.lastIndexOf(bestMatch + nextChar, searchBuffer.length()-1);
				}
				previewBuffer = previewBuffer.substring(1);
				searchBuffer += bestMatch + nextChar;
				getPreviewBuffer();
			}
			printToken(offset, matchLength, nextChar);
			//printBuffers();
		}
	}
	
	private void printToken(int offset, int matchLength, String nextChar) {
		String token = "(" + offset + ";" + matchLength + ";" + nextChar + ")";
		tokens.add(token);
		System.out.println("Token #" + tokens.size() + " " +  token);
	}
	
	private void writeTokensToFile() throws IOException {
		BufferedWriter bw = new BufferedWriter(new FileWriter(outputFile));
		bw.write("Preview buffer size: " + PREVIEWBUFFERSIZE + "\n");
		bw.write("Search buffer size: " + SEARCHBUFFERSIZE + "\n");
		for (String token : tokens) {
			bw.write(token + "\n");
		}
		bw.close();
	}
	
	private void getInput() throws IOException {
		BufferedReader br = new BufferedReader(new FileReader(inputFile));
		StringBuilder sb = new StringBuilder();
		String line = "";
		while ((line = br.readLine()) != null) {
			sb.append(line);
		}
		sb.append("\0");
		input = sb.toString();
		br.close();
	}
	
	private void getPreviewBuffer() throws IOException {
		while (previewBuffer.length() < PREVIEWBUFFERSIZE && !input.isEmpty()) {
			previewBuffer += input.charAt(0);
			previewBuffer.replaceAll("\\r|\\n", "");
			input = input.substring(1);
		}
	}
	
	private void clearOutputFile() throws IOException {
		BufferedWriter bw;
		bw = new BufferedWriter(new FileWriter(outputFile, true));
		bw.write("");
		bw.close();	
	}
	
	private void printBuffers() {
		System.out.println("search buffer  : " + searchBuffer);
		System.out.println("preview buffer : " + previewBuffer + "\n");
	}
	
	public static void main(String[] args) throws IOException {
		new Encoder();
	}
}