module YamlRecord
  class Base
    def initialize(data)
      data.each do |key, value|
        instance_variable_set("@#{key}", value)
        self.class.define_method(key) { instance_variable_get("@#{key}") }
      end
    end

    class << self
      def data_file(file)
        @data_file = Pathname(file)
      end

      def all = datas

      def find(id)
        new(datas[id])
      end

      private

      def datas
        @datas ||= YAML.safe_load(@data_file.read)
      end
    end
  end
end
