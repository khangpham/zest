require 'yaml'
require 'active_support/inflector'

module DatabaseConnector
  def self.included(base)
    base.extend(ClassMethods)
  end

  module ClassMethods
    # For simplicity, we are assuming ID will always be numeric
    def find(id)
      results = client.query("SELECT * FROM #{self.name.pluralize.underscore} WHERE id = #{id}")
      throw :dne unless results
      results.first.each_pair { |key, value| self.instance_variable_set("@#{key}", value) }
    end

    def all
      results = client.query("SELECT * FROM #{self.name.pluralize.underscore} ORDER BY id")
      results.each do |result|
        result.each_pair { |key, value| self.instance_variable_set("@#{key}", value) }
      end
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
