class Diagram < ApplicationRecord


  def format_source_code_to_html
    formatted = source_code.gsub(/\n/, '<br/>')

    formatted.split("<br/>").map do |line|
      leading_spaces_size = line[/\A */].size
      "#{'&nbsp;'*leading_spaces_size}#{line}"
    end.join('<br/>')
  end
end
