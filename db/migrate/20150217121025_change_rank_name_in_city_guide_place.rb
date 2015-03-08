class ChangeRankNameInBlackBookPlace < ActiveRecord::Migration
  def change
  	rename_column(:black_book_places, :rank, :position)
  end
end
