ruby_deck = Deck.create(name: "Ruby", img: "ruby.png")

card_file = File.readlines('./db/rubydeck.txt')
card_file.each_slice(3) do |slice|
  Card.create({question: slice[0].chop, answer: slice[1].chop, deck_id: ruby_deck.id})
end
########################################################################################

chuck_norris_deck = Deck.create(name: "Chuck Norris", img: 'chucknorris.png')
chuck_norris = File.readlines('./db/chuck-norris.txt')
chuck_norris.each do |line|
  line.gsub!("Chuck Norris", "________")
  Card.create({question: line.chop, answer: "Chuck Norris", deck_id: chuck_norris_deck.id})
end

########################################################################################
state_deck = Deck.create(name: "State Capitals", img: 'USA.png')

card_file = File.readlines('./db/state_capitals.txt')
card_file.each_slice(3) do |slice|
  Card.create({question: slice[0].chop, answer: slice[1].chop, deck_id: state_deck.id})
end

########################################################################################

world_deck = Deck.create(name: "World Capitals", img: 'WORLD.png')

card_file = File.readlines('./db/world_capitals.txt')
card_file.each_slice(3) do |slice|
  Card.create({question: slice[0].chop, answer: slice[1].chop, deck_id: world_deck.id})
end

########################################################################################

nato_deck = Deck.create(name: "NATO", img: 'NATO.png')

card_file = File.readlines('./db/NATO_phonetic.txt')
card_file.each_slice(3) do |slice|
  Card.create({question: slice[0].chop, answer: slice[1].chop, deck_id: nato_deck.id})
end


# ########################################################################################

# number_deck = Deck.create(name: "number_deck", img: 'natophoneticalphabet.png')

# card_file = File.readlines('./db/numbers.txt')
# card_file.each_slice(3) do |slice|
#   Card.create({question: slice[0].chop, answer: slice[1].chop, deck_id: number_deck.id})
# end
