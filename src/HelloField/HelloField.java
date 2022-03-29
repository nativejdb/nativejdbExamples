package HelloField;/*
    TO TEST CLASS FIELDS (STATIC, FINAL, PRIMITIVE, OBJECT, COLLECTION, ENUMS ETC ETC..)
 */

import java.util.ArrayList;
import java.util.List;

public class HelloField {
    public static int INT_FIELD = 3;
    protected static final String STRING_FIELD = "QUARKUS";

    private static int[] arrayField;
    private static List listField = new ArrayList<String>();

    public static void main(String[] args){
        while (true) {

            arrayField = new int[2];
            arrayField[0] = INT_FIELD;
            listField.add(STRING_FIELD);

            String printS = listField.get(0) + "is fun x " + arrayField.length;

            System.out.println(printS);
        }
    }
}



