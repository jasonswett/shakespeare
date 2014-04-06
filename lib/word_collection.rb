class WordCollection
  attr_accessor :content, :words

  def initialize(content)
    @content = content
    @words = words_with_frequency(@content.split(" ").sort)
  end

  def words_with_frequency(a)
    # Swiped this from Stack Overflow
    # http://stackoverflow.com/a/10411802/199712
    Hash[a.inject(Hash.new(0)) { |h, e| h[e] += 1; h }.to_a.sort { |a, b| a[1] <=> b[1] }]
  end

  def matches(stem)
    []
  end
end
