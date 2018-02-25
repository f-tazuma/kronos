class MPriceRateSeeder

  attr_accessor :data

  def self.run
    data = [
        {:id => 1, :name => "エンジニア", :cost_price => 8245, :selling_price => 10833},
        {:id => 2, :name => "デザイナ", :cost_price => 8245, :selling_price => 10833},
        {:id => 3, :name => "テスタ", :cost_price => 8245, :selling_price => 10833},
        {:id => 4, :name => "テスタ(アルバイト)", :cost_price => 8245, :selling_price => 1239}
    ]
    MPriceRate.delete_all
    MPriceRate.create(data)
  end
end