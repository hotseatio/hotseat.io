class RenameReccomendTextbookColumn < ActiveRecord::Migration[7.0]
  def change
    rename_column :reviews, :reccomend_textbook, :recommend_textbook
  end
end
