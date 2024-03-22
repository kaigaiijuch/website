module YamlRecord
  class Base
    def initialize(*_keyword_args)
      raise NotImplementedError
    end

    class << self
      def data_file(file)
        @data_file = Pathname(file)
      end

      def all = datas

      def find(id)
        new(**datas[id])
      end

      private

      def datas
        @datas ||= YAML.safe_load(@data_file.read)
      end
    end
  end
end
