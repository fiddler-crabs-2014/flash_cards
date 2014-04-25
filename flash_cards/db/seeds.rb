ruby_deck = Deck.create(name: "ruby_deck")

card_file = File.readlines('./db/rubydeck.txt')
card_file.each_slice(3) do |slice|
  Card.create({question: slice[0].chop, answer: slice[1].chop, deck_id: ruby_deck.id})
end
