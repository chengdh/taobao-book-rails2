# Include hook code here
douban_configs = YAML.load_file(File.join(RAILS_ROOT, 'config/douban.yml'))

ENV['DOUBAN_APP_KEY'] = douban_configs[RAILS_ENV]['key'].to_s
ENV['DOUBAN_APP_SECRET'] = douban_configs[RAILS_ENV]['secret']
ENV['DOUBAN_BOOK_URL'] = douban_configs[RAILS_ENV]['book_url']
ENV['DOUBAN_BOOKS_URL'] = douban_configs[RAILS_ENV]['books_url']
