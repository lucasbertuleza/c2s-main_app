# Funções auxiliares
#
module Utils
  module_function

  # Retorna um objeto Struct a partir de uma hash, fazendo um "deep convert" em hashs mais internas.
  #
  # @param hash [Hash]
  #
  # @return [Struct]
  def Structurize(hash)
    structurized = hash.each_with_object({}) do |(key, value), memo|
      value = Structurize(value) if value.is_a?(Hash)
      memo[key.to_s.tr("-", "_").to_sym] = value
    end

    Struct.new(*structurized.keys).new(*structurized.values)
  end
end
