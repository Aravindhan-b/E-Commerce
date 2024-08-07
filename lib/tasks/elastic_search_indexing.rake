desc 'This task indexes product in Elasticsearch'
task es_indexing: :environment do
  puts 'Indexing products'
  Product.__elasticsearch__.create_index!
  Product.__elasticsearch__.refresh_index!
  puts 'Products indexed'
end
