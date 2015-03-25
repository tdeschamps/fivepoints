class ChangeCityGuideIdToBlackBookId < ActiveRecord::Migration
  
  def change
  	rename_column(:black_book_places, :city_guide_id, :black_book_id)
  end
  
end
