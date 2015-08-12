# Keep XML attributes when converting XML to Hash.
module ActiveSupport
  class XMLConverter
    private
      def become_content?(value)
        value['type'] == 'file' || (value['__content__'] && (value.keys.size == 1 && value['__content__'].present?))
      end
  end
end

# Allows you to provide a Hash and a number of drilldown elements
# and return the final value if the whole chain exists, but without
# throwing an error if the chain has a broken link at some point.
#
# Could easily bomb:
# first_name = some_person_hash['Person]['Name]['FirstName']
#
# Doesn't bomb:
# first_name = some_person_hash.drilldown('Person Name FirstName')

Hash.class_eval do
  def drilldown drillees
    if (result = drillees.split(' ').inject(self){|res, el| res[el] ? res[el] : Hash.new })
      result.present? ? (result.unwrap_attribute) : nil
    end
  end
end

Array.class_eval do
  def drilldown drillee
    if (result = drillee.last)
      result.present? ? (result.unwrap_attribute) : nil
    end
  end
end

Object.class_eval do
  def unwrap_attribute
    self.is_a?(Hash) ? (self['__content__'] ? self['__content__'] : self) : self
  end
end


String.class_eval do
  # Add to_bool method to String.
  def to_bool
    return true   if self == true   || self =~ (/(true|t|yes|y|1)$/i)
    return false  if self == false  || self.blank? || self =~ (/(false|f|no|n|0)$/i)
    nil
  end
end


