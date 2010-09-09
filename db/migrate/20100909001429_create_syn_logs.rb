class CreateSynLogs < ActiveRecord::Migration
  def self.up
    #用户同步日志
    create_table :syn_logs,:id => false do |t|
      t.string :nick
      t.datetime :last_syn_time

      t.timestamps
    end
    #添加自定义主键
    execute "ALTER TABLE syn_logs ADD PRIMARY KEY (nick)"

  end

  def self.down
    drop_table :syn_logs
  end
end
