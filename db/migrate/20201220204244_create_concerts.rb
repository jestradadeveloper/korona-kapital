
class CreateConcerts < ActiveRecord::Migration[6.1]
  def change
    create_enum "enum_ilk", %w[concert meet_n_greet battle]
    create_enum "enum_access", %w[general members vips]

    create_table(:concerts) do |t|
      t.string(:name)
      t.text(:description)
      t.datetime(:start_time)
      t.references(:venue, null: false, foreign_key: true)
      t.text(:genre_tags)
      t.enum :ilk, as: :enum_ilk
      t.enum :access, as: :enum_access
      t.timestamps
    end
  end
end
