module ItemCatsHelper
 def options_books_for_select(parent_id)
    item_cats = ItemCat.find(parent_id).children
    options_from_collection_for_select(item_cats, 'id', 'name',item_cats.first.id)
  end
end
