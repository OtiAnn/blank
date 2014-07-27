namespace :fake do
  desc 'create fake'
  task products: :environment do
    cats = Category.all
    10.times do |i|
      Product.create name: "產品 #{i}",
                     name_confirmation: "產品 #{i}",
                     desc: "敘述 #{i}",
                     price: rand(100)*100,
                     category: cats.sample
    end
  end
end