package fib;

public class Fib {
	int n = 0;

	public Fib(int n){
		this.n = n;
	}

	int result() {
		System.out.println("n is " + n);
		if (n <= 1) {
			return n;
		}
		int a = new Fib(n-1).result();
		int b = new Fib(n-2).result();
		int res = a + b;
		return res;
	}

	public static void main(String args[]) {
		try {
			Thread.sleep(1000);
			int result = new Fib(3).result();
			System.out.println("The result is: " + result);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

}
