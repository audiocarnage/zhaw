import java.math.*;
/**
 * @author Rémi Georgiou 
 * @version 1.0
 */
public class Fibonacci {
    
    public Fibonacci(int n) {
        for (int i=0; i <= n; i++) {
            System.out.println(i + ": " + fibonacciIterativ(i));
        }
    }
    
    private long fibonacciRekursiv(int n) {
        if (n <= 2) {
            return 1;
        } else {
            return fibonacciRekursiv(n-1) + fibonacciRekursiv(n-2);
        }
    }
    
    private BigInteger fibonacciIterativ(int n) {
        if (n <= 2) {
            return new BigInteger("1");
        } else {
            BigInteger f1 = new BigInteger("1");
            BigInteger f2 = new BigInteger("1");
            BigInteger fn = new BigInteger("0");
            for (int i = 2; i < n; i++) {
                fn = f1.add(f2);
                f1 = f2;
                f2 = fn;
            }
            return fn;
        }
    }
    
    public static void main(String[] args) {
        new Fibonacci(50);
    }
}