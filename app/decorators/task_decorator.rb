class TaskDecorator < ApplicationDecorator
  delegate_all

  # @return [String]
  def dados_formatados
    object.data.except("url").map do |key, value|
      "#{(key == "preco") ? "Preço" : key.capitalize}: #{value}"
    end.join(" | ")
  end

  # @return [String]
  def status
    {
      "pending" => "Pendente",
      "processing" => "Em progresso",
      "successful" => "Concluída",
      "failed" => "Falha"
    }[object.status]
  end
end
