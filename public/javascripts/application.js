var com = {};
com.strongu = {};

//选择器,用于选择商品
com.strongu.Selector = Class.create();
com.strongu.Selector.prototype = {
	//缓存的id数组
	cached_ids: new Hash(),

	initialize: function(ids, el_select_des) {
		this.el_select_des = $(el_select_des);
		ids.each(function(id) {
			this.cached_ids.set(id, false);
		},
		this);
	},

	//给要选择的check_box添加监听事件
	//check_box_wrap 包含check_box的容器
	add_check_listener: function(check_box_wrap) {
		$(check_box_wrap).observe('click', this.check_listener.bindAsEventListener(this));

	},
	check_listener: function(evt) {
		el = Event.element(evt);
		if (el.type == 'checkbox') this.cached_ids.set(el.id, el.checked);
		this.update_select_des();
	},
	//选择/不选全部
	select_all: function(select_or_unselect) {
		this.cached_ids.each(function(pair) {
			this.cached_ids.set(pair.key, select_or_unselect);
			$(pair.key).checked = select_or_unselect;
		},
		this);
		this.update_select_des();
	},
	//更新选择信息
	update_select_des: function() {
		ret = "当前未选中任何书籍信息.";
		var select_count = this.selected_ids().size();
		if (select_count > 0) ret = "当前共选中" + select_count + "本书籍."
		this.el_select_des.update(ret);
	},
	//将选择的id转换为query string
	to_query_str: function() {
		var ret = new Hash({
			'items_ids[]' : this.selected_ids()
		});
		return ret.toQueryString();
	},
                      //得到已选定的id数组
        selected_ids : function() {
                var select_array = new Array();
                this.cached_ids.each(function(pair) {
                    if (pair.value) select_array.push(pair.key);
                    },
                    this);
                return select_array;

               }

};
//工具类
com.strongu.util = {};

//将给定对象转换为具备命名空间的hash
//例如 { a : 12}  ---> namespace[a] : 12
com.strongu.util.object_to_hash = function(obj,namespace) {
  var ret_hash = new Hash();
  for(attr in obj) {
    ret_hash.set(namespace + "[" + attr + "]",obj[attr])
  }
  return ret_hash;
};
