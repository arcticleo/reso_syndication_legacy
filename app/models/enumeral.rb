class Enumeral < ActiveRecord::Base

  validates_presence_of :name
  validates_presence_of :type
  validates_uniqueness_of :name, :scope => :type

end

class ArchitecturalStyle < Enumeral
end

class Appliance < Enumeral
end

class AreaUnit < Enumeral
end

class CoolingSystem < Enumeral
end

class CurrencyPeriod < Enumeral
end

class ExpenseCategory < Enumeral
end

class ExteriorType < Enumeral
end

class FlooringMaterial < Enumeral
end

class ForeclosureStatus < Enumeral
end

class HeatingFuel < Enumeral
end

class HeatingSystem < Enumeral
end

class HomeFeature < Enumeral
end

class LicenseCategory < Enumeral
end

class ListingCategory < Enumeral
end

class ListingParticipantRole < Enumeral
end

class ListingStatus < Enumeral
end

class Parking < Enumeral
end

class PropertySubType < Enumeral
end

class PropertyType < Enumeral
end

class RoofMaterial < Enumeral
end

class RoomCategory < Enumeral
end

class SchoolCategory < Enumeral
end

class SourceProviderCategory < Enumeral
end

class View < Enumeral
end

