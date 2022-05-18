class RenameShopNameColumnToBooks < ActiveRecord::Migration[6.1]
  def change
    rename_column :books, :shop_name, :title
  end
end
