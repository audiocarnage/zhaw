import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

public class Decoder {

	private static final String filepath = "C:\\Users\\Remi\\Google Drive\\00 Studium\\01 Hauptstudium\\INCO\\Praktika\\";
	//private static final String filepath = "D:\\Google Drive\\00 Studium\\01 Hauptstudium\\INCO\\Praktika\\";
	private int previewBufferSize = 0;
	private int searchBufferSize = 0;
	private String inputFile;
	private String outputFile;
	private String searchBuffer = "";
	private List<String> tokens = new ArrayList<String>();
	
	public Decoder() throws IOException {
		inputFile = filepath + "data_0.lz77";
		outputFile = filepath + "data_0.dec";
		
		startDecoding();
		writeToFile();
		System.out.println("End of processing.");
	}
	
	private void startDecoding() throws IOException {
		System.out.println("LZ77 DECODER\n");
		importTokens();
		printBufferConfiguration();
		//printTokens();
		
		System.out.println("Entering data loop...\n");
		int offset = 0;
		int matchLength = 0;
		String nextChar = "";
		for (String token : tokens) {
			token = token.replaceAll("\\(|\\)", "");
			String[] comp = token.split(";");
			offset = Integer.parseInt(comp[0]);
			matchLength = Integer.parseInt(comp[1]);
			nextChar = comp[2];
			
			if (offset == 0 && matchLength == 0) {
				searchBuffer += nextChar;
			}
			if (matchLength != 0) {
				String matchedChar = searchBuffer.substring((searchBuffer.length() - offset), (searchBuffer.length() - offset + matchLength));
				searchBuffer += matchedChar + nextChar;
			}
		}
		System.out.println("decoded: " + searchBuffer + "\n");
	}
	
	private void importTokens() throws IOException {
		BufferedReader br = new BufferedReader(new FileReader(inputFile));
		tokens.clear();
		String line = "";
		while ((line = br.readLine()) != null) {
			if (line.startsWith("Preview buffer")) {
				previewBufferSize = Integer.parseInt(line.replaceAll("[\\D]", ""));
			} else if (line.startsWith("Search buffer")) {
				searchBufferSize = Integer.parseInt(line.replaceAll("[\\D]", ""));
			} else {
				tokens.add(line);
			}
		}
		br.close();
	}
	
	private void printBufferConfiguration() {
		System.out.println("preview buffer size : " + previewBufferSize + " bytes");
		System.out.println("search buffer size  : " + searchBufferSize + " bytes\n");
	}
	
	private void printTokens() {
		System.out.println("Tokens read:\n");
		for (int i = 0; i < tokens.size(); i++) {
			System.out.println("Token #" + (i+1) + " " + tokens.get(i));
		}
		System.out.println();
	}
	
	private void writeToFile() throws IOException {
		BufferedWriter bw = new BufferedWriter(new FileWriter(outputFile));
		bw.write(searchBuffer);
		bw.close();
	}
	
	public static void main(String[] args) throws IOException {
		new Decoder();
	}
}