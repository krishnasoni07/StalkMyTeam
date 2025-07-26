public with sharing class ReasonLength {
    public class StringWrapper{
        @InvocableVariable
        public Boolean isHundredWords;
    }
        
    @InvocableMethod(label='Check if String Has 100 Words')
    public static List<StringWrapper> testReasonWordsCount(List<String> inputList) {
        List<StringWrapper> results = new List<StringWrapper>();

        for (String str : inputList) {
            StringWrapper output = new StringWrapper();

            if (String.isBlank(str)) {
                output.isHundredWords = false;
            } else {
                str = str.trim().replaceAll('\\s+', ' ');
                Integer wordCount = str.split(' ').size();
                System.debug( wordCount );
                output.isHundredWords = (wordCount >= 100);
            }

            results.add(output);
        }

        return results;
    }
}