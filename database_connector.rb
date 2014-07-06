require 'yaml'
require 'mysql2'
require 'active_support/inflector'

module DatabaseConnector
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    # For simplicity, we are assuming ID will always be numeric
    def find(id)
      obj = self.new
      results = client.query("SELECT * FROM #{self.name.pluralize.underscore} WHERE id = #{id}")
      raise Exception and return unless results # for simplicity, we'll keep it to the generic Exception class
      results.first.each_pair { |key, value| obj.instance_variable_set("@#{key}", value) }
      obj
    end

    def all
      results = client.query("SELECT * FROM #{self.name.pluralize.underscore} ORDER BY id")
      collection = []
      results.each do |result|
        obj = self.new
        result.each_pair { |key, value| obj.instance_variable_set("@#{key}", value) }
        collection << obj 
      end
      collection
    end

    private
    def client
      @client ||= Mysql2::Client.new(host: config['host'], username: config['username'], password: config['password'], port: config['port'], database: config['database'])
    end

    def config
      begin
        @config ||= YAML.load_file('database.yml')
      rescue Errno::ENOENT => e
        e
      end
    end
  end
end
