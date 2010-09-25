module ProvincesHelper
  #省份列表
  def options_states_for_select
    options_from_collection_for_select(Province.find(1).children, 'id', 'name')
  end

end
