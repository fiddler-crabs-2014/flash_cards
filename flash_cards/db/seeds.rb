ruby_deck = Deck.create(name: "ruby_deck", img: "ruby.png")

card_file = File.readlines('./db/rubydeck.txt')
card_file.each_slice(3) do |slice|
  Card.create({question: slice[0].chop, answer: slice[1].chop, deck_id: ruby_deck.id})
end
########################################################################################

chuck_norris_deck = Deck.create(name: "chuck_norris", img: 'chucknorris.png')
chuck_norris = File.readlines('./db/chuck-norris.txt')
chuck_norris.each do |line|
  line.gsub!("Chuck Norris", "________")
  Card.create({question: line, answer: "Chuck Norris", deck_id: chuck_norris_deck.id})
end

########################################################################################
state_deck = Deck.create(name: "state_deck")

card_file = File.readlines('./db/state_capitals.txt')
card_file.each_slice(3) do |slice|
  Card.create({question: slice[0].chop, answer: slice[1].chop, deck_id: ruby_deck.id})
end

########################################################################################

world_deck = Deck.create(name: "world_deck")

card_file = File.readlines('./db/world_capitals.txt')
card_file.each_slice(3) do |slice|
  Card.create({question: slice[0].chop, answer: slice[1].chop, deck_id: world_deck.id})
end

########################################################################################

NATO_deck = Deck.create(name: "NATO_deck")

card_file = File.readlines('./db/NATO_phonetic.txt')
card_file.each_slice(3) do |slice|
  Card.create({question: slice[0].chop, answer: slice[1].chop, deck_id: NATO_deck.id})
end
