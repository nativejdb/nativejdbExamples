package HelloMethod;

/*
    TO TEST INNER METHOD CALLS WITH BREAKPOINTS AND STEP OVER/INTO
 */
public class HelloMethod {
        public static void main(String[] args) {
                try {
                        Thread.sleep(10000);
                        for (int j = 0; j < 10000; j++) {
                          hello(j);
                        }
                } catch (Exception e) {
                        e.printStackTrace();
                }
        }

        private static String hello(String line) {
                return line;
        }

        private static  String hello(int i) {
                String myString = "Hello.Hello Method Method" + i;
                return hello(myString);
        }
}