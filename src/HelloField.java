/*
    TO TEST CLASS FIELDS (STATIC, FINAL, PRIMITIVE, OBJECT, COLLECTION, ENUMS ETC ETC..)
 */

import java.util.ArrayList;
import java.util.List;

public class HelloField {

    public static String INT_FIELD = "intField";
    public static final String LONG_FIELD = "longField";
    protected final String String_Field = "Fixed Value";

    private char charField;
    private double doubleField;
    private String stringField;

    private int[] arrayField;
    private List listField = new ArrayList<>();

    public static void main(String[] args){
        try {
            Thread.sleep(10000);

        } catch (InterruptedException e) {
            e.printStackTrace();
        }
    }
}



