import NaturalLanguage

let text = "Este é um exemplo de um parágrafo."
let tagger = NSLinguisticTagger(tagSchemes: [.tokenType], options: 0)
tagger.string = text

let range = NSRange(location: 0, length: text.utf16.count)
let options: NSLinguisticTagger.Options = [.omitPunctuation, .omitWhitespace]

tagger.enumerateTags(in: range, unit: .word, scheme: .tokenType, options: options) { (tag, tokenRange, _) in
    let word = (text as NSString).substring(with: tokenRange)
    print(word)
}
