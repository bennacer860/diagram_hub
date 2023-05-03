class Diagram < ApplicationRecord


  def format_source_code_to_html
    return if source_code.nil?
    formatted = source_code.gsub(/\n/, '<br/>')

    formatted.split("<br/>").map do |line|
      leading_spaces_size = line[/\A */].size
      "#{'&nbsp;'*leading_spaces_size}#{line}"
    end.join('<br/>')
  end


  belongs_to :user
  validates :user_id, presence: true
  #before_save { self.email = email.downcase }

  
end
