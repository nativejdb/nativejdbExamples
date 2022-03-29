package HelloConstructor;

public class NamedGreeter extends Greeter {
    private String name;

    public NamedGreeter(String name) {
        this.name = name;

    }

    public void greet() {
        System.out.println("Hello " + name);
    }

}