class Person < ActiveRecord::Base
  belongs_to :gender
  
  def complete_name
    # Dr. Edwin E. 'Buzz' Aldrin Jr.

    self.nick_name.blank? ? nick_name = nil : nick_name = "'#{self.nick_name}'"
    self.middle_name.blank? ? middle_name = nil : middle_name = "#{self.middle_name.first.upcase}."
    [
      self.personal_title,
      self.first_name,
      middle_name,
      nick_name,
      self.last_name,
      self.suffix
    ].delete_if{|i| i.blank? }.join(' ')
  end
end
