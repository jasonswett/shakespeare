require_relative '../lib/word_collection'

describe WordCollection do
  it "can be initialized with a string" do
    content = "some words"
    wc = WordCollection.new(content)

    expect(wc.content).to eq(content)
  end

  describe "#words_with_frequency" do
    it "puts the content in a hash" do
      content = "hello world"
      word_array = content.split(" ").sort
      wc = WordCollection.new(content)

      expect(wc.words_with_frequency(word_array)).to eq({"hello" => 1, "world" => 1})
    end
  end

  it "counts the frequency of each word" do
    content = "words words bla bla bla"
    wc = WordCollection.new(content)

    expect(wc.words).to eq({"words" => 2, "bla" => 3})
  end

  describe "#words_that_start_with" do
    before do
      @wc = WordCollection.new("This is a sentence that contains some words.")
    end

    it "returns an empty array if there are no matches" do
      expect(@wc.matches("xz").length).to eq(0)
    end
  end
end
