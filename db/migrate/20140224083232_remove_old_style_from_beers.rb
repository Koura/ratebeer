class RemoveOldStyleFromBeers < ActiveRecord::Migration
  def change
    change_table :beers do |t|
      t.remove :oldstyle_
    end
  end
end
