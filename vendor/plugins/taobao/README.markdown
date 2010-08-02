# Taobao


The plugin enable easy integration with the [Taobao Open Platform](http://open.taobao.com/)
This is a fork of taweili/taobao,add api 2.0 support 
 
# Requirements

# Installation and configuration

Install the plugin

<pre>
cd myapp
script/plugin install git://github.com/taweili/taobao.git
</pre>

Create a config/taobao.yml

<pre>
development:
            app_key: 12012322
            app_secret: 42ab2d12a5bea25d1bc06ccd23123121daf
            rest_endpoint: http://gw.api.tbsandbox.com/router/rest
            auth_url: http://open.taobao.com/isv/authorize.php?appkey=

test:
            app_key: 12012322
            app_secret: 42ab2d12a5bea25d1bc06ccd23123121daf
            rest_endpoint: http://gw.api.tbsandbox.com/router/rest
            auth_url: http://open.taobao.com/isv/authorize.php?appkey=

production:
            app_key: 12012322
            app_secret: 42ab2d12a5bea25d1bc06ccd23123121daf
            rest_endpoint: http://gw.api.taobao.com/router/rest
            auth_url: http://container.open.taobao.com/container?appkey=

</pre>

That's it - you're done! :)

# Troubleshooting

# Copyright and license

Copyright (c) 2009 David Li, released under the MIT license
