package HelloConstructor;

/*
    TO TEST CLASS INSTANCES WITH BREAKPOINTS AND STEP OVER/INTO
 */
    public class HelloConstructor {
        public static void main(String[] args) throws InterruptedException {
            Thread.sleep(10000);
            Greeter greeter = new DefaultGreeter();
            greeter.greet();
            greeter = new NamedGreeter("World");
            greeter.greet();
        }
    }



