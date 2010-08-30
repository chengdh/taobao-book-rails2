module LocalAreasHelper
  #省份列表
  def options_states_for_select
    options_from_collection_for_select(LocalArea.area_type_is(2), 'id', 'name')
  end
end
