GENRES = [
  "Adult Contemporary",
  "Alternative Rock",
  "Arena Rock",
  "British Invasion",
  "Bubblegum Pop",
  "Dance Pop",
  "Gothic Metal",
  "Grunge",
  "Hair Metal",
  "Hard Rock",
  "Indie Rock",
  "Metal",
  "New Wave",
  "Pop/Rock",
  "Power Pop",
  "Progressive Rock",
  "Punk",
  "Rock & Roll",
  "Singer/Songwriter",
  "Soft Rock",
  "Steampunk",
  "Surf"
].freeze
VENS = [
  "Western New Mexico College",
  "North Wisconsin College",
  "Ritchie Academy"
].freeze

ActiveRecord::Base.transaction do
  Ticket.delete_all
  Gig.delete_all
  Concert.delete_all
  Band.delete_all
  Venue.delete_all

  User.create!(
    full_name: "Ticket Hoarder",
    email: "jose.estrada.madera@gmail.com",
    password: "hoarder"
  )

  venues = Array.new(10).map do
    Venue.create!(
      name: VENS.sample,
      rows: [20, 25, 30, 25, 40, 45, 50].sample,
      seats_per_row: [10, 10, 12, 15, 20].sample
    )
  end
  bands = Array.new(5).map do
    b = Band.find_or_create_by(name: ["The Killers", "Carla Morrison", "Taylor swift", "Lana del Rey", "Billy ILISH"].sample)
    b.update(
      description: "Lorem itsum lorem itsmu",
      genre_tags: GENRES.sample((1..5).to_a.sample).join(",")
    )

    b
  end
  start_date = 30.days.from_now.beginning_of_day
  end_date = 35.days.from_now.beginning_of_day
  days = (start_date.to_date..end_date.to_date).to_a
  hours = [13, 15, 17, 19, 21]
  ilk = %w[concert concert concert meet_n_greet battle]
  access = %w[general general general general members vips]

  Array.new(5).each do
    date = days.sample
    concert = Concert.create!(
      description: "Lorem Itsum concert lorem lorem",
      start_time: date + hours.sample.hours,
      venue: venues.sample,
      ilk: ilk.sample,
      access: access.sample,
      name: "Lorem Name"
    )

    [1, 1, 1, 2, 2, 3].sample.times do |i|
      concert.gigs.create(
        band: bands.sample,
        order: i,
        duration_minutes: [30, 60, 60, 60, 90].sample
      )
    end

    concert.update(
      genre_tags: concert.bands.flat_map(&:genres).uniq.join(",")
    )

    concert.venue.rows.times do |row_number|
      concert.venue.seats_per_row.times do |seat_number|
        ticket = concert.tickets.create!(
          row: row_number + 1,
          number: seat_number + 1,
          status: %w[purchased unsold].sample
        )
        ticket.update(user: User.hoarder) if ticket.purchased?
      end
    end
  end
end
