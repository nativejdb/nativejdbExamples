/*
    TO TEST CLASS INSTANCES WITH BREAKPOINTS AND STEP OVER/INTO
 */
    abstract class Greeter {
        public abstract void greet();

    }


    class DefaultGreeter extends Greeter {
        public void greet() {
            System.out.println("Hello World!");

        }

    }

    class NamedGreeter extends Greeter {
        private String name;

        public NamedGreeter(String name) {
            this.name = name;

        }

        public void greet() {
            System.out.println("Hello " + name);
        }

    }

    public class HelloGreeterConstructor {
        public static void main(String[] args) throws InterruptedException {
            Thread.sleep(10000);
            Greeter greeter = new DefaultGreeter();
            greeter.greet();
            greeter = new NamedGreeter("World");
            greeter.greet();
        }
    }



