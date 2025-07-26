public with sharing class UtilityMethods {

    public static Boolean checkIfStringContainsAlphabetsOnly( String str ){
        Set<String> alphabets = new Set<String>{'a','b','c','d','e','f','g','h','i','j','k','l','m','n','o','p','q','r','s','t','u','v','w','x','y','z',' '};
        str = str.toLowerCase();

        for( Integer i = 0; i < str.length();i++ ){
            String ch = str.substring(i,i+1);

            if (!alphabets.contains(ch)) {
                return false;
            }
        }

        return true;
    }

}