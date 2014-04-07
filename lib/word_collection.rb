class WordCollection
  MAX_NUMBER_OF_MATCHES = 25
  attr_accessor :content, :words

  def initialize(content)
    @content = content
    @words = words_with_frequency(@content.downcase.tr("^a-zA-Z0-9 ", "").split(" ").sort)
  end

  def words_with_frequency(a)
    # Swiped this from Stack Overflow
    # http://stackoverflow.com/a/10411802/199712
    Hash[a.inject(Hash.new(0)) { |h, e| h[e] += 1; h }.to_a.sort { |a, b| a[1] <=> b[1] }]
  end

  def matches_with_frequency(stem)
    matches = @words.select { |word, frequency| word =~ /^#{stem}(.*)/ }

    # Put most frequently-occurring words first.
    # http://stackoverflow.com/a/2540473/199712
    matches.sort_by { |k, v| v }.reverse.collect { |match| Hash[[match]] }[0..MAX_NUMBER_OF_MATCHES - 1]
  end

  def matches(stem)
    matches_with_frequency(stem).collect(&:keys).flatten
  end
end
