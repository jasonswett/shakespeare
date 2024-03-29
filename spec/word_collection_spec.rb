require_relative '../lib/word_collection'

describe WordCollection do
  it "can be initialized with a string" do
    content = "some words"
    wc = WordCollection.new(content)

    expect(wc.content).to eq(content)
  end

  describe "#matches_with_frequency" do
    describe "when there is a match" do
      before do
        content = "apple apple apple apricot apricot"
        wc = WordCollection.new(content)
        @matches = wc.matches_with_frequency("a")
      end

      it "includes frequency" do
        expect(@matches.first).to eq({ "apple" => 3 })
      end
    end

    describe "when there is not a match" do
      before do
        content = "some words"
        wc = WordCollection.new(content)
        @matches = wc.matches_with_frequency("zzzz")
      end

      it "includes frequency" do
        expect(@matches).to be_empty
      end
    end

    describe "when there are a lot of matches" do
      before do
        # This generates 100 usually unique (not always but close enough)
        # strings starting with the letter a
        content = Array.new(100) { "a#{rand(10000)}" }.join(" ")

        wc = WordCollection.new(content)
        @matches = wc.matches_with_frequency("a")
      end

      it "limits the number of matches to 25" do
        expect(@matches.length).to eq(25)
      end
    end
  end

  describe "#matches" do
    describe "when there are no matches" do
      before do
        content = "This is the content I'm testing. This is another sentence."
        wc = WordCollection.new(content)
        @matches = wc.matches("asldkf")
      end

      it "returns nothing" do
        expect(@matches.length).to eq(0)
      end
    end

    describe "when multiple words appear multiple times" do
      before do
        content = %Q(
          ear ear ear
          egg egg egg egg
          elk elk
        )
        wc = WordCollection.new(content)
        @matches = wc.matches("e")
      end

      it "puts 'egg' first" do
        expect(@matches.first).to eq("egg")
      end

      it "puts 'elk' last" do
        expect(@matches.last).to eq("elk")
      end

      it "puts 'ear' in the middle" do
        expect(@matches[1]).to eq("ear")
      end
    end

    describe "when there are matches" do
      before do
        content = "This is the content I'm testing. This is another sentence."
        wc = WordCollection.new(content)
        @matches = wc.matches("th")
      end

      it "puts more common words first" do
        expect(@matches[0]).to eq("this")
      end

      it "includes the right number of matches" do
        expect(@matches.length).to eq(2)
      end

      it "excludes non-matches" do
        expect(@matches).not_to include("another")
      end

      it "includes lowercase words" do
        expect(@matches).to include("the")
      end

      it "includes capitalized words" do
        expect(@matches).to include("this")
      end
    end
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
