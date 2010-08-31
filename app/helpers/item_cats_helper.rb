module ItemCatsHelper
 def options_books_for_select(parent_id)
    options_from_collection_for_select(ItemCat.find(parent_id).children, 'id', 'name')
  end

end
