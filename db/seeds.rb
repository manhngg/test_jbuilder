print "Creating 8 regions... "
["北海道", "東北", "関東", "中部", "関西", "中国", "四国", "九州"].each do |region|
  Region.create!(name: region)
end
puts "✔ Done"

print "Creating 8 prefectures of Kanto region... "
kanto = Region.find_by_name("関東")
["東京都", "埼玉県", "茨城県", "和奈川健", "山梨県", "群馬県", "栃木県", "千葉県"].each do |prefecture|
  Prefecture.create!(
    region: kanto,
    name: prefecture
  )
end
puts "✔ Done"

print "Creating 10 wards (areas) of Tokyo... "
tokyo = Prefecture.find_by_name("東京都")
["渋谷区", "千代田区", "中央区", "港区", "新宿区", "品川区", "大田区", "中野区", "北区", "江戸川区"].each do |area|
  Area.create!(
    prefecture: tokyo,
    name: area
  )
end
puts "✔ Done"

print "Creating Shibuya store of Shibuya ward... "
shibuya = Area.find_by_name("渋谷区")
shibuya_store = Store.create!(
  # region: kanto,
  # prefecture: tokyo,
  area: shibuya,
  name: "渋谷店"
)
puts "✔ Done"
