class AddDefaultToItemResourceCostFields < ActiveRecord::Migration[7.1]
  def change
    change_column_default :items, :animal_products_cost, 0
    change_column_default :items, :cloth_cost, 0
    change_column_default :items, :farmed_goods_cost, 0
    change_column_default :items, :food_cost, 0
    change_column_default :items, :foraged_goods_cost, 0
    change_column_default :items, :metal_cost, 0
    change_column_default :items, :stone_cost, 0
    change_column_default :items, :wood_cost, 0
  end
end
