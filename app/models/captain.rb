class Captain < ActiveRecord::Base
  has_many :boats
  has_many :classifications, through: :boats

  def self.catamaran_operators
    self.joins(:boats, :classifications).where("classifications.name = 'Catamaran'").uniq
  end

  def self.sailors
    self.joins(:boats, :classifications).where("classifications.name = 'Sailboat'").uniq
  end

  def self.motorboaters
    self.joins(:boats, :classifications).where("classifications.name = 'Motorboat'").uniq
  end

  def self.talented_seamen
    self.sailors.where(id: self.motorboaters.pluck(:id))  
  end

  def self.non_sailors
    self.where.not("id IN (?)", self.sailors.pluck(:id)) 
  end

end