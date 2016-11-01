import java.util.List;
import java.util.ArrayList;

/**
 * Write a description of class Heron here.
 * 
 * @author (your name) 
 * @version (a version number or a date)
 */
public class Heron {
    private double zahl = 0;
    private int zaehler = 0;
    private double schaetzung = 0;
    private List<Double> xi = new ArrayList<Double>();
    private double limit = 0;
    
    public Heron(double zahl, double schaetzung, double limit) {
        this.zahl = zahl;
        this.schaetzung = schaetzung;
        this.limit = limit;
        System.out.println(heronVerfahren());
    }
    
    private double heronVerfahren() {
        xi.add(zahl);
        xi.add(newtonVerfahren(zaehler));
        zaehler = xi.size()-1;
        while (Math.abs((xi.get(zaehler) * xi.get(zaehler))-zahl) > limit) {
            xi.add(newtonVerfahren(zaehler));
            zaehler++;
        }
        return xi.get(zaehler);
    }
    
    private double newtonVerfahren(int zaehler) {
        return (xi.get(zaehler)/2) + (zahl/(2*xi.get(zaehler)));
    }

    public static void main(int zahl) {
        new Heron(zahl, 1, Math.pow(10,-12));
    }
}