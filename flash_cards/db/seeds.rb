ruby_deck = Deck.create(name: "ruby_deck", img: "ruby.png")

card_file = File.readlines('./db/rubydeck.txt')
card_file.each_slice(3) do |slice|
  Card.create({question: slice[0].chop, answer: slice[1].chop, deck_id: ruby_deck.id})
end

chuck_norris_deck = Deck.create(name: "chuck_norris", img: 'chucknorris.png')
chuck_norris = File.readlines('./db/migrate/chuck-norris.txt')
chuck_norris.each do |line|
  line.gsub!("Chuck Norris", "________")
  Card.create({question: line, answer: "Chuck Norris", deck_id: chuck_norris_deck.id})
end
