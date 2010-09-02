module PostagesHelper
  def options_postages_for_select
    options_from_collection_for_select(Postage.all, 'id', 'name')
  end
end
