import NaturalLanguage

/**
 Without specifying a language, the framework will use the default operating system or device language to perform tokenization. However, it is possible to specify the desired language when creating the NSLinguisticTagger object, using the .language option in the options parameter. This will ensure that tokenization is performed according to the linguistic conventions of the specified language. In the case of Brazilian Portuguese, you can specify the language as "pt-BR" when creating the NSLinguisticTagger object.
 */

let text = "Este é um exemplo de um parágrafo."
let tagger = NSLinguisticTagger(tagSchemes: [.tokenType], options: 0)
tagger.string = text

let range = NSRange(location: 0, length: text.utf16.count)
let options: NSLinguisticTagger.Options = [.omitPunctuation, .omitWhitespace]

tagger.enumerateTags(in: range, unit: .word, scheme: .tokenType, options: options) { (tag, tokenRange, _) in
    let word = (text as NSString).substring(with: tokenRange)
    print(word)
}

/**
 This function tokenizes a given string using the Natural Language framework. It creates a NSLinguisticTagger object with the tokenType tag scheme, and sets the string to be tokenized.
 It then sets the range and options for the tagger, and enumerates through the tags in the range, printing out each individual token (word).

- Parameters:
    - text: A string representing the text that will be tokenized

- Returns:
    None
*/
func tokenizeString(text: String) {
    let tagger = NSLinguisticTagger(tagSchemes: [.tokenType], options: 0)
    tagger.string = text

    let range = NSRange(location: 0, length: text.utf16.count)
    let options: NSLinguisticTagger.Options = [.omitPunctuation, .omitWhitespace]

    tagger.enumerateTags(in: range, unit: .word, scheme: .tokenType, options: options) { (tag, tokenRange, _) in
        let word = (text as NSString).substring(with: tokenRange)
        print(word)
    }
}

tokenizeString(text: "Este é mais um exemplo de um parágrafo.")

func tokenizeString(text: String, language: String, completion: (([String]) -> Void)) {
    let tagger = NSLinguisticTagger(tagSchemes: [.tokenType], options: 0)
    tagger.string = text
    tagger.setOrthography(NSOrthography.defaultOrthography(forLanguage: language), range: NSRange(location: 0, length: text.utf16.count))
    let range = NSRange(location: 0, length: text.utf16.count)
    let options: NSLinguisticTagger.Options = [.omitPunctuation, .omitWhitespace]
    var tokens = [String]()
    tagger.enumerateTags(in: range, unit: .word, scheme: .tokenType, options: options) { (tag, tokenRange, _) in
        let token = (text as NSString).substring(with: tokenRange)
        tokens.append(token)
    }
    completion(tokens)
}

tokenizeString(text: "Este é mais um exemplo de um parágrafo.", language: "pt-BR") { tokens in
    print(tokens)
}
