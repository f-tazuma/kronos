class MDepartmentSeeder

  attr_accessor :data

  def self.run
    data = [{:id => 5007, :name => "ウェブ共同開発部", :path => "/事業本部/ウェブ共同開発部", :description => ""}]
    MDepartment.create(data)
  end
end